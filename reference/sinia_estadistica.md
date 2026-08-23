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

Un objeto de clase `sinia_estadistica` (lista S3) con los siguientes
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
if (FALSE) { # \dontrun{
est <- sinia_estadistica(1, pivot = "long")
# Consultar ficha
est$ficha
# Consultar datos
head(est$datos)
} # }
```
