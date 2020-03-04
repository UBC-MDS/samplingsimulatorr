test_that("multiplication works", {
  expect_equal(names(stat_summary(dplyr::tibble(x = 1:10), dplyr::tibble(x = 1:10), c('mean', 'sd'))), c('data', 'mean', 'sd'))
})
