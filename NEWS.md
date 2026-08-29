# siniaR 0.1.0

* Initial release to CRAN.
* Core functions to interact with Peru's National Environmental Information System (SINIA / MINAM):
  * `sinia_indicadores()`: Browse the thematic catalog of environmental indicators under the UN FDES/MDEA or SINIA framework.
  * `sinia_buscar()`: Search indicators and statistics by keyword with case- and accent-insensitive matching.
  * `sinia_ficha()`: Retrieve official metadata sheets (*fichas técnicas*) including formulas, sources, methodologies, and geographical scope.
  * `sinia_datos()`: Download tabular time-series matrices in wide format or long *tidy* format ready for analysis and visualization with `ggplot2`.
  * `sinia_estadistica()`: Integrated S3 object holding both full technical metadata and processed tabular data.
* Rich console formatting and error messaging powered by `cli`.
