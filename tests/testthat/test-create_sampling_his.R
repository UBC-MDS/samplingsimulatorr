# generate helper data
set.seed(1)
n_s <- c(10, 50)
n_s_test1 <- c('data', 10)
n_s_test2 <- c(4, 10)
pop <- generate_virtual_pop(1000, "Variable", rnorm, 0, 10)
samples <- draw_samples(pop, 100, n_s)
x <- create_sampling_hist(samples, Variable, n_s, 3)
samples_test <- c(10, 50)
rep_test <- "rep"

test_that('should throw error', {
  expect_error(create_sampling_hist(samples_test, Variable, n_s, 3), 'Samples should be a data frame or a tibble')
})

test_that('should throw error', {
  expect_error(create_sampling_hist(samples, data, n_s, 3), "Variable must be a column in 'samples' df")
})

test_that('should throw error', {
  expect_error(create_sampling_hist(samples, Variable, n_s, rep_test), "Number of replications should be a numerical value, a vector with length 1")
})

test_that('should throw error', {
  expect_error(create_sampling_hist(samples, Variable, n_s_test1, 100), "Samples' sizes should be a list or a vector with only numeric values")
})

test_that('should throw error', {
  expect_error(create_sampling_hist(samples, Variable, n_s_test2, 100), "Can only include sample sizes in 'size' column of 'samples' df")
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

