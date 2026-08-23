#' @title Datos Ambientales del Peru (INEI / SERNANP / SENAMHI)
#' @description Conjuntos de datos ambientales oficiales compilados a partir de los anuarios
#'   estadisticos del Instituto Nacional de Estadistica e Informatica (INEI) y organismos
#'   adscritos al Ministerio del Ambiente (SERNANP, SENAMHI, OEFA).
#' @name siniaR-datasets
NULL

#' Areas de Conservacion Privada (ACP) reconocidas por SERNANP
#'
#' Conjunto de datos con el registro de las Areas de Conservacion Privada (ACP)
#' en el territorio peruano, reconocidas mediante resolucion ministerial.
#'
#' @format Un data frame (`tbl_df`) con informacion de:
#' \describe{
#'   \item{departamento}{Nombre del departamento donde se ubica el area.}
#'   \item{area_de_conservacion}{Nombre oficial del Area de Conservacion Privada.}
#'   \item{base_legal}{Norma legal de reconocimiento o establecimiento.}
#'   \item{sup_ha}{Superficie total del area en hectareas (ha).}
#'   \item{fecha_promulgacion}{Fecha oficial de promulgacion o reconocimiento.}
#' }
#' @source Servicio Nacional de Areas Naturales Protegidas por el Estado (SERNANP) / INEI.
"acp_sernanp"

#' Areas de Conservacion Regional (ACR) reconocidas por SERNANP
#'
#' Informacion sobre las Areas de Conservacion Regional (ACR) establecidas en el Peru
#' para la proteccion de ecosistemas y biodiversidad a nivel subnacional.
#'
#' @format Un data frame con variables de ubicacion, nombre del ACR, base legal y superficie en hectareas.
#' @source Servicio Nacional de Areas Naturales Protegidas por el Estado (SERNANP) / INEI.
"acr_sernanp"

#' Capacidad de uso mayor y potencial de los bosques humedos amazonicos
#'
#' Informacion sobre la capacidad potencial del suelo y cobertura de bosques humedos en la Amazonia peruana.
#'
#' @format Un data frame con clasificacion de suelos y capacidad forestal/de proteccion en hectareas.
#' @source Instituto Nacional de Estadistica e Informatica (INEI) / MINAM.
"cap_pot_bosq_amaz"

#' Especies de Flora y Fauna Amenazadas (2013-2020)
#'
#' Registro historico del numero de especies de flora y fauna silvestre amenazadas
#' segun categorias de conservacion (Vulnerable, En Peligro, En Peligro Critico).
#'
#' @format Un data frame con registros anuales por grupo taxonomico y categoria de amenaza.
#' @source SERFOR / Ministerio del Ambiente (MINAM) / INEI.
"flora_fauna_2013_2020"

#' Especies de Flora y Fauna Endemicas
#'
#' Numero de especies endemicas registradas en el Peru por grupo taxonomico.
#'
#' @format Un data frame con grupos taxonomicos (aves, mamiferos, anfibios, reptiles, plantas) y conteo de especies endemicas.
#' @source Ministerio del Ambiente (MINAM) / INEI.
"flora_fauna_ende"

#' Humedad Relativa Promedio Anual segun Departamento
#'
#' Serie historica de humedad relativa promedio anual (%) registrada en estaciones
#' meteorologicas representativas de cada departamento del Peru.
#'
#' @format Un data frame con departamentos y valores anuales de humedad relativa (%).
#' @source Servicio Nacional de Meteorologia e Hidrologia del Peru (SENAMHI) / INEI.
"humedad_rel"

#' Islas e Islotes del litoral peruano
#'
#' Inventario de las principales islas, islotes y puntas guaneras a lo largo de la costa peruana.
#'
#' @format Un data frame con nombre, ubicacion departamental y superficie estimada.
#' @source Direccion de Hidrografia y Navegacion (DHN) / INEI.
"islas_islotes"

#' Precipitacion Total Anual segun Departamento
#'
#' Serie historica de precipitacion total anual acumulada (milimetros, mm) registrada
#' en las principales estaciones meteorologicas por departamento.
#'
#' @format Un data frame con departamentos y valores anuales de precipitacion en mm.
#' @source Servicio Nacional de Meteorologia e Hidrologia del Peru (SENAMHI) / INEI.
"precipitacion"

#' Promedio Mensual de Material Particulado PM10 en Lima Metropolitana
#'
#' Concentraciones promedio mensuales de material particulado con diametro inferior
#' a 10 micras (PM10 en ug/m3) monitoreadas en diferentes estaciones de Lima Metropolitana.
#'
#' @format Un data frame con registros mensuales, estacion de monitoreo y concentracion en ug/m3.
#' @source DIGESA / SENAMHI / OEFA / INEI.
"prom_mensual_pm_menor_10mcr"

#' Rios Principales y de Cuencas Transfronterizas del Peru
#'
#' Caracteristicas hidrogaficas de los principales rios y sistemas hidricos compartidos en fronteras.
#'
#' @format Un data frame con nombre del rio, vertiente hidrografica, longitud y cuenca.
#' @source Autoridad Nacional del Agua (ANA) / INEI.
"rios_frontera"

#' Superficie Departamental y Superficie con Bosque Humedo Amazonico
#'
#' Distribucion de la superficie de bosque humedo amazonico (BHA) y su porcentaje
#' respecto a la superficie territorial total de cada departamento.
#'
#' @format Un data frame con departamento, superficie departamental (ha) y superficie de bosque (ha y %).
#' @source Programa Nacional de Conservacion de Bosques (PNCBMCC) / INEI.
"sup_dep_sup_bha"

#' Superficie de Bosque Humedo Amazonico
#'
#' Serie historica de la cobertura de bosque humedo amazonico en el territorio nacional.
#'
#' @format Un data frame con registros anuales de superficie en hectareas.
#' @source MINAM / PNCBMCC / INEI.
"superficie_bha"

#' Temperatura del Aire Promedio Anual segun Departamento
#'
#' Serie historica de temperatura media anual del aire (grados Celsius, °C) registrada
#' en estaciones meteorologicas de capitales departamentales.
#'
#' @format Un data frame con departamento y serie de temperaturas promedio anuales (°C).
#' @source Servicio Nacional de Meteorologia e Hidrologia del Peru (SENAMHI) / INEI.
"temperatura"

#' Temperatura Maxima Promedio Anual segun Departamento
#'
#' Serie historica de temperatura maxima promedio anual (grados Celsius, °C) registrada
#' por departamento.
#'
#' @format Un data frame con departamento y serie de temperaturas maximas anuales (°C).
#' @source Servicio Nacional de Meteorologia e Hidrologia del Peru (SENAMHI) / INEI.
"temperatura_maxima"

#' Catalogo de Enlaces a Archivos Excel Tematicos del INEI
#'
#' Tabla de referencia con los titulos tematicos y enlaces directos de descarga
#' a las tablas estadisticas del anuario ambiental del INEI.
#'
#' @format Un data frame con titulo de la tabla y URL de descarga oficial en formato `.xlsx`.
#' @source Instituto Nacional de Estadistica e Informatica (INEI).
"xlsx_links"
