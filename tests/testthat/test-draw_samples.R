test_that("draw_samples.R not working as intended", {
  expect_equal((nrow(draw_samples(generate_virtual_pop(100, "height", rnorm, 0, 1), 2, c(2, 3, 4)))), 18)
  expect_equal(ncol(draw_samples(generate_virtual_pop(10, "x", rpois, 0), 2, c(2, 3))), 4)
})