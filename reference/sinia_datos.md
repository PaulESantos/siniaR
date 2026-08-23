# Descargar datos tabulares de una estadistica del SINIA

Extrae la serie de datos de una estadistica ambiental del SINIA, procesa
la matriz tabular y la retorna en formato
[tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
limpio.

## Usage

``` r
sinia_datos(id, pivot = c("wide", "long", "raw"), clean_names = TRUE)
```

## Arguments

- id:

  Identificador numerico de la estadistica (ej. `1` para temperatura).

- pivot:

  Formato de salida de la tabla:

  - `"wide"` (por defecto): Mantiene columnas por cada periodo/anio.

  - `"long"`: Transforma las columnas anuales en formato largo (`anio` y
    `valor`).

  - `"raw"`: Retorna la estructura cruda de caracteres sin conversion
    automatica de tipos.

- clean_names:

  Logico. Si es `TRUE` (por defecto), normaliza los nombres de columnas
  a minusculas y sin caracteres especiales.

## Value

Un [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
con los datos de la estadistica.

## Examples

``` r
if (FALSE) { # \dontrun{
# Formato ancho (columnas por anio)
df_wide <- sinia_datos(1)
head(df_wide)

# Formato largo (apilado para graficos)
df_long <- sinia_datos(1, pivot = "long")
head(df_long)
} # }
```
