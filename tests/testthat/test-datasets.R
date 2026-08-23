test_that("Bundled datasets exist and load properly", {
  datasets <- c(
    "acp_sernanp", "acr_sernanp", "cap_pot_bosq_amaz",
    "flora_fauna_2013_2020", "flora_fauna_ende", "humedad_rel",
    "islas_islotes", "precipitacion", "prom_mensual_pm_menor_10mcr",
    "rios_frontera", "sup_dep_sup_bha", "superficie_bha",
    "temperatura", "temperatura_maxima", "xlsx_links"
  )

  for (d in datasets) {
    data(list = d, package = "siniaR", envir = environment())
    obj <- get(d, envir = environment())
    expect_true(is.data.frame(obj), info = paste("Dataset", d, "should be a data frame"))
    expect_gt(nrow(obj), 0, label = paste("Dataset", d, "rows"))
    expect_gt(ncol(obj), 0, label = paste("Dataset", d, "columns"))
  }
})
