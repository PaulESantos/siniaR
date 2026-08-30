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
est <- sinia_estadistica(1, pivot = "long")
# Consultar ficha
est$ficha
#> 
#> ── Ficha Tecnica: Temperatura del aire promedio anual en estación de medición se
#> • ID: 1 (Numero: 1)
#> • Fuente: Servicio Nacional de Meteorología e Hidrología (Senamhi)
#> • Unidad de Medida: Grado Celsius (°C)
#> • Periodo de Serie: 2014-2024
#> • Ambito Geografico: Nacional, Departamental, Provincial, Distrital, Estación
#>   de medición
#> • Clasificacion MDEA: 1.1.1
#> 
#> ── Descripcion ──
#> 
#> La temperatura del aire es uno de los elementos climáticos que está en relación
#> directa con el balance de energía, es decir, su valor o magnitud depende de la
#> fracción de Radiación Neta (Rn). Sin embargo, esta relación directa, entre
#> temperatura y Rn es afectado por otros factores como se ve a continuación: - El
#> movimiento de rotación de la tierra que da origen al ciclo diurno y el
#> movimiento de traslación que origina el ciclo anual. - La amplitud de estas
#> ondas (ciclo diurno de temperatura) son alterados por: la superficie sobre la
#> cual incide la radiación solar, masas de aire, nubosidad, transparencia
#> atmosférica, relieve topográfico, etc.
#> 
#> ── Formula de Calculo ──
#> 
#> Tapa = Suma de la temperatura del aire promedio mensual (Tapm) / Número de
#> meses con temperatura del aire promedio mensual (nm) del año (condición nm
#> >=7).  Tapm = Suma de la temperatura del aire promedio diaria (Tapd) / Número
#> de días con temperatura del aire promedio diario (nd) del mes (condición nd
#> >=16). Donde: Tapa: temperatura del aire promedio anual Tapm: temperatura del
#> aire promedio mensual Tapd: temperatura del aire promedio diario nd: número de
#> días del mes nm: número de meses del año
#> 
#> ── Metodologia ──
#> 
#> La temperatura del aire promedio anual es información procesada de los datos
#> provenientes de la lectura del termómetro y de los termómetros extremos
#> (máximos y mínimos) de las estaciones de medición ubicadas principalmente en
#> capital de departamento.
#> ℹ Nota: es el valor de la temperatura del aire promedio anual en la estación de medición, ubicada principalmente en capital de departamento. (…) No se cuentan con estadísticas.
# Consultar datos
head(est$datos)
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
