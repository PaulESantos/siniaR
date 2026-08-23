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
if (FALSE) { # \dontrun{
# Obtener la ficha tecnica de Temperatura Promedio Anual (ID = 1)
ficha <- sinia_ficha(1)
print(ficha)

# Consultar campos especificos
ficha$fuente
ficha$unidad_medida
ficha$formula_calculo
} # }
```
