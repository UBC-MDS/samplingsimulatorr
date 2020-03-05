# generate helper data
set.seed(1)
n_s <- c(10, 50)
pop <- generate_virtual_pop(1000, "Variable", rnorm, 0, 10)
samples <- draw_samples(pop, 100, n_s)
x <- plot_sampling_hist(samples, Variable, n_s, 3)

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