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
#' @export
generate_virtual_pop <- function(N, var_name, dist, ... ) {

  if (N - as.integer(N) != 0 | N <= 0) {

    stop('Please enter a positive integer for sample size')

  }

  if (class(try(match.fun(dist), silent=TRUE)) == "try-error") {

    stop('This is not a vaild function, please check https://cran.r-project.org/web/views/Distributions.html for avaliable distribution functions')

  } else {

    distribution <- match.fun(dist)
  }

  var_name <- dplyr::enquo(var_name)

  if (class(try(distribution(n = N, ...), silent=TRUE)) == "try-error") {

    stop('Please check the parameters of the distribution function')

  } else {

    pop <- dplyr::tibble({{var_name}} := distribution(n = N, ...))

  }

  return(pop)
}
