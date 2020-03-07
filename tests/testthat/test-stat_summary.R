test_that("The tibble not generate as expected", {
  expect_equal(stat_summary(dplyr::tibble(x = 1:3), dplyr::tibble(x = 1:3), 'mean')[['mean']], c(2, 2))
  expect_equal(nrow(stat_summary(dplyr::tibble(x = 1:10), dplyr::tibble(x = 1:10), c('mean', 'sd'))), 2)
  expect_equal(names(stat_summary(dplyr::tibble(x = 1:10), dplyr::tibble(x = 1:10), c('mean', 'sd'))), c('data', 'mean', 'sd'))
})

test_that("The population you passed in is not a valid data frame", {
  expect_error(stat_summary(c(1, 2), dplyr::tibble(x = 1:3), 'mean'))
  expect_error(stat_summary(dplyr::tibble(a = character()), dplyr::tibble(x = 1:10), c('mean', 'sd')))
  expect_error(stat_summary(dplyr::tibble(a = numeric()), dplyr::tibble(x = 1:10), c('mean', 'sd')))
})

test_that("The psamples you passed in is not a valid data frame", {
  expect_error(stat_summary(dplyr::tibble(x = 1:3), c(1, 2), 'mean'))
  expect_error(stat_summary(dplyr::tibble(x = 1:10), dplyr::tibble(a = character()), c('mean', 'sd')))
  expect_error(stat_summary(dplyr::tibble(x = 1:10),  dplyr::tibble(a = numeric()), c('mean', 'sd')))
})

test_that("The function you passed in is not a valid function", {
  expect_error(stat_summary(dplyr::tibble(x = 1:10), dplyr::tibble(x = 1:10), 'mean_not_here'))
  expect_error(stat_summary(dplyr::tibble(x = 1:10), dplyr::tibble(x = 1:10), c('mean_not_here', 'sd_not_here')))
  expect_error(stat_summary(dplyr::tibble(x = 1:10), dplyr::tibble(x = 1:10), c('mean', 'sd_not_here')))
})
