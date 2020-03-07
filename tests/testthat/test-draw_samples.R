test_draw_samples <- function() {

  test_that("draw_samples.R not working as intended", {
    expect_true(all(colnames(draw_samples(generate_virtual_pop(100000, "54355", rexp, 5), 1, c(1))) == list("replicate", "54355", "size", "rep_size")))
    expect_equal((nrow(draw_samples(generate_virtual_pop(100, "height", rnorm, 0, 1), 2, c(2, 3, 4)))), 18)
    expect_equal(ncol(draw_samples(generate_virtual_pop(10, "x", rpois, 0), 2, c(2, 3))), 4)
  })

  test_that("Population input is not a valid tibble", {
    expect_error(draw_samples(c(1, 2, 3), 1, c(2, 3)))
  })
  
  test_that("Number of replications input must be an integer value", {
    pop <- generate_virtual_pop(10, "height", rnorm, 0, 1)
    expect_error(draw_samples(pop, 1.5, c(2, 3)))
  })
  
  test_that("Number of replications must be greater than 0", {
    pop <- generate_virtual_pop(10, "height", rnorm, 0, 1)
    expect_error(draw_samples(pop, 0, c(2, 3)))
  })
  
  test_that("At least one value in sample size array is not an integer value", {
    pop <- generate_virtual_pop(10, "height", rnorm, 0, 1)
    expect_error(draw_samples(pop, 3, c(2, 3, 4.5)))
  })
}

test_draw_samples()