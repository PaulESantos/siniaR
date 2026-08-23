# Listar indicadores y estadisticas ambientales del SINIA

Consulta el arbol tematico y catalogo de indicadores del SINIA segun el
marco ordenador especificado (por defecto MDEA - Marco para el
Desarrollo de las Estadisticas Ambientales de la ONU).

## Usage

``` r
sinia_indicadores(marco = c("mdea", "sinia"), solo_estadisticas = TRUE)
```

## Arguments

- marco:

  Caracter indicando el marco ordenador: `"mdea"` (por defecto) o
  `"sinia"`.

- solo_estadisticas:

  Logico. Si es `TRUE` (por defecto), solo retorna los items que
  corresponden a estadisticas finales con ID de descarga.

## Value

Un [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
con el listado de indicadores, codigos numerales, nombres y jerarquia
tematica.

## Examples

``` r
if (FALSE) { # \dontrun{
# Listar todos los indicadores del marco MDEA
ind <- sinia_indicadores()
head(ind)
} # }
```
