test_that("get expected number of grobs", {
  pop <- generate_virtual_pop(N=100, var_name = height, rexp, 1)
  samples <- list(c(1, 10),
                  c(1, 5, 10),
                  c(1, 5, 10, 20),
                  c(1, 5, 10, 20, 50))
  grob_plot_1 <- plot_sample_hist(pop, draw_samples(pop, 3, samples[[1]]),
                                  var_name=height,
                                  samples[[1]])
  grob_plot_2 <- plot_sample_hist(pop, draw_samples(pop, 3, samples[[2]]),
                                  var_name=height,
                                  samples[[2]])
  grob_plot_3 <- plot_sample_hist(pop, draw_samples(pop, 3, samples[[3]]),
                                  var_name=height,
                                  samples[[3]])
  expect_equal(length(grob_plot_1) - 2, length(samples[[1]]))
  expect_equal(length(grob_plot_2) - 2, length(samples[[2]]))
  expect_equal(length(grob_plot_3) - 2, length(samples[[3]]))
})
