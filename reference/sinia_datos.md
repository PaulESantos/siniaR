# Descargar datos tabulares de una estadística del SINIA

Extrae la matriz de datos de una estadística ambiental del SINIA,
procesa la tabla y la retorna en formato
[tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
limpio y estructurado.

## Usage

``` r
sinia_datos(id, pivot = c("wide", "long", "raw"), clean_names = TRUE)
```

## Arguments

- id:

  Identificador numérico de la estadística (ej. `1` para temperatura).

- pivot:

  Formato de salida de la tabla:

  - `"wide"` (por defecto): Mantiene columnas separadas por cada año o
    periodo histórico.

  - `"long"`: Transforma las columnas temporales en formato largo
    (*tidy*), generando las columnas `anio` y `valor` listas para
    `ggplot2` y `dplyr`.

  - `"raw"`: Retorna la matriz de texto original sin conversión
    automática de tipos.

- clean_names:

  Lógico. Si es `TRUE` (por defecto), normaliza los nombres de columnas
  a minúsculas y sin caracteres especiales.

## Value

Un [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
con los datos de la estadística. Además, contiene los siguientes
atributos con metadatos asociados:

- `attr(.,"sinia_id")`:

  ID numérico de la estadística.

- `attr(.,"sinia_nombre")`:

  Nombre oficial del indicador.

- `attr(.,"sinia_fuente")`:

  Institución generadora oficial.

- `attr(.,"sinia_unidad")`:

  Unidad de medida.

- `attr(.,"sinia_nota")`:

  Nota técnica o metodológica de la tabla.

## See also

[`sinia_ficha()`](https://paulesantos.github.io/siniaR/reference/sinia_ficha.md),
[`sinia_estadistica()`](https://paulesantos.github.io/siniaR/reference/sinia_estadistica.md),
[`sinia_buscar()`](https://paulesantos.github.io/siniaR/reference/sinia_buscar.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Formato ancho (columnas por anio)
df_wide <- sinia_datos(1)
head(df_wide)

# Formato largo (apilado para analisis y graficos con ggplot2)
df_long <- sinia_datos(1, pivot = "long")
head(df_long)
} # }
```
