# Obtener datos y ficha técnica completa de una estadística del SINIA

Descarga tanto los metadatos estructurados de la ficha técnica como el
conjunto de datos tabulares en un único objeto compuesto de clase
`sinia_estadistica`.

## Usage

``` r
sinia_estadistica(id, pivot = c("wide", "long"))
```

## Arguments

- id:

  Identificador numérico de la estadística (ej. `1` para temperatura).

- pivot:

  Formato de salida de los datos (`"wide"` o `"long"`).

## Value

Un objeto de clase `sinia_estadistica` (lista S3), o `NULL` de forma
invisible si no se pudo conectar o no existen datos, con los siguientes
elementos:

- id:

  Identificador numérico de la estadística.

- nombre:

  Nombre oficial del indicador.

- ficha:

  Objeto de clase `sinia_ficha` con todos los metadatos oficiales.

- datos:

  Un
  [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
  con los datos tabulares en el formato solicitado.

## See also

[`sinia_ficha()`](https://paulesantos.github.io/siniaR/reference/sinia_ficha.md),
[`sinia_datos()`](https://paulesantos.github.io/siniaR/reference/sinia_datos.md)

## Examples

``` r
est <- sinia_estadistica(1, pivot = "long")
if (!is.null(est)) {
  # Consultar ficha
  est$ficha
  # Consultar datos
  head(est$datos)
}
#> # A tibble: 6 × 3
#>   departamento  anio valor
#>   <chr>        <int> <dbl>
#> 1 Amazonas      2014  14.9
#> 2 Áncash        2014  12.5
#> 3 Apurímac      2014  14.2
#> 4 Arequipa      2014  16.1
#> 5 Ayacucho      2014  18.4
#> 6 Cajamarca     2014  15.0
```
