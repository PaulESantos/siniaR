#' @title Interfaz para Estadisticas Ambientales del SINIA / MINAM
#' @description Funciones para listar indicadores, buscar, consultar fichas tecnicas
#'   y descargar conjuntos de datos del Sistema Nacional de Informacion Ambiental (SINIA).
#' @name sinia_api
NULL

.sinia_base_url <- "https://wp.bex.pe/portal/wp-json/esam/v1/website"

`%||%` <- function(x, y) if (is.null(x)) y else x

#' Listar indicadores y estadisticas ambientales del SINIA
#'
#' Consulta el arbol tematico y catalogo de indicadores del SINIA segun el marco
#' ordenador especificado (por defecto MDEA - Marco para el Desarrollo de las
#' Estadisticas Ambientales de la ONU).
#'
#' @param marco Caracter indicando el marco ordenador: `"mdea"` (por defecto) o `"sinia"`.
#' @param solo_estadisticas Logico. Si es `TRUE` (por defecto), solo retorna los items que
#'   corresponden a estadisticas finales con ID de descarga.
#'
#' @return Un [tibble::tibble] con el listado de indicadores, codigos numerales, nombres
#'   y jerarquia tematica.
#' @export
#'
#' @examples
#' \dontrun{
#' # Listar todos los indicadores del marco MDEA
#' ind <- sinia_indicadores()
#' head(ind)
#' }
sinia_indicadores <- function(marco = c("mdea", "sinia"), solo_estadisticas = TRUE) {
  marco <- match.arg(marco)
  url <- sprintf("%s/marcos-ordenadores/%s/indice-estadisticas", .sinia_base_url, marco)

  res <- tryCatch(
    jsonlite::fromJSON(url, simplifyVector = FALSE),
    error = function(e) {
      cli::cli_abort(c(
        "No se pudo conectar con el servidor de estadisticas del SINIA.",
        "i" = "Verifica tu conexion a internet o la disponibilidad del servicio.",
        "x" = conditionMessage(e)
      ))
    }
  )

  items <- res$data$items
  if (is.null(items) || length(items) == 0) {
    return(tibble::tibble())
  }

  if (solo_estadisticas) {
    items <- Filter(function(x) !is.null(x$estadisticaId), items)
  }

  out <- lapply(items, function(x) {
    tibble::tibble(
      id = if (is.null(x$estadisticaId)) NA_integer_ else as.integer(x$estadisticaId),
      numeral = if (is.null(x$numeral)) NA_character_ else as.character(x$numeral),
      nombre = if (is.null(x$nombre)) NA_character_ else as.character(x$nombre),
      nivel = if (is.null(x$nivel)) NA_integer_ else as.integer(x$nivel),
      clasificador_id = if (is.null(x$clasificadorId)) NA_integer_ else as.integer(x$clasificadorId),
      padre_id = if (is.null(x$clasificadorPadreId)) NA_integer_ else as.integer(x$clasificadorPadreId),
      marco = marco
    )
  })

  do.call(rbind, out)
}

#' Buscar estadisticas ambientales por palabra clave
#'
#' Realiza una busqueda insensible a mayusculas y tildes dentro del catalogo
#' de indicadores del SINIA.
#'
#' @param query Cadena de texto con la palabra o expresion a buscar (ej. `"temperatura"`, `"pm10"`, `"glaciar"`, `"bosque"`).
#' @param marco Caracter indicando el marco ordenador: `"mdea"` (por defecto) o `"sinia"`.
#'
#' @return Un [tibble::tibble] con los indicadores que coinciden con la busqueda.
#' @export
#'
#' @examples
#' \dontrun{
#' # Buscar indicadores sobre temperatura
#' sinia_buscar("temperatura")
#'
#' # Buscar indicadores sobre calidad del aire
#' sinia_buscar("pm10")
#' }
sinia_buscar <- function(query, marco = c("mdea", "sinia")) {
  if (missing(query) || !is.character(query) || length(query) == 0 || nchar(query) == 0) {
    cli::cli_abort("Debes especificar un termino de busqueda en {.arg query}.")
  }

  marco <- match.arg(marco)
  df <- sinia_indicadores(marco = marco, solo_estadisticas = TRUE)

  # Normalizar caracteres para busqueda insensible a acentos
  normalizar <- function(x) {
    tolower(iconv(x, to = "ASCII//TRANSLIT"))
  }

  q_norm <- normalizar(query)
  nombres_norm <- normalizar(df$nombre)

  coincidencias <- grepl(q_norm, nombres_norm, fixed = FALSE)
  res <- df[coincidencias, ]

  if (nrow(res) == 0) {
    cli::cli_inform(c("!" = "No se encontraron estadisticas que coincidan con '{query}'."))
  }

  res
}

#' Obtener la Ficha Tecnica de una estadistica del SINIA
#'
#' Consulta y estructura los metadatos oficiales (definicion, fuente, formula,
#' metodologia, periodicidad y responsables) de una estadistica ambiental.
#'
#' @param id Identificador numerico de la estadistica (ej. `1` para temperatura promedio anual).
#'
#' @return Un objeto de clase `sinia_ficha` con los metadatos de la estadistica.
#' @export
#'
#' @examples
#' \dontrun{
#' ficha <- sinia_ficha(1)
#' print(ficha)
#' }
sinia_ficha <- function(id) {
  if (missing(id) || !is.numeric(id) && !is.character(id)) {
    cli::cli_abort("Debes especificar un {.arg id} valido (numerico o entero).")
  }

  url <- sprintf("%s/estadisticas/%s", .sinia_base_url, id)
  res <- tryCatch(
    jsonlite::fromJSON(url, simplifyVector = FALSE),
    error = function(e) {
      cli::cli_abort(c(
        sprintf("No se pudo obtener la informacion de la estadistica ID: %s.", id),
        "x" = conditionMessage(e)
      ))
    }
  )

  d <- res$data
  if (is.null(d)) {
    cli::cli_abort("No se encontraron datos para la estadistica con ID {id}.")
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

#' Descargar datos tabulares de una estadistica del SINIA
#'
#' Extrae la serie de datos de una estadistica ambiental del SINIA, procesa
#' la matriz tabular y la retorna en formato [tibble::tibble] limpio.
#'
#' @param id Identificador numerico de la estadistica (ej. `1` para temperatura).
#' @param pivot Formato de salida de la tabla:
#'   * `"wide"` (por defecto): Mantiene columnas por cada periodo/anio.
#'   * `"long"`: Transforma las columnas anuales en formato largo (`anio` y `valor`).
#'   * `"raw"`: Retorna la estructura cruda de caracteres sin conversion automatica de tipos.
#' @param clean_names Logico. Si es `TRUE` (por defecto), normaliza los nombres de columnas a minusculas y sin caracteres especiales.
#'
#' @return Un [tibble::tibble] con los datos de la estadistica.
#' @export
#'
#' @examples
#' \dontrun{
#' # Formato ancho (columnas por anio)
#' df_wide <- sinia_datos(1)
#' head(df_wide)
#'
#' # Formato largo (apilado para graficos)
#' df_long <- sinia_datos(1, pivot = "long")
#' head(df_long)
#' }
sinia_datos <- function(id, pivot = c("wide", "long", "raw"), clean_names = TRUE) {
  pivot <- match.arg(pivot)

  if (missing(id) || !is.numeric(id) && !is.character(id)) {
    cli::cli_abort("Debes especificar un {.arg id} valido (numerico o entero).")
  }

  url <- sprintf("%s/estadisticas/%s", .sinia_base_url, id)
  res <- tryCatch(
    jsonlite::fromJSON(url, simplifyVector = FALSE),
    error = function(e) {
      cli::cli_abort(c(
        sprintf("No se pudo obtener la informacion de la estadistica ID: %s.", id),
        "x" = conditionMessage(e)
      ))
    }
  )

  d <- res$data
  raw_rows <- d$datos

  if (is.null(raw_rows) || length(raw_rows) == 0) {
    cli::cli_warn("La estadistica con ID {id} no contiene filas de datos.")
    return(tibble::tibble())
  }

  # Extraer encabezados de la fila 1
  header <- vapply(raw_rows[[1]], function(x) {
    val <- x$v
    if (is.null(val) || is.na(val)) "columna" else as.character(val)
  }, FUN.VALUE = character(1))

  # Extraer filas de datos
  data_list <- lapply(raw_rows[-1], function(row) {
    lapply(row, function(cell) {
      val <- cell$v
      if (is.null(val) || identical(val, "\u2026") || identical(val, "...") || identical(val, "-")) {
        NA
      } else {
        val
      }
    })
  })

  df_rows <- lapply(data_list, function(r) {
    as.data.frame(r, stringsAsFactors = FALSE, col.names = header)
  })

  df <- do.call(rbind, df_rows)
  tbl <- tibble::as_tibble(df)

  if (pivot == "raw") {
    return(tbl)
  }

  # Convertir columnas numericas si es posible
  year_pattern <- "^[xX]?([0-9]{4})$"
  is_year_col <- grepl(year_pattern, colnames(tbl))

  for (col in colnames(tbl)) {
    vals <- tbl[[col]]
    num_vals <- suppressWarnings(as.numeric(vals))
    # Si la mayoria de no-NA se convierten bien a numeros, convertir
    if (!all(is.na(vals)) && sum(!is.na(num_vals)) >= (0.8 * sum(!is.na(vals)))) {
      tbl[[col]] <- num_vals
    }
  }

  if (pivot == "long" && any(is_year_col)) {
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

#' Obtener datos y ficha tecnica completa de una estadistica del SINIA
#'
#' Descarga tanto los metadatos de la ficha tecnica como el conjunto de datos
#' estructurado en un unico objeto `sinia_estadistica`.
#'
#' @param id Identificador numerico de la estadistica (ej. `1` para temperatura).
#' @param pivot Formato de salida de los datos (`"wide"` o `"long"`).
#'
#' @return Un objeto de clase `sinia_estadistica` que contiene:
#'   * `ficha`: Objeto `sinia_ficha` con los metadatos.
#'   * `datos`: [tibble::tibble] con los datos tabulares.
#' @export
#'
#' @examples
#' \dontrun{
#' est <- sinia_estadistica(1)
#' est$ficha
#' head(est$datos)
#' }
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
