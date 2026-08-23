test_that("SINIA API functions work or gracefully report connection issues", {
  # Skip if cannot connect to SINIA API
  has_internet <- tryCatch({
    con <- url("https://wp.bex.pe/portal/wp-json/esam/v1/website/list/marcos-ordenadores", "r")
    close(con)
    TRUE
  }, error = function(e) FALSE)

  skip_if_not(has_internet, "No internet connection or SINIA API unavailable")

  # 1. Test indicadores
  ind <- sinia_indicadores(marco = "mdea")
  expect_s3_class(ind, "tbl_df")
  expect_true("id" %in% colnames(ind))
  expect_true("nombre" %in% colnames(ind))
  expect_gt(nrow(ind), 50)

  # 2. Test buscar
  busq <- sinia_buscar("temperatura")
  expect_s3_class(busq, "tbl_df")
  expect_gt(nrow(busq), 0)

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

  datos_long <- sinia_datos(1, pivot = "long")
  expect_s3_class(datos_long, "tbl_df")
  expect_true("anio" %in% colnames(datos_long))
  expect_true("valor" %in% colnames(datos_long))

  # 5. Test estadistica integrada
  est <- sinia_estadistica(1)
  expect_s3_class(est, "sinia_estadistica")
  expect_s3_class(est$ficha, "sinia_ficha")
  expect_s3_class(est$datos, "tbl_df")
})
