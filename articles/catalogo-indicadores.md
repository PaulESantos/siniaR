# Catálogo Completo de Indicadores y Estadísticas Ambientales

## Guía de Acceso a las Estadísticas del SINIA

Esta guía contiene el **catálogo oficial interactivo de los más de 180
indicadores y estadísticas ambientales** disponibles en vivo en la
plataforma del **Sistema Nacional de Información Ambiental (SINIA /
MINAM)**, organizados según los 6 componentes del **Marco para el
Desarrollo de las Estadísticas Ambientales (MDEA / ONU)**.

Para consultar o descargar cualquiera de estas estadísticas, utiliza su
número de **`ID`** con las siguientes funciones del paquete:

``` r

library(siniaR)

# 1. Descargar serie de datos en formato largo (apilado / tidy para análisis y gráficos)
df_long <- sinia_datos(id = 1, pivot = "long")

# 2. Descargar matriz en formato ancho (columnas por año)
df_wide <- sinia_datos(id = 1, pivot = "wide")

# 3. Consultar la ficha técnica oficial con metodologías, fuentes y fórmulas
ficha <- sinia_ficha(id = 1)

# 4. Obtener objeto integrado (metadatos completos + matriz de datos)
est <- sinia_estadistica(id = 1, pivot = "long")
```

------------------------------------------------------------------------

## 🔍 Explorador Dinámico de Indicadores

Utiliza la caja de búsqueda para filtrar instantáneamente por palabra
clave (ej. *temperatura*, *pm10*, *glaciar*, *bosque*, *residuos*),
numeral o ID. Puedes navegar entre páginas para evitar desplazarte por
toda la lista.

------------------------------------------------------------------------

## 📖 Parámetros y Argumentos de Consulta

| Función | Parámetro | Tipo | Valores permitidos / Descripción |
|:---|:---|:--:|:---|
| `sinia_datos(id, pivot, clean_names)` | `id` | Entero / Numérico | Identificador numérico de la estadística (ver tabla interactiva). |
|  | `pivot` | Carácter | `"long"` (formato ordenado con columnas `anio` y `valor`), `"wide"` (años en columnas) o `"raw"` (sin conversión de tipos). |
|  | `clean_names` | Lógico | `TRUE` (por defecto, normaliza a minúsculas y sin acentos) o `FALSE`. |
| `sinia_ficha(id)` | `id` | Entero / Numérico | Identificador de la estadística para consultar fuentes, fórmulas y responsables. |
| `sinia_estadistica(id, pivot)` | `id`, `pivot` | Entero, Carácter | Descarga combinada de la ficha técnica y la matriz de datos. |
| `sinia_indicadores(marco, solo_estadisticas)` | `marco` | Carácter | `"mdea"` (ONU) o `"sinia"` (sectorial nacional). |
| `sinia_buscar(query, marco)` | `query` | Carácter | Término de búsqueda (ej. `"temperatura"`, `"pm10"`, `"glaciar"`). |
