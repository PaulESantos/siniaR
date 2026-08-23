# Obtener datos y ficha tecnica completa de una estadistica del SINIA

Descarga tanto los metadatos de la ficha tecnica como el conjunto de
datos estructurado en un unico objeto `sinia_estadistica`.

## Usage

``` r
sinia_estadistica(id, pivot = c("wide", "long"))
```

## Arguments

- id:

  Identificador numerico de la estadistica (ej. `1` para temperatura).

- pivot:

  Formato de salida de los datos (`"wide"` o `"long"`).

## Value

Un objeto de clase `sinia_estadistica` que contiene:

- `ficha`: Objeto `sinia_ficha` con los metadatos.

- `datos`:
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
  con los datos tabulares.

## Examples

``` r
if (FALSE) { # \dontrun{
est <- sinia_estadistica(1)
est$ficha
head(est$datos)
} # }
```
