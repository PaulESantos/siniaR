# Obtener la Ficha Técnica de una estadística del SINIA

Consulta y estructura los metadatos oficiales (definición, fuente,
fórmula de cálculo, metodología, periodicidad, unidad de medida y
responsables institucionales) de una estadística ambiental registrada en
el SINIA.

## Usage

``` r
sinia_ficha(id)
```

## Arguments

- id:

  Identificador numérico de la estadística (ej. `1` para temperatura
  promedio anual).

## Value

Un objeto de clase `sinia_ficha` (lista estructurada) con los siguientes
campos:

- id:

  Identificador numérico único de la estadística.

- numero:

  Código numeral asignado en el SINIA.

- nombre:

  Nombre oficial de la estadística ambiental.

- finalidad:

  Objetivo o propósito de la medición.

- descripcion:

  Fundamentación conceptual y descripción técnica.

- unidad_medida:

  Unidad física o métrica de medición (ej. `°C`, `ug/m3`, `ha`, `\%`).

- formula_calculo:

  Ecuación o expresión matemática utilizada para el cálculo.

- metodologia_calculo:

  Procedimiento metodológico de recopilación y procesamiento.

- fuente:

  Institución u organismo oficial generador (ej. SENAMHI, SERNANP, INEI,
  OEFA).

- unidad_organica:

  Dirección o unidad orgánica responsable de la información.

- url_fuente:

  Enlace web al portal o repositorio de la fuente original.

- periodicidad_generacion:

  Frecuencia de generación del dato (mensual, anual, etc.).

- periodicidad_entrega:

  Frecuencia de actualización en el SINIA.

- periodo_serie:

  Rango de años comprendido en la serie histórica (ej. `2014-2024`).

- ambito_geografico:

  Desagregación territorial (Nacional, Departamental, Provincial, etc.).

- limitaciones:

  Restricciones o consideraciones sobre los datos.

- relacion_objetivos_nacionales:

  Alineación con políticas y objetivos ambientales nacionales.

- relacion_iniciativas_internacionales:

  Alineación con ODS u otros compromisos globales.

- datos_contacto:

  Información de contacto institucional del generador.

- correo_electronico:

  Correo electrónico de contacto.

- clasificacion_mdea:

  Código y nombre del componente/subcomponente MDEA.

- clasificacion_sinia:

  Clasificación temática propia del SINIA.

- titulo_tabla:

  Título formal de la matriz tabular de datos.

- nota_tabla:

  Notas técnicas y aclaratorias sobre los valores numéricos.

- fuente_tabla:

  Texto de fuente que acompaña la tabla.

- elaboracion_tabla:

  Texto de elaboración institucional.

## See also

[`sinia_datos()`](https://paulesantos.github.io/siniaR/reference/sinia_datos.md),
[`sinia_estadistica()`](https://paulesantos.github.io/siniaR/reference/sinia_estadistica.md),
[`sinia_indicadores()`](https://paulesantos.github.io/siniaR/reference/sinia_indicadores.md)

## Examples

``` r
# Obtener la ficha tecnica de Temperatura Promedio Anual (ID = 1)
ficha <- sinia_ficha(1)
print(ficha)
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

# Consultar campos especificos
ficha$fuente
#> [1] "Servicio Nacional de Meteorología e Hidrología (Senamhi)"
ficha$unidad_medida
#> [1] "Grado Celsius (°C)"
ficha$formula_calculo
#> [1] "Tapa = Suma de la temperatura del aire promedio mensual (Tapm) / Número de meses con temperatura del aire promedio mensual (nm) del año (condición nm >=7). \nTapm = Suma de la temperatura del aire promedio diaria (Tapd) / Número de días con temperatura del aire promedio diario (nd) del mes (condición nd >=16).\nDonde: \nTapa: temperatura del aire promedio anual\nTapm: temperatura del aire promedio mensual \nTapd: temperatura del aire promedio diario\nnd: número de días del mes \nnm: número de meses del año"
```
