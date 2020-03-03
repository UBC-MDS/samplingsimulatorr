test_that("multiplication works", {
  expect_equal(colnames(generate_virtual_pop(100, "test_name", rnorm, 0, 1)), 'test_name')

})
