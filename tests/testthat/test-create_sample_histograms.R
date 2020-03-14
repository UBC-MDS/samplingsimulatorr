# generate helper data
pop <- generate_virtual_pop(N=100, var_name = height, rexp, 1)
samples <- draw_samples(pop, 3, c(1, 5, 10))
x <- create_sample_histograms(pop, samples, height, c(1, 5, 10))

test_that("x axis is mapped to correct variable", {
  expect_true(rlang::get_expr(x[[1]]$layers[[1]]$mapping$x) == "height")
  expect_true(rlang::get_expr(x[[2]]$layers[[1]]$mapping$x) == "height")
  expect_true(rlang::get_expr(x[[3]]$layers[[1]]$mapping$x) == "height")
})

test_that("correct number of histograms (should be number of samples + 1 (for population plot))", {
  expect_equal(length(x), 3 + 1)
})

test_that("plot labels are correct", {
  expect_true(x[[1]]$labels$x == "height")
  expect_true(x[[2]]$labels$x == "height")
  expect_true(x[[3]]$labels$x == "height")
  expect_true(x[[1]]$labels$title == "Sample Size= 1")
  expect_true(x[[2]]$labels$title == "Sample Size= 5")
  expect_true(x[[3]]$labels$title == "Sample Size= 10")
  expect_true(x[[4]]$labels$title == "True Population")

})

test_that('exceptions are raised properly', {
  expect_error(create_sample_histograms(test_df, samples, height, c(1, 5, 10)),
               "'pop' should be input as a dataframe")
  expect_error(create_sample_histograms(pop, test_df, height, c(1, 5, 10)),
               "'samples' should be input as a dataframe")
  expect_error(create_sample_histograms(pop, samples, var, c(1, 5, 10)),
               "var_name must be a column in 'samples' df")
  expect_error(create_sample_histograms(pop, samples, height, c(1, 'B', 10)),
               "sample sizes should be numeric")
  expect_error(create_sample_histograms(pop, samples, height, c(0, 5, 10)),
               "Samples sizes must be >=1")
  expect_error(create_sample_histograms(pop, samples, height, c(2, 5, 10)),
               "Can only include sample sizes in 'size' column of 'samples' df")
})
