test_that("sinia_buscar validates query inputs", {
  expect_error(sinia_buscar())
  expect_error(sinia_buscar(""))
  expect_error(sinia_buscar(123))
  expect_error(sinia_buscar(c("a", "b")))
})

test_that("sinia_ficha and sinia_datos validate id inputs", {
  expect_error(sinia_ficha())
  expect_error(sinia_ficha(c(1, 2)))
  expect_error(sinia_ficha(NA))

  expect_error(sinia_datos())
  expect_error(sinia_datos(c(1, 2)))
  expect_error(sinia_datos(NA))
})

test_that("S3 print methods handle NULL and mocks without errors", {
  expect_no_error(print.sinia_ficha(NULL))
  expect_no_error(print.sinia_estadistica(NULL))

  mock_ficha <- list(
    id = 999,
    numero = "1.1.1.1",
    nombre = "Indicador de Prueba",
    fuente = "SENAMHI",
    unidad_medida = "°C",
    periodo_serie = "2015-2024",
    ambito_geografico = "Nacional",
    clasificacion_mdea = "1.1",
    descripcion = "Descripcion de prueba",
    formula_calculo = "A / B",
    metodologia_calculo = "Metodologia de prueba",
    nota_tabla = "Nota tecnica"
  )
  class(mock_ficha) <- c("sinia_ficha", "list")
  expect_no_error(print(mock_ficha))

  mock_est <- list(
    id = 999,
    nombre = "Indicador de Prueba",
    ficha = mock_ficha,
    datos = tibble::tibble(departamento = "Lima", anio = 2024, valor = 21.5)
  )
  class(mock_est) <- c("sinia_estadistica", "list")
  expect_no_error(print(mock_est))
})

test_that("Graceful failure works when connection fails or times out", {
  # Simular timeout extremo para forzar salida airosa
  op <- options(siniaR.timeout = 0.001)
  on.exit(options(op), add = TRUE)

  ind <- sinia_indicadores(marco = "mdea")
  expect_s3_class(ind, "tbl_df")
  expect_equal(nrow(ind), 0)

  fic <- sinia_ficha(1)
  expect_null(fic)

  dat <- sinia_datos(1)
  expect_s3_class(dat, "tbl_df")
  expect_equal(nrow(dat), 0)

  est <- sinia_estadistica(1)
  expect_null(est)
})

test_that("SINIA API live calls work if connected", {
  skip_on_cran()
  skip_if_not(curl::has_internet(), "No internet connection")

  has_api <- tryCatch({
    con <- url("https://wp.bex.pe/portal/wp-json/esam/v1/website/list/marcos-ordenadores", "r")
    close(con)
    TRUE
  }, error = function(e) FALSE)

  skip_if_not(has_api, "SINIA API endpoint unavailable")

  # 1. Test indicadores
  ind <- sinia_indicadores(marco = "mdea")
  expect_s3_class(ind, "tbl_df")
  expect_true("id" %in% colnames(ind))
  expect_true("nombre" %in% colnames(ind))
  expect_gt(nrow(ind), 50)

  # 2. Test buscar (including query with regex characters)
  busq <- sinia_buscar("temperatura")
  expect_s3_class(busq, "tbl_df")
  expect_gt(nrow(busq), 0)

  # Test special characters without regex crash
  busq_paren <- sinia_buscar("PM10 (ug/m3)")
  expect_s3_class(busq_paren, "tbl_df")

  # 3. Test ficha tecnica
  ficha <- sinia_ficha(1)
  expect_s3_class(ficha, "sinia_ficha")
  expect_equal(ficha$id, 1)
  expect_true(!is.null(ficha$fuente))
  expect_true(!is.null(ficha$unidad_medida))

  # 4. Test datos (wide y long)
  datos_wide <- sinia_datos(1, pivot = "wide")
  expect_s3_class(datos_wide, "tbl_df")
  expect_gt(nrow(datos_wide), 0)
  expect_equal(attr(datos_wide, "sinia_id"), 1)

  datos_long <- sinia_datos(1, pivot = "long")
  expect_s3_class(datos_long, "tbl_df")
  expect_true("anio" %in% colnames(datos_long))
  expect_true("valor" %in% colnames(datos_long))
  expect_type(datos_long$valor, "double")

  # 5. Test estadistica integrada
  est <- sinia_estadistica(1)
  expect_s3_class(est, "sinia_estadistica")
  expect_s3_class(est$ficha, "sinia_ficha")
  expect_s3_class(est$datos, "tbl_df")
})
