# Buscar estadisticas ambientales por palabra clave

Realiza una busqueda insensible a mayusculas y tildes dentro del
catalogo de indicadores del SINIA.

## Usage

``` r
sinia_buscar(query, marco = c("mdea", "sinia"))
```

## Arguments

- query:

  Cadena de texto con la palabra o expresion a buscar (ej.
  `"temperatura"`, `"pm10"`, `"glaciar"`, `"bosque"`).

- marco:

  Caracter indicando el marco ordenador: `"mdea"` (por defecto) o
  `"sinia"`.

## Value

Un [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
con los indicadores que coinciden con la busqueda.

## Examples

``` r
if (FALSE) { # \dontrun{
# Buscar indicadores sobre temperatura
sinia_buscar("temperatura")

# Buscar indicadores sobre calidad del aire
sinia_buscar("pm10")
} # }
```
