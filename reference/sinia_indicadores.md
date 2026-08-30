# Listar indicadores y estadísticas ambientales del SINIA

Consulta el árbol temático y catálogo de indicadores del SINIA según el
marco ordenador especificado (por defecto MDEA - Marco para el
Desarrollo de las Estadísticas Ambientales de la ONU, o el marco
sectorial propio de SINIA).

## Usage

``` r
sinia_indicadores(marco = c("mdea", "sinia"), solo_estadisticas = TRUE)
```

## Arguments

- marco:

  Carácter indicando el marco ordenador: `"mdea"` (por defecto) o
  `"sinia"`.

- solo_estadisticas:

  Lógico. Si es `TRUE` (por defecto), solo retorna los ítems que
  corresponden a estadísticas finales con ID numérico de descarga. Si es
  `FALSE`, incluye también las categorías y niveles superiores del árbol
  temático.

## Value

Un [tibble::tibble](https://tibble.tidyverse.org/reference/tibble.html)
con las siguientes columnas:

- id:

  Identificador numérico único de la estadística (entero).

- numeral:

  Código numeral de clasificación jerárquica (ej. `"1.1.1"`).

- nombre:

  Nombre oficial del indicador o estadística ambiental.

- nivel:

  Nivel jerárquico dentro del árbol temático (entero).

- clasificador_id:

  Identificador del clasificador temático.

- padre_id:

  Identificador del clasificador padre en la jerarquía.

- marco:

  Marco ordenador consultado (`"mdea"` o `"sinia"`).

## See also

[`sinia_buscar()`](https://paulesantos.github.io/siniaR/reference/sinia_buscar.md),
[`sinia_ficha()`](https://paulesantos.github.io/siniaR/reference/sinia_ficha.md),
[`sinia_datos()`](https://paulesantos.github.io/siniaR/reference/sinia_datos.md)

## Examples

``` r
# Listar todos los indicadores del marco MDEA (ONU)
ind_mdea <- sinia_indicadores(marco = "mdea")
head(ind_mdea)
#> # A tibble: 6 × 7
#>      id numeral nombre                      nivel clasificador_id padre_id marco
#>   <int> <chr>   <chr>                       <int>           <int>    <int> <chr>
#> 1     1 1.1.1.1 Temperatura del aire prome…     4              NA       55 mdea 
#> 2     2 1.1.1.2 Temperatura máxima promedi…     4              NA       55 mdea 
#> 3     3 1.1.1.3 Temperatura mínima promedi…     4              NA       55 mdea 
#> 4     4 1.1.1.4 Precipitación total anual …     4              NA       55 mdea 
#> 5     5 1.1.1.5 Humedad relativa promedio …     4              NA       55 mdea 
#> 6     6 1.1.1.6 Número de horas de sol anu…     4              NA       55 mdea 

# Listar bajo el marco sectorial SINIA
ind_sinia <- sinia_indicadores(marco = "sinia")
head(ind_sinia)
#> # A tibble: 6 × 7
#>      id numeral nombre                      nivel clasificador_id padre_id marco
#>   <int> <chr>   <chr>                       <int>           <int>    <int> <chr>
#> 1    10 1.1.1   Superficie de lagunas de o…     3              NA        2 sinia
#> 2    11 1.1.2   Número de lagunas de orige…     3              NA        2 sinia
#> 3    12 1.1.3   Número de lagunas de orige…     3              NA        2 sinia
#> 4    13 1.1.4   Superficie glaciar por cor…     3              NA        2 sinia
#> 5    14 1.1.5   Número de glaciares por co…     3              NA        2 sinia
#> 6    15 1.1.6   Fluctuación del frente gla…     3              NA        2 sinia
```
