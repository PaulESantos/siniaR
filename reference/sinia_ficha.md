# Obtener la Ficha Tecnica de una estadistica del SINIA

Consulta y estructura los metadatos oficiales (definicion, fuente,
formula, metodologia, periodicidad y responsables) de una estadistica
ambiental.

## Usage

``` r
sinia_ficha(id)
```

## Arguments

- id:

  Identificador numerico de la estadistica (ej. `1` para temperatura
  promedio anual).

## Value

Un objeto de clase `sinia_ficha` con los metadatos de la estadistica.

## Examples

``` r
if (FALSE) { # \dontrun{
ficha <- sinia_ficha(1)
print(ficha)
} # }
```
