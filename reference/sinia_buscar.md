# Buscar estadísticas ambientales por palabra clave

Realiza una búsqueda insensible a mayúsculas, minúsculas y tildes dentro
del catálogo oficial de indicadores del SINIA.

## Usage

``` r
sinia_buscar(query, marco = c("mdea", "sinia"))
```

## Arguments

- query:

  Cadena de texto con la palabra o expresión a buscar (ej.
  `"temperatura"`, `"pm10"`, `"glaciar"`, `"bosque"`, `"residuos"`).

- marco:

  Carácter indicando el marco ordenador: `"mdea"` (por defecto) o
  `"sinia"`.

## Value

Un [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
con los indicadores que coinciden con el término de búsqueda,
conservando la estructura de
[`sinia_indicadores()`](https://paulesantos.github.io/siniaR/reference/sinia_indicadores.md).

## See also

[`sinia_indicadores()`](https://paulesantos.github.io/siniaR/reference/sinia_indicadores.md),
[`sinia_ficha()`](https://paulesantos.github.io/siniaR/reference/sinia_ficha.md),
[`sinia_datos()`](https://paulesantos.github.io/siniaR/reference/sinia_datos.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Buscar indicadores sobre temperatura
sinia_buscar("temperatura")

# Buscar indicadores sobre calidad del aire
sinia_buscar("pm10")

# Buscar indicadores sobre cobertura forestal
sinia_buscar("bosque")
} # }
```
