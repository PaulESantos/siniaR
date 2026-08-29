#' @title Interfaz para Estadísticas Ambientales del SINIA / MINAM
#' @description Funciones para listar indicadores, buscar, consultar fichas técnicas
#'   y descargar conjuntos de datos del Sistema Nacional de Información Ambiental (SINIA).
#'
#'   El Sistema Nacional de Información Ambiental (SINIA) es un sistema funcional
#'   del Sistema Nacional de Gestión Ambiental (SNGA), que comprende un conjunto de
#'   principios, normas, procedimientos, técnicas e instrumentos a fin de facilitar
#'   el acceso y uso de la información ambiental que las entidades que lo conforman
#'   generan o poseen, en el ámbito de sus respectivas competencias.
#'
#' @references
#'   Ministerio del Ambiente del Perú (MINAM). Sistema Nacional de Información Ambiental (SINIA).
#'   <https://sinia.minam.gob.pe/>
#'
#' @keywords internal
#' @name sinia_api
NULL

.sinia_base_url <- "https://wp.bex.pe/portal/wp-json/esam/v1/website"

`%||%` <- function(x, y) if (is.null(x)) y else x

#' Listar indicadores y estadísticas ambientales del SINIA
#'
#' Consulta el árbol temático y catálogo de indicadores del SINIA según el marco
#' ordenador especificado (por defecto MDEA - Marco para el Desarrollo de las
#' Estadísticas Ambientales de la ONU, o el marco sectorial propio de SINIA).
#'
#' @param marco Carácter indicando el marco ordenador: `"mdea"` (por defecto) o `"sinia"`.
#' @param solo_estadisticas Lógico. Si es `TRUE` (por defecto), solo retorna los ítems que
#'   corresponden a estadísticas finales con ID numérico de descarga. Si es `FALSE`,
#'   incluye también las categorías y niveles superiores del árbol temático.
#'
#' @return Un [tibble::tibble] con las siguientes columnas:
#' \describe{
#'   \item{id}{Identificador numérico único de la estadística (entero).}
#'   \item{numeral}{Código numeral de clasificación jerárquica (ej. `"1.1.1"`).}
#'   \item{nombre}{Nombre oficial del indicador o estadística ambiental.}
#'   \item{nivel}{Nivel jerárquico dentro del árbol temático (entero).}
#'   \item{clasificador_id}{Identificador del clasificador temático.}
#'   \item{padre_id}{Identificador del clasificador padre en la jerarquía.}
#'   \item{marco}{Marco ordenador consultado (`"mdea"` o `"sinia"`).}
#' }
#' @export
#'
#' @seealso [sinia_buscar()], [sinia_ficha()], [sinia_datos()]
#' @examplesIf curl::has_internet()
#' # Listar todos los indicadores del marco MDEA (ONU)
#' ind_mdea <- sinia_indicadores(marco = "mdea")
#' head(ind_mdea)
#'
#' # Listar bajo el marco sectorial SINIA
#' ind_sinia <- sinia_indicadores(marco = "sinia")
#' head(ind_sinia)
sinia_indicadores <- function(marco = c("mdea", "sinia"), solo_estadisticas = TRUE) {
  marco <- match.arg(marco)
  url <- sprintf("%s/marcos-ordenadores/%s/indice-estadisticas", .sinia_base_url, marco)

  res <- tryCatch(
    jsonlite::fromJSON(url, simplifyVector = FALSE),
    error = function(e) {
      cli::cli_abort(c(
        "No se pudo conectar con el servidor de estadisticas del SINIA.",
        "x" = conditionMessage(e),
        "i" = "Verifica tu conexion a internet o la disponibilidad del servicio."
      ))
    }
  )

  items <- res$data$items
  if (is.null(items) || length(items) == 0) {
    return(tibble::tibble(
      id = integer(),
      numeral = character(),
      nombre = character(),
      nivel = integer(),
      clasificador_id = integer(),
      padre_id = integer(),
      marco = character()
    ))
  }

  if (solo_estadisticas) {
    items <- Filter(function(x) !is.null(x$estadisticaId), items)
  }

  if (length(items) == 0) {
    return(tibble::tibble(
      id = integer(),
      numeral = character(),
      nombre = character(),
      nivel = integer(),
      clasificador_id = integer(),
      padre_id = integer(),
      marco = character()
    ))
  }

  ids <- vapply(items, function(x) if (is.null(x$estadisticaId)) NA_integer_ else as.integer(x$estadisticaId), integer(1))
  num <- vapply(items, function(x) if (is.null(x$numeral)) NA_character_ else as.character(x$numeral), character(1))
  nom <- vapply(items, function(x) if (is.null(x$nombre)) NA_character_ else as.character(x$nombre), character(1))
  niv <- vapply(items, function(x) if (is.null(x$nivel)) NA_integer_ else as.integer(x$nivel), integer(1))
  cid <- vapply(items, function(x) if (is.null(x$clasificadorId)) NA_integer_ else as.integer(x$clasificadorId), integer(1))
  pid <- vapply(items, function(x) if (is.null(x$clasificadorPadreId)) NA_integer_ else as.integer(x$clasificadorPadreId), integer(1))

  tibble::tibble(
    id = ids,
    numeral = num,
    nombre = nom,
    nivel = niv,
    clasificador_id = cid,
    padre_id = pid,
    marco = marco
  )
}

#' Buscar estadísticas ambientales por palabra clave
#'
#' Realiza una búsqueda insensible a mayúsculas, minúsculas y tildes dentro del catálogo
#' oficial de indicadores del SINIA.
#'
#' @param query Cadena de texto con la palabra o expresión a buscar (ej. `"temperatura"`,
#'   `"pm10"`, `"glaciar"`, `"bosque"`, `"residuos"`).
#' @param marco Carácter indicando el marco ordenador: `"mdea"` (por defecto) o `"sinia"`.
#'
#' @return Un [tibble::tibble] con los indicadores que coinciden con el término de búsqueda,
#'   conservando la estructura de [sinia_indicadores()].
#' @export
#'
#' @seealso [sinia_indicadores()], [sinia_ficha()], [sinia_datos()]
#' @examplesIf curl::has_internet()
#' # Buscar indicadores sobre temperatura
#' sinia_buscar("temperatura")
#'
#' # Buscar indicadores sobre calidad del aire
#' sinia_buscar("pm10")
#'
#' # Buscar indicadores sobre cobertura forestal
#' sinia_buscar("bosque")
sinia_buscar <- function(query, marco = c("mdea", "sinia")) {
  if (missing(query) || !is.character(query) || length(query) != 1 || is.na(query) || nchar(trimws(query)) == 0) {
    cli::cli_abort(c(
      "{.arg query} debe ser una cadena de texto no vacia.",
      "x" = "Se recibio un valor invalido o vacio.",
      "i" = "Ejemplo: {.code sinia_buscar(\"temperatura\")}"
    ))
  }

  marco <- match.arg(marco)
  df <- sinia_indicadores(marco = marco, solo_estadisticas = TRUE)

  if (nrow(df) == 0) {
    return(df)
  }

  # Normalizar caracteres para busqueda insensible a acentos
  normalizar <- function(x) {
    tolower(iconv(x, to = "ASCII//TRANSLIT"))
  }

  q_norm <- normalizar(query)
  nombres_norm <- normalizar(df$nombre)

  # fixed = TRUE evita fallos si query incluye parentesis o caracteres especiales de regex
  coincidencias <- grepl(q_norm, nombres_norm, fixed = TRUE)
  res <- df[coincidencias, ]

  if (nrow(res) == 0) {
    cli::cli_inform(c(
      "!" = "No se encontraron estadisticas que coincidan con {.val {query}} en el marco {.val {marco}}.",
      "i" = "Prueba con terminos mas generales como {.val temperatura}, {.val agua}, {.val aire} o {.val bosque}."
    ))
  }

  res
}

#' Obtener la Ficha Técnica de una estadística del SINIA
#'
#' Consulta y estructura los metadatos oficiales (definición, fuente, fórmula de cálculo,
#' metodología, periodicidad, unidad de medida y responsables institucionales) de una
#' estadística ambiental registrada en el SINIA.
#'
#' @param id Identificador numérico de la estadística (ej. `1` para temperatura promedio anual).
#'
#' @return Un objeto de clase `sinia_ficha` (lista estructurada) con los siguientes campos:
#' \describe{
#'   \item{id}{Identificador numérico único de la estadística.}
#'   \item{numero}{Código numeral asignado en el SINIA.}
#'   \item{nombre}{Nombre oficial de la estadística ambiental.}
#'   \item{finalidad}{Objetivo o propósito de la medición.}
#'   \item{descripcion}{Fundamentación conceptual y descripción técnica.}
#'   \item{unidad_medida}{Unidad física o métrica de medición (ej. `°C`, `ug/m3`, `ha`, `\%`).}
#'   \item{formula_calculo}{Ecuación o expresión matemática utilizada para el cálculo.}
#'   \item{metodologia_calculo}{Procedimiento metodológico de recopilación y procesamiento.}
#'   \item{fuente}{Institución u organismo oficial generador (ej. SENAMHI, SERNANP, INEI, OEFA).}
#'   \item{unidad_organica}{Dirección o unidad orgánica responsable de la información.}
#'   \item{url_fuente}{Enlace web al portal o repositorio de la fuente original.}
#'   \item{periodicidad_generacion}{Frecuencia de generación del dato (mensual, anual, etc.).}
#'   \item{periodicidad_entrega}{Frecuencia de actualización en el SINIA.}
#'   \item{periodo_serie}{Rango de años comprendido en la serie histórica (ej. `2014-2024`).}
#'   \item{ambito_geografico}{Desagregación territorial (Nacional, Departamental, Provincial, etc.).}
#'   \item{limitaciones}{Restricciones o consideraciones sobre los datos.}
#'   \item{relacion_objetivos_nacionales}{Alineación con políticas y objetivos ambientales nacionales.}
#'   \item{relacion_iniciativas_internacionales}{Alineación con ODS u otros compromisos globales.}
#'   \item{datos_contacto}{Información de contacto institucional del generador.}
#'   \item{correo_electronico}{Correo electrónico de contacto.}
#'   \item{clasificacion_mdea}{Código y nombre del componente/subcomponente MDEA.}
#'   \item{clasificacion_sinia}{Clasificación temática propia del SINIA.}
#'   \item{titulo_tabla}{Título formal de la matriz tabular de datos.}
#'   \item{nota_tabla}{Notas técnicas y aclaratorias sobre los valores numéricos.}
#'   \item{fuente_tabla}{Texto de fuente que acompaña la tabla.}
#'   \item{elaboracion_tabla}{Texto de elaboración institucional.}
#' }
#'
#' @export
#'
#' @seealso [sinia_datos()], [sinia_estadistica()], [sinia_indicadores()]
#' @examplesIf curl::has_internet()
#' # Obtener la ficha tecnica de Temperatura Promedio Anual (ID = 1)
#' ficha <- sinia_ficha(1)
#' print(ficha)
#'
#' # Consultar campos especificos
#' ficha$fuente
#' ficha$unidad_medida
#' ficha$formula_calculo
sinia_ficha <- function(id) {
  if (missing(id) || length(id) != 1 || is.na(id) || (!is.numeric(id) && !is.character(id))) {
    cli::cli_abort(c(
      "{.arg id} debe ser un unico identificador numerico o texto.",
      "x" = "Se recibio un valor invalido.",
      "i" = "Ejemplo valido: {.code sinia_ficha(id = 1)}"
    ))
  }

  url <- sprintf("%s/estadisticas/%s", .sinia_base_url, as.character(id))
  res <- tryCatch(
    jsonlite::fromJSON(url, simplifyVector = FALSE),
    error = function(e) {
      cli::cli_abort(c(
        sprintf("No se pudo obtener la informacion de la estadistica ID: %s.", id),
        "x" = conditionMessage(e),
        "i" = "Verifica tu conexion a internet o que el ID exista en {.fn sinia_indicadores}."
      ))
    }
  )

  d <- res$data
  if (is.null(d)) {
    cli::cli_abort(c(
      "No se encontraron datos para la estadistica con ID {.val {id}}.",
      "i" = "Consulta los IDs disponibles con {.code sinia_indicadores()}."
    ))
  }

  ficha <- list(
    id = d$id,
    numero = d$numero,
    nombre = d$nombre,
    finalidad = d$finalidad,
    descripcion = d$descripcion,
    unidad_medida = d$unidadMedida,
    formula_calculo = d$formulaCalculo,
    metodologia_calculo = d$metodologiaCalculo,
    fuente = d$fuente,
    unidad_organica = d$unidadOrganicaGeneradora,
    url_fuente = d$url,
    periodicidad_generacion = d$periodicidadGeneracion,
    periodicidad_entrega = d$periodicidadEntrega,
    periodo_serie = d$periodoSerieTiempo,
    ambito_geografico = d$ambitoGeografico,
    limitaciones = d$limitaciones,
    relacion_objetivos_nacionales = d$relacionObjetivosNacionales,
    relacion_iniciativas_internacionales = d$relacionIniciativasInternacionales,
    datos_contacto = d$datosContacto,
    correo_electronico = d$correoElectronico,
    clasificacion_mdea = d$clasificacionMdea,
    clasificacion_sinia = d$clasificacionSinia,
    titulo_tabla = d$presentacionTablaTitulo,
    nota_tabla = d$presentacionTablaNota,
    fuente_tabla = d$presentacionTablaFuente,
    elaboracion_tabla = d$presentacionTablaElaboracion
  )

  class(ficha) <- c("sinia_ficha", "list")
  ficha
}

#' Imprimir ficha técnica de SINIA
#'
#' @param x Objeto de clase `sinia_ficha`.
#' @param ... Argumentos adicionales pasados a otros métodos.
#'
#' @return Retorna el objeto `x` de forma invisible.
#' @export
print.sinia_ficha <- function(x, ...) {
  cli::cli_h1("Ficha Tecnica: {x$nombre}")
  cli::cli_bullets(c(
    "*" = "{.strong ID:} {x$id} (Numero: {x$numero})",
    "*" = "{.strong Fuente:} {x$fuente %||% 'No especificada'}",
    "*" = "{.strong Unidad de Medida:} {x$unidad_medida %||% 'No especificada'}",
    "*" = "{.strong Periodo de Serie:} {x$periodo_serie %||% 'No especificado'}",
    "*" = "{.strong Ambito Geografico:} {gsub('\n', ', ', x$ambito_geografico %||% 'No especificado')}",
    "*" = "{.strong Clasificacion MDEA:} {x$clasificacion_mdea %||% 'N/A'}"
  ))

  if (!is.null(x$descripcion) && nchar(trimws(x$descripcion)) > 0) {
    cli::cli_h2("Descripcion")
    cli::cli_text(x$descripcion)
  }

  if (!is.null(x$formula_calculo) && nchar(trimws(x$formula_calculo)) > 0) {
    cli::cli_h2("Formula de Calculo")
    cli::cli_text(x$formula_calculo)
  }

  if (!is.null(x$metodologia_calculo) && nchar(trimws(x$metodologia_calculo)) > 0) {
    cli::cli_h2("Metodologia")
    cli::cli_text(x$metodologia_calculo)
  }

  if (!is.null(x$nota_tabla) && nchar(trimws(x$nota_tabla)) > 0) {
    cli::cli_alert_info("Nota: {x$nota_tabla}")
  }

  invisible(x)
}

#' Descargar datos tabulares de una estadística del SINIA
#'
#' Extrae la matriz de datos de una estadística ambiental del SINIA, procesa
#' la tabla y la retorna en formato [tibble::tibble] limpio y estructurado.
#'
#' @param id Identificador numérico de la estadística (ej. `1` para temperatura).
#' @param pivot Formato de salida de la tabla:
#'   * `"wide"` (por defecto): Mantiene columnas separadas por cada año o periodo histórico.
#'   * `"long"`: Transforma las columnas temporales en formato largo (*tidy*), generando las
#'     columnas `anio` y `valor` listas para `ggplot2` y `dplyr`.
#'   * `"raw"`: Retorna la matriz de texto original sin conversión automática de tipos.
#' @param clean_names Lógico. Si es `TRUE` (por defecto), normaliza los nombres de columnas a
#'   minúsculas y sin caracteres especiales.
#'
#' @return Un [tibble::tibble] con los datos de la estadística. Además, contiene los siguientes
#'   atributos con metadatos asociados:
#' \describe{
#'   \item{`attr(.,"sinia_id")`}{ID numérico de la estadística.}
#'   \item{`attr(.,"sinia_nombre")`}{Nombre oficial del indicador.}
#'   \item{`attr(.,"sinia_fuente")`}{Institución generadora oficial.}
#'   \item{`attr(.,"sinia_unidad")`}{Unidad de medida.}
#'   \item{`attr(.,"sinia_nota")`}{Nota técnica o metodológica de la tabla.}
#' }
#' @export
#'
#' @seealso [sinia_ficha()], [sinia_estadistica()], [sinia_buscar()]
#' @examplesIf curl::has_internet()
#' # Formato ancho (columnas por anio)
#' df_wide <- sinia_datos(1)
#' head(df_wide)
#'
#' # Formato largo (apilado para analisis y graficos con ggplot2)
#' df_long <- sinia_datos(1, pivot = "long")
#' head(df_long)
sinia_datos <- function(id, pivot = c("wide", "long", "raw"), clean_names = TRUE) {
  pivot <- match.arg(pivot)

  if (missing(id) || length(id) != 1 || is.na(id) || (!is.numeric(id) && !is.character(id))) {
    cli::cli_abort(c(
      "{.arg id} debe ser un unico identificador numerico o texto.",
      "x" = "Se recibio un valor invalido.",
      "i" = "Ejemplo valido: {.code sinia_datos(id = 1)}"
    ))
  }

  url <- sprintf("%s/estadisticas/%s", .sinia_base_url, as.character(id))
  res <- tryCatch(
    jsonlite::fromJSON(url, simplifyVector = FALSE),
    error = function(e) {
      cli::cli_abort(c(
        sprintf("No se pudo obtener la informacion de la estadistica ID: %s.", id),
        "x" = conditionMessage(e),
        "i" = "Verifica tu conexion a internet o que el ID exista en {.fn sinia_indicadores}."
      ))
    }
  )

  d <- res$data
  raw_rows <- d$datos

  if (is.null(raw_rows) || length(raw_rows) <= 1) {
    cli::cli_warn("La estadistica con ID {id} no contiene filas de datos.")
    return(tibble::tibble())
  }

  # Extraer encabezados de la fila 1
  header <- vapply(raw_rows[[1]], function(x) {
    val <- x$v
    if (is.null(val) || is.na(val) || nchar(trimws(as.character(val))) == 0) "columna" else as.character(val)
  }, FUN.VALUE = character(1))

  # Asegurar nombres unicos en la cabecera
  header <- make.unique(header, sep = "_")

  # Extraer matriz de datos de forma eficiente
  n_cols <- length(header)
  data_rows <- raw_rows[-1]

  col_data <- vector("list", n_cols)
  for (j in seq_len(n_cols)) {
    col_data[[j]] <- vapply(data_rows, function(r) {
      if (j > length(r)) return(NA_character_)
      val <- r[[j]]$v
      if (is.null(val) || identical(val, "\u2026") || identical(val, "...") || identical(val, "-") || identical(val, "s/d") || identical(val, "ND")) {
        NA_character_
      } else {
        as.character(val)
      }
    }, character(1))
  }
  names(col_data) <- header

  tbl <- tibble::as_tibble(col_data)

  if (pivot == "raw") {
    return(tbl)
  }

  # Convertir columnas numericas con soporte para coma decimal
  year_pattern <- "^[xX]?([0-9]{4})$"
  is_year_col <- grepl(year_pattern, colnames(tbl))

  for (col in colnames(tbl)) {
    vals <- tbl[[col]]
    non_na <- vals[!is.na(vals)]
    if (length(non_na) > 0) {
      # Limpiar posibles comas decimales y espacios
      clean_vals <- gsub(" ", "", vals)
      clean_vals <- gsub(",", ".", clean_vals)
      num_vals <- suppressWarnings(as.numeric(clean_vals))
      
      non_na_num <- num_vals[!is.na(vals)]
      if (sum(!is.na(non_na_num)) >= (0.8 * length(non_na))) {
        tbl[[col]] <- num_vals
      }
    }
  }

  if (pivot == "long") {
    if (any(is_year_col)) {
      year_cols <- colnames(tbl)[is_year_col]
      id_cols <- setdiff(colnames(tbl), year_cols)

      long_list <- lapply(year_cols, function(y) {
        clean_year <- as.integer(sub(year_pattern, "\\1", y))
        sub_df <- tbl[, id_cols, drop = FALSE]
        sub_df$anio <- clean_year
        sub_df$valor <- as.numeric(tbl[[y]])
        sub_df
      })

      tbl <- tibble::as_tibble(do.call(rbind, long_list))
    } else {
      cli::cli_inform(c(
        "i" = "La tabla no contiene columnas de anio reconocibles para pivotar a {.val long}.",
        "i" = "Se mantiene la estructura original de columnas."
      ))
    }
  }

  if (clean_names) {
    colnames(tbl) <- tolower(iconv(colnames(tbl), to = "ASCII//TRANSLIT"))
    colnames(tbl) <- gsub("[^a-z0-9_]+", "_", colnames(tbl))
    colnames(tbl) <- gsub("^_|_$", "", colnames(tbl))
  }

  # Anadir atributos con metadatos relevantes
  attr(tbl, "sinia_id") <- d$id
  attr(tbl, "sinia_nombre") <- d$nombre
  attr(tbl, "sinia_fuente") <- d$fuente
  attr(tbl, "sinia_unidad") <- d$unidadMedida
  attr(tbl, "sinia_nota") <- d$presentacionTablaNota

  tbl
}

#' Obtener datos y ficha técnica completa de una estadística del SINIA
#'
#' Descarga tanto los metadatos estructurados de la ficha técnica como el conjunto de datos
#' tabulares en un único objeto compuesto de clase `sinia_estadistica`.
#'
#' @param id Identificador numérico de la estadística (ej. `1` para temperatura).
#' @param pivot Formato de salida de los datos (`"wide"` o `"long"`).
#'
#' @return Un objeto de clase `sinia_estadistica` (lista S3) con los siguientes elementos:
#' \describe{
#'   \item{id}{Identificador numérico de la estadística.}
#'   \item{nombre}{Nombre oficial del indicador.}
#'   \item{ficha}{Objeto de clase `sinia_ficha` con todos los metadatos oficiales.}
#'   \item{datos}{Un [tibble::tibble] con los datos tabulares en el formato solicitado.}
#' }
#' @export
#'
#' @seealso [sinia_ficha()], [sinia_datos()]
#' @examplesIf curl::has_internet()
#' est <- sinia_estadistica(1, pivot = "long")
#' # Consultar ficha
#' est$ficha
#' # Consultar datos
#' head(est$datos)
sinia_estadistica <- function(id, pivot = c("wide", "long")) {
  pivot <- match.arg(pivot)
  ficha <- sinia_ficha(id)
  datos <- sinia_datos(id, pivot = pivot)

  obj <- list(
    id = id,
    nombre = ficha$nombre,
    ficha = ficha,
    datos = datos
  )

  class(obj) <- c("sinia_estadistica", "list")
  obj
}

#' Imprimir objeto de estadística SINIA
#'
#' @param x Objeto de clase `sinia_estadistica`.
#' @param ... Argumentos adicionales pasados a otros métodos.
#'
#' @return Retorna el objeto `x` de forma invisible.
#' @export
print.sinia_estadistica <- function(x, ...) {
  cli::cli_h1("Estadistica SINIA: {x$nombre}")
  cli::cli_bullets(c(
    "*" = "{.strong ID:} {x$id}",
    "*" = "{.strong Fuente:} {x$ficha$fuente %||% 'No especificada'}",
    "*" = "{.strong Unidad de Medida:} {x$ficha$unidad_medida %||% 'No especificada'}",
    "*" = "{.strong Registros de datos:} {nrow(x$datos)} filas x {ncol(x$datos)} columnas"
  ))
  cli::cli_text("")
  cli::cli_h2("Vista previa de los datos")
  print(utils::head(x$datos, 6))
  invisible(x)
}
