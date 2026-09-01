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
con los datos de la estadística, o un tibble vacío si no hay conexión o
no existen registros. Además, contiene los siguientes atributos con
metadatos asociados:

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
# Formato ancho (columnas por anio)
df_wide <- sinia_datos(1)
head(df_wide)
#> # A tibble: 6 × 12
#>   departamento `2014` `2015` `2016` `2017` `2018` `2019` `2020` `2021` `2022`
#>   <chr>         <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>  <dbl>
#> 1 Amazonas       14.9   15.1   15.6   15.2   14.8   15.0   15.3   15.0   15.0
#> 2 Áncash         12.5   12.8   13.1   12.3   12.0   12.4   13.4   11.2   11.1
#> 3 Apurímac       14.2   14.5   14.9   14.3   14.2   14.6   15.5   13.6   15.6
#> 4 Arequipa       16.1   17.1   17.3   16.6   16.6   17.0   17.4   16.2   16.0
#> 5 Ayacucho       18.4   18.3   18.8   18.1   17.1   17.0   18.2   17.4   17.7
#> 6 Cajamarca      15.0   15.4   15.6   15.0   14.9   15.0   15.5   14.9   14.8
#> # ℹ 2 more variables: `2023` <dbl>, `2024` <dbl>

# \donttest{
# Formato largo (apilado para analisis y graficos con ggplot2)
df_long <- sinia_datos(1, pivot = "long")
head(df_long)
#> # A tibble: 6 × 3
#>   departamento  anio valor
#>   <chr>        <int> <dbl>
#> 1 Amazonas      2014  14.9
#> 2 Áncash        2014  12.5
#> 3 Apurímac      2014  14.2
#> 4 Arequipa      2014  16.1
#> 5 Ayacucho      2014  18.4
#> 6 Cajamarca     2014  15.0
# }
```
