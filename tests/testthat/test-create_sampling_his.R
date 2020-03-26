# generate helper data
set.seed(1)
n_s <- c(10, 50)
n_s_test1 <- c('data', 10)
n_s_test2 <- c(4, 10)
pop <- generate_virtual_pop(1000, "Variable", rnorm, 0, 10)
samples <- draw_samples(pop, 100, n_s)
x <- create_sampling_hist(samples, Variable, n_s)
samples_test <- c(10, 50)
test_df1 <- data.frame("Variable" = c(1, 2, 3, 4, 5),
                       "s" = c(10, 10, 10, 10, 10),
                       "replicate" = c(1, 2, 3, 4, 5),
                       "size" = c(100, 100, 100, 100, 100))

test_df2 <- data.frame("Variable" = c(1, 2, 3, 4, 5),
                       "sample_size" = c(10, 10, 10, 10, 10),
                       "r" = c(1, 2, 3, 4, 5),
                       "size" = c(100, 100, 100, 100, 100))

test_df3 <- data.frame("Variable" = c(1, 2, 3, 4, 5),
                       "sample_size" = c(10, 10, 10, 10, 10),
                       "replicate" = c(1, 2, 3, 4, 5),
                       "si" = c(100, 100, 100, 100, 100))

test_that('should throw error', {
  expect_error(create_sampling_hist(samples_test, Variable, n_s), 'Samples should be a data frame or a tibble')
})

test_that('should throw error', {
  expect_error(create_sampling_hist(samples, data, n_s), "Variable must be a column in 'samples' df")
})

test_that('should throw error', {
  expect_error(create_sampling_hist(test_df1, Variable, n_s), "The input samples dataframe should have contain 'replicate', 'size', and 'rep_size' columns")
})

test_that('should throw error', {
  expect_error(create_sampling_hist(test_df2, Variable, n_s), "The input samples dataframe should have contain 'replicate', 'size', and 'rep_size' columns")
})

test_that('should throw error', {
  expect_error(create_sampling_hist(test_df3, Variable, n_s), "The input samples dataframe should contain 'replicate', 'size', and 'rep_size' columns")
})

test_that('should throw error', {
  expect_error(create_sampling_hist(samples, Variable, n_s_test1), "Samples' sizes should be a list or a vector with only numeric values")
})

test_that('should throw error', {
  expect_error(create_sampling_hist(samples, Variable, n_s_test2), "Can only include sample sizes in 'size' column of 'samples' df")
})

test_that("The number of sampling histograms should equal to the number of samples' sizes", {
  expect_equal(length(x), length(c(10, 50)))
})

test_that("make sure the output is a ggplot object", {
  for (i in length(x)){
    expect_true(class(x[[i]])[2] == "ggplot")
  }
})

test_that("x axis is mapped to mean", {
  for (i in length(x)){
    expect_true(rlang::get_expr(x[[i]]$layers[[1]]$mapping$x) == "mean")
  }
})

test_that("y axis is mapped to density", {
  for (i in length(x)){
    expect_true(rlang::get_expr(x[[i]]$layers[[1]]$mapping$y) == "..density..")
  }
})

test_that("plot titles are correct", {
  for (i in length(x)){
    expect_true(x[[i]]$labels$title == paste("sample size", n_s[i]))
  }
})
