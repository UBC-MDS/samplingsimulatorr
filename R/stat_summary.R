#' Create a stats summary
#'
#' This function creates a summary stats for population, samples and parameter(s) of interest.
#' Author: Tao Guo
#'
#'@param population The virtual population
#'@param samples The drawed samples
#'@param parameter The parameter(s) of interest
#'
#'@return a tibble summary stats
#'
#'@examples
#'stat_summary <- function(pop, samples, parameter)
stat_summary <- function(population, samples, parameter) {
  sub_pop <- population[[names(population)]]
  sub_samples <- samples[[names(samples)]]
  pop <- tibble('data' := c('population', 'samples'))
  for (i in (1:length(parameter))) {
    if (class(try(match.fun(parameter[i]), silent = TRUE)
    ) == "try-error") {
      stop('This is not a vaild function')

    } else {
      para_func <- match.fun(parameter[i])
    }

    pop <-
      cbind(pop, dplyr::tibble(!!parameter[i] := c(
        para_func(sub_pop), para_func(sub_samples)
      )))


  }

  return (pop)

}
