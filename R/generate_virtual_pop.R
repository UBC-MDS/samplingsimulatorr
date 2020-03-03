#' Create a virtual population
#'
#' This function creates a population from a distribution.
#' Author: Tao Guo
#'
#'@param N The numbers of samples
#'@param var_name the variable name that we need to create
#'@param dist the function that we are using
#'@param ... for the dist function
#'
#'@return a tibble that stores the virtual population
#'
#'@examples
#'generate_virtual_pop(100, "height", rnorm, 0, 1)
#'generate_virtual_pop(100, "n_accidents_per_hr", rpois, 2)
#'
#' @importFrom rlang :=
#' @importFrom dplyr tibble
#' @export
generate_virtual_pop <- function(N, var_name, dist, ... ){

  distribution <- match.fun(dist)

  var_name <- dplyr::enquo(var_name)
  pop <- tibble({{var_name}} := distribution(n = N, ...))

  return (pop)
}
