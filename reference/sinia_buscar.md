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
# Buscar indicadores sobre temperatura
sinia_buscar("temperatura")
#> # A tibble: 3 × 7
#>      id numeral nombre                      nivel clasificador_id padre_id marco
#>   <int> <chr>   <chr>                       <int>           <int>    <int> <chr>
#> 1     1 1.1.1.1 Temperatura del aire prome…     4              NA       55 mdea 
#> 2     2 1.1.1.2 Temperatura máxima promedi…     4              NA       55 mdea 
#> 3     3 1.1.1.3 Temperatura mínima promedi…     4              NA       55 mdea 

# Buscar indicadores sobre calidad del aire
sinia_buscar("pm10")
#> # A tibble: 2 × 7
#>      id numeral nombre                      nivel clasificador_id padre_id marco
#>   <int> <chr>   <chr>                       <int>           <int>    <int> <chr>
#> 1    42 1.3.1.2 Promedio anual de partícul…     4              NA       62 mdea 
#> 2    44 1.3.1.4 Material particulado con d…     4              NA       62 mdea 

# Buscar indicadores sobre cobertura forestal
sinia_buscar("bosque")
#> # A tibble: 6 × 7
#>      id numeral nombre                      nivel clasificador_id padre_id marco
#>   <int> <chr>   <chr>                       <int>           <int>    <int> <chr>
#> 1    39 1.2.3.1 Superficie de bosque húmed…     4              NA       60 mdea 
#> 2    40 1.2.3.2 Porcentaje de la superfici…     4              NA       60 mdea 
#> 3    57 2.2.1.2 Pérdida de bosque húmedo a…     4              NA       69 mdea 
#> 4    58 2.2.1.3 Variación anual de la tasa…     4              NA       69 mdea 
#> 5    60 2.2.1.5 Pérdida de bosque húmedo a…     4              NA       69 mdea 
#> 6    61 2.2.1.6 Cambio de uso de la tierra…     4              NA       69 mdea 
```
