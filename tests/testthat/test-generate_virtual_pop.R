test_that("multiplication works", {
  expect_equal(colnames(generate_virtual_pop(100, "test_name", rnorm, 0, 1)), 'test_name')
  expect_equal(nrow(generate_virtual_pop(100, 'var_name', rnorm, 0, 1)), 100)
  expect_equal(ncol(generate_virtual_pop(100, 'var_name', rnorm, 0, 1)), 1)
})
