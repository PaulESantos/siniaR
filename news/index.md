# Changelog

## siniaR 0.1.0

- Initial release to CRAN.
- Core functions to interact with Peru’s National Environmental
  Information System (SINIA / MINAM):
  - [`sinia_indicadores()`](https://paulesantos.github.io/siniaR/reference/sinia_indicadores.md):
    Browse the thematic catalog of environmental indicators under the UN
    FDES/MDEA or SINIA framework.
  - [`sinia_buscar()`](https://paulesantos.github.io/siniaR/reference/sinia_buscar.md):
    Search indicators and statistics by keyword with case- and
    accent-insensitive matching.
  - [`sinia_ficha()`](https://paulesantos.github.io/siniaR/reference/sinia_ficha.md):
    Retrieve official metadata sheets (*fichas técnicas*) including
    formulas, sources, methodologies, and geographical scope.
  - [`sinia_datos()`](https://paulesantos.github.io/siniaR/reference/sinia_datos.md):
    Download tabular time-series matrices in wide format or long *tidy*
    format ready for analysis and visualization with `ggplot2`.
  - [`sinia_estadistica()`](https://paulesantos.github.io/siniaR/reference/sinia_estadistica.md):
    Integrated S3 object holding both full technical metadata and
    processed tabular data.
- Rich console formatting and error messaging powered by `cli`.
