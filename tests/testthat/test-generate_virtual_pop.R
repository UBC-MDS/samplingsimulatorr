test_that("Create a virtual population doesn't work", {
  expect_equal(colnames(generate_virtual_pop(100, "test_name", rnorm, 0, 1)), 'test_name')
  expect_equal(nrow(generate_virtual_pop(100, 'var_name', rnorm, 0, 1)), 100)
  expect_equal(ncol(generate_virtual_pop(100, 'var_name', rnorm, 0, 1)), 1)
})

test_that('Check the distribution', {
  set.seed(1)
  helper_object1 <- generate_virtual_pop(1000, "name1", rnorm, 0, 10)$name1
  set.seed(1)
  helper_correct_values <- rnorm(1000, 0, 10)
  expect_equal(helper_object1, helper_correct_values)

  set.seed(1)
  helper_object1 <- generate_virtual_pop(1000, "name1", rpois, 5)$name1
  set.seed(1)
  helper_correct_values <- rpois(1000, 5)
  expect_equal(helper_object1, helper_correct_values)

  set.seed(1)
  helper_object1 <- generate_virtual_pop(1000, "name1", rexp, 5)$name1
  set.seed(1)
  helper_correct_values <- rexp(1000, 5)
  expect_equal(helper_object1, helper_correct_values)
})

test_that("Input errors no catching", {
  expect_error(colnames(generate_virtual_pop(-100, "test_name", rnorm, 0, 1)))
  expect_error(generate_virtual_pop(100, 'var_name', rnorml, 0, 1))
  expect_error(generate_virtual_pop(10.1, 'var_name', rnorm, 0, 1))
})
