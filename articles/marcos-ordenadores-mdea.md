# Explorando los Componentes del Marco MDEA

## El Marco para el Desarrollo de las Estadísticas Ambientales (MDEA)

El **Marco para el Desarrollo de las Estadísticas Ambientales (MDEA /
FDES)** de las Naciones Unidas es la estructura metodológica
internacional adoptada por el Ministerio del Ambiente (MINAM) y el SINIA
para ordenar y clasificar las estadísticas ambientales del Perú.

El MDEA organiza las estadísticas en **6 componentes principales**:

| N° | Componente MDEA | Color Temático | Descripción |
|:--:|:---|:--:|:---|
| **1** | **Condiciones y Calidad Ambiental** | `#38B6FF` (Celeste) | Clima, atmósfera, recursos hídricos, suelo, biodiversidad y ecosistemas. |
| **2** | **Recursos Ambientales y su Uso** | `#E07A26` (Ámbar) | Recursos minerales, energéticos, forestales, biológicos y acuáticos. |
| **3** | **Residuos** | `#7B3F7B` (Púrpura) | Generación, gestión, tratamiento y disposición de residuos sólidos y aguas residuales. |
| **4** | **Eventos Naturales y Cambio Climático** | `#2C3E50` (Pizarra) | Desastres naturales, peligros asociados y variables de cambio climático. |
| **5** | **Hábitat Humano y Asuntos Socioambientales** | `#5E8D3B` (Verde Olivo) | Asentamientos humanos, salud ambiental, población expuesta y conflictos socioambientales. |
| **6** | **Protección, Gestión y Participación Ambiental** | `#D4AC0D` (Mostaza) | Gasto ambiental, regulación, áreas protegidas, fiscalización y participación ciudadana. |

------------------------------------------------------------------------

## Consultando Estadísticas por Componente

``` r

library(siniaR)
library(dplyr)
```

Podemos consultar el catálogo completo bajo el marco MDEA y filtrar por
componente según el código numeral:

``` r

# Descargar el índice completo del marco MDEA
ind_mdea <- sinia_indicadores(marco = "mdea")

# Estadísticas pertenecientes al Componente 1 (Condiciones y Calidad Ambiental)
c1_calidad <- ind_mdea |>
  filter(grepl("^1\\.", numeral))

head(c1_calidad, 8)
#> # A tibble: 8 × 7
#>      id numeral nombre                      nivel clasificador_id padre_id marco
#>   <int> <chr>   <chr>                       <int>           <int>    <int> <chr>
#> 1     1 1.1.1.1 Temperatura del aire prome…     4              NA       55 mdea 
#> 2     2 1.1.1.2 Temperatura máxima promedi…     4              NA       55 mdea 
#> 3     3 1.1.1.3 Temperatura mínima promedi…     4              NA       55 mdea 
#> 4     4 1.1.1.4 Precipitación total anual …     4              NA       55 mdea 
#> 5     5 1.1.1.5 Humedad relativa promedio …     4              NA       55 mdea 
#> 6     6 1.1.1.6 Número de horas de sol anu…     4              NA       55 mdea 
#> 7     7 1.1.1.7 Radiación ultravioleta pro…     4              NA       55 mdea 
#> 8     8 1.1.1.8 Ozono atmosférico mínimo, …     4              NA       55 mdea
```

### Explorando Otros Componentes

``` r

# Componente 2: Recursos Ambientales
c2_recursos <- ind_mdea |> filter(grepl("^2\\.", numeral))
head(c2_recursos, 5)
#> # A tibble: 5 × 7
#>      id numeral nombre                      nivel clasificador_id padre_id marco
#>   <int> <chr>   <chr>                       <int>           <int>    <int> <chr>
#> 1    48 2.1.1.1 Número de negocios sosteni…     4              NA       66 mdea 
#> 2    49 2.1.1.2 Número de negocios sosteni…     4              NA       66 mdea 
#> 3    50 2.1.1.3 Ahorro anual en los consum…     4              NA       66 mdea 
#> 4    51 2.1.1.4 Ahorro anual en el consumo…     4              NA       66 mdea 
#> 5    52 2.1.1.5 Ahorro anual en el consumo…     4              NA       66 mdea

# Componente 3: Residuos
c3_residuos <- ind_mdea |> filter(grepl("^3\\.", numeral))
head(c3_residuos, 5)
#> # A tibble: 5 × 7
#>      id numeral nombre                      nivel clasificador_id padre_id marco
#>   <int> <chr>   <chr>                       <int>           <int>    <int> <chr>
#> 1    65 3.1.1.1 Generación per cápita de r…     4              NA       78 mdea 
#> 2    66 3.1.1.2 Generación total anual de …     4              NA       78 mdea 
#> 3    67 3.1.1.3 Generación anual de residu…     4              NA       78 mdea 
#> 4    68 3.1.1.4 Generación per cápita de r…     4              NA       78 mdea 
#> 5    69 3.1.1.5 Generación anual de residu…     4              NA       78 mdea

# Componente 4: Eventos Naturales y Desastres
c4_eventos <- ind_mdea |> filter(grepl("^4\\.", numeral))
head(c4_eventos, 5)
#> # A tibble: 5 × 7
#>      id numeral nombre                      nivel clasificador_id padre_id marco
#>   <int> <chr>   <chr>                       <int>           <int>    <int> <chr>
#> 1    79 4.1.1.1 Número de sismos ocurridos…     4              NA       85 mdea 
#> 2    80 4.1.1.2 Rango de magnitudes de los…     4              NA       85 mdea 
#> 3    81 4.1.1.3 Número de alertas de pelig…     4              NA       85 mdea 
#> 4    82 4.1.1.4 Número de boletines vulcan…     4              NA       85 mdea 
#> 5    83 4.1.1.5 Número de monitoreo en las…     4              NA       85 mdea

# Componente 5: Hábitat Humano
c5_habitat <- ind_mdea |> filter(grepl("^5\\.", numeral))
head(c5_habitat, 5)
#> # A tibble: 5 × 7
#>      id numeral nombre                      nivel clasificador_id padre_id marco
#>   <int> <chr>   <chr>                       <int>           <int>    <int> <chr>
#> 1    91 5.1.1.1 Número de comunidades amaz…     4              NA       91 mdea 
#> 2    92 5.1.1.2 Mujeres que participaron e…     4              NA       91 mdea 
#> 3    93 5.1.2.1 Superficie de área verde p…     4              NA       92 mdea 
#> 4    94 5.1.2.2 Superficie de área verde p…     4              NA       92 mdea 
#> 5    95 5.1.2.3 Superficie de área verde p…     4              NA       92 mdea

# Componente 6: Gestión y Protección Ambiental
c6_gestion <- ind_mdea |> filter(grepl("^6\\.", numeral))
head(c6_gestion, 5)
#> # A tibble: 5 × 7
#>      id numeral nombre                      nivel clasificador_id padre_id marco
#>   <int> <chr>   <chr>                       <int>           <int>    <int> <chr>
#> 1   100 6.1.1.1 "Número de inversiones con…     4              NA      101 mdea 
#> 2   101 6.1.1.2 "Inversiones del Sector Am…     4              NA      101 mdea 
#> 3   102 6.1.1.3 "Proyectos de inversión pú…     4              NA      101 mdea 
#> 4   103 6.1.1.4 "Número de proyectos aprob…     4              NA      101 mdea 
#> 5   104 6.1.1.5 "Número de proyectos aprob…     4              NA      101 mdea
```

------------------------------------------------------------------------

## Marco Propio SINIA

Además del marco MDEA, el SINIA cuenta con un marco temático sectorial
nacional que también puede consultarse indicando `marco = "sinia"`:

``` r

ind_sinia <- sinia_indicadores(marco = "sinia")
head(ind_sinia, 8)
#> # A tibble: 8 × 7
#>      id numeral nombre                      nivel clasificador_id padre_id marco
#>   <int> <chr>   <chr>                       <int>           <int>    <int> <chr>
#> 1    10 1.1.1   Superficie de lagunas de o…     3              NA        2 sinia
#> 2    11 1.1.2   Número de lagunas de orige…     3              NA        2 sinia
#> 3    12 1.1.3   Número de lagunas de orige…     3              NA        2 sinia
#> 4    13 1.1.4   Superficie glaciar por cor…     3              NA        2 sinia
#> 5    14 1.1.5   Número de glaciares por co…     3              NA        2 sinia
#> 6    15 1.1.6   Fluctuación del frente gla…     3              NA        2 sinia
#> 7    16 1.1.7   Aporte anual por fusión de…     3              NA        2 sinia
#> 8   136 1.1.8   Cambio en el uso eficiente…     3              NA        2 sinia
```
