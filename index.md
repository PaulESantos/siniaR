# siniaR ![](reference/figures/logo.png)

**`siniaR`** es un paquete para R diseñado para facilitar el acceso
programático, exploración y análisis de las estadísticas ambientales
oficiales del Perú, provenientes en vivo del **Sistema Nacional de
Información Ambiental (SINIA / MINAM)**.

------------------------------------------------------------------------

## 🎨 Paleta de Colores Institucional (SINIA / Marco MDEA)

El sitio web y la identidad visual de `siniaR` están construidos a
partir de los colores oficiales del portal del SINIA / MINAM y los 6
componentes del Marco para el Desarrollo de las Estadísticas Ambientales
(MDEA / ONU):

| Componente / Elemento | Muestra | Color HEX | Descripción Temática |
|:---|:--:|:--:|:---|
| **SINIA Brand Blue** | ![\#1B75BC](https://via.placeholder.com/15/1B75BC/1B75BC.png) | `#1B75BC` | Color institucional primario SINIA / MINAM |
| **SINIA Brand Green** | ![\#78BE20](https://via.placeholder.com/15/78BE20/78BE20.png) | `#78BE20` | Acento secundario y naturaleza |
| **1. Condiciones y Calidad Ambiental** | ![\#38B6FF](https://via.placeholder.com/15/38B6FF/38B6FF.png) | `#38B6FF` | Atmósfera, clima, agua, suelo y ecosistemas |
| **2. Recursos Ambientales y su Uso** | ![\#E07A26](https://via.placeholder.com/15/E07A26/E07A26.png) | `#E07A26` | Minerales, energía, madera y biomasa |
| **3. Residuos** | ![\#7B3F7B](https://via.placeholder.com/15/7B3F7B/7B3F7B.png) | `#7B3F7B` | Generación y disposición de residuos |
| **4. Eventos Naturales y Cambio Climático** | ![\#2C3E50](https://via.placeholder.com/15/2C3E50/2C3E50.png) | `#2C3E50` | Desastres naturales y variables climáticas |
| **5. Hábitat Humano y Asuntos Socioambientales** | ![\#5E8D3B](https://via.placeholder.com/15/5E8D3B/5E8D3B.png) | `#5E8D3B` | Salud ambiental y asentamientos humanos |
| **6. Protección y Gestión Ambiental** | ![\#D4AC0D](https://via.placeholder.com/15/D4AC0D/D4AC0D.png) | `#D4AC0D` | Regulación, gasto y participación ambiental |

------------------------------------------------------------------------

## 📦 Instalación

Puedes instalar la versión de desarrollo de `siniaR` desde GitHub:

``` r

# install.packages("remotes")
remotes::install_github("PaulESantos/siniaR")
```

------------------------------------------------------------------------

## 🚀 Características Principales

- [`sinia_indicadores()`](https://paulesantos.github.io/siniaR/reference/sinia_indicadores.md):
  Catálogo y árbol temático de estadísticas ambientales oficiales según
  el marco internacional MDEA (ONU) o el marco SINIA.
- [`sinia_buscar()`](https://paulesantos.github.io/siniaR/reference/sinia_buscar.md):
  Búsqueda rápida de indicadores por palabras clave (ej.
  `"temperatura"`, `"pm10"`, `"glaciares"`, `"bosque"`).
- [`sinia_ficha()`](https://paulesantos.github.io/siniaR/reference/sinia_ficha.md):
  Consulta estructurada de la **Ficha Técnica** oficial con
  metodologías, fuentes, fórmulas de cálculo y notas explicativas.
- [`sinia_datos()`](https://paulesantos.github.io/siniaR/reference/sinia_datos.md):
  Descarga directa de matrices y series históricas en formato *tidy*
  (`wide` o `long` listo para análisis y visualización con `ggplot2`).
- [`sinia_estadistica()`](https://paulesantos.github.io/siniaR/reference/sinia_estadistica.md):
  Integración en un solo objeto de los metadatos de la ficha técnica y
  la tabla de datos procesada.

------------------------------------------------------------------------

## 💡 Ejemplos de Uso

``` r

library(siniaR)
library(dplyr)
library(ggplot2)
```

### 1. Explorar y buscar estadísticas en el SINIA

``` r

# Buscar estadísticas relacionadas a la calidad del aire
resultados <- sinia_buscar("PM10")
head(resultados)
#> # A tibble: 2 × 7
#>      id numeral nombre                      nivel clasificador_id padre_id marco
#>   <int> <chr>   <chr>                       <int>           <int>    <int> <chr>
#> 1    42 1.3.1.2 Promedio anual de partícul…     4              NA       62 mdea 
#> 2    44 1.3.1.4 Material particulado con d…     4              NA       62 mdea
```

### 2. Consultar la Ficha Técnica de un Indicador

``` r

# Consultar la ficha técnica de Temperatura Promedio Anual (ID = 1)
ficha <- sinia_ficha(1)
ficha
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
```

### 3. Descargar datos en formato *Tidy* y visualizar

``` r

# Descargar datos en formato largo (long) para graficar
temp_long <- sinia_datos(1, pivot = "long")

# Filtrar algunos departamentos y visualizar la evolución temporal
deptos_interes <- c("Lima", "Loreto", "Cusco", "Piura", "Puno")

temp_long |>
  filter(departamento %in% deptos_interes, !is.na(valor)) |>
  ggplot(aes(x = anio, y = valor, color = departamento)) +
  geom_line(linewidth = 1.1) +
  geom_point(size = 2.5) +
  scale_color_manual(values = c(
    "Lima" = "#1B75BC",
    "Loreto" = "#78BE20",
    "Cusco" = "#E07A26",
    "Piura" = "#38B6FF",
    "Puno" = "#7B3F7B"
  )) +
  labs(
    title = "Evolución de la Temperatura Promedio Anual (°C)",
    subtitle = "Fuente: SINIA / SENAMHI",
    x = "Año",
    y = "Temperatura Promedio (°C)",
    color = "Departamento"
  ) +
  theme_minimal()
```

![](reference/figures/README-example-plot-1.png)

------------------------------------------------------------------------

## 📚 Documentación y Viñetas

Para guías detalladas paso a paso, consulta las viñetas del paquete:

1.  **[Guía de Inicio Rápido a
    siniaR](https://paulesantos.github.io/siniaR/articles/siniaR-introduccion.html)**:
    Flujo de trabajo completo para búsqueda, extracción y visualización.
2.  **[Explorando los Componentes del Marco
    MDEA](https://paulesantos.github.io/siniaR/articles/marcos-ordenadores-mdea.html)**:
    Consulta y estructuración según los 6 componentes de Naciones
    Unidas.

------------------------------------------------------------------------

## 📄 Licencia

Este proyecto está bajo la Licencia MIT.
