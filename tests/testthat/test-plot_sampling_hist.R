# generate helper data
set.seed(1)
n_s <- c(10, 50)
pop <- generate_virtual_pop(1000, "Variable", rnorm, 0, 10)
samples <- draw_samples(pop, 100, n_s)
x <- plot_sampling_hist(samples, Variable, n_s)

test_that("The output should be a 'grob' object", {
  expect_true('grob' %in% class(x))
})

test_that("The output should be a 'gtable' object", {
  expect_true('gtable' %in% class(x))
})

test_that("The length of the grid plot minus 1 should equal to the number of different sample size", {
  expect_equal(length(x) - 1, length(n_s))
})

