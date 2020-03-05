test_that("multiplication works", {
  expect_equal(stat_summary(dplyr::tibble(x = 1:3), dplyr::tibble(x = 1:3), 'mean')[['mean']], c(2, 2))
  expect_equal(nrow(stat_summary(dplyr::tibble(x = 1:10), dplyr::tibble(x = 1:10), c('mean', 'sd'))), 2)
  expect_equal(names(stat_summary(dplyr::tibble(x = 1:10), dplyr::tibble(x = 1:10), c('mean', 'sd'))), c('data', 'mean', 'sd'))
})
