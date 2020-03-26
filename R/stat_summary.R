#' Create a stats summary
#'
#' This function creates a summary stats for population, samples and parameter(s) of interest.
#'
#'@param population The virtual population
#'@param samples The drawed samples
#'@param parameter A string vector or a single string of parameter(s) of interest
#'
#'@return a tibble summary stats
#'
#'@examples
#'pop <- generate_virtual_pop(100000, "Height", rexp, 5)
#'samples <- draw_samples(pop, 1, c(1))
#'stat_summary(pop, samples, c('mean', 'sd'))
#'
#' @importFrom rlang :=
#' @export
stat_summary <- function(population, samples, parameter) {

  if (!is.data.frame(population)) {
    stop("'population' should be input as a dataframe")
  }

  if(nrow(population) <= 0 || typeof(population) != 'list') {
    stop("'population' input is not a valid tibble")
  }

  if (!is.data.frame(samples)) {
    stop("'samples' should be input as a dataframe")
  }

  if(nrow(samples) <= 0 || typeof(samples) != 'list') {
    stop("'samples' input is not a valid tibble")
  }

  sub_pop <- population[[names(population)]]
  sub_samples <- samples[[names(samples)[2]]]

  pop <- dplyr::tibble('data' := c('population', 'samples'))

  for (i in (1:length(parameter))) {

    if (class(try(match.fun(parameter[i]), silent = TRUE)) == "try-error") {

      stop('This is not a vaild function')

    } else {

      para_func <- match.fun(parameter[i])

    }

    pop <- cbind(pop, dplyr::tibble(!!parameter[i] := c(para_func(sub_pop), para_func(sub_samples))))

  }

  return (pop)

}
