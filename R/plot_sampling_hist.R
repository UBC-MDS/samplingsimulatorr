#' Create a grid of sampling distribution histogram from samples
#'
#' This function creates a grid of sampling distribution histogram of the mean of different sample sizes drawn from a population
#' Author: Yue(Alex) Jiang
#'
#'
#' @param samples the samples as a tibble
#' @param var_name the name of the variable/parameter of interest that is being generated
#' @param sample_size a vector of the sample sizes
#'
#' @return a grid of the sampling distributions
#' @export
#'
#' @examples
#' pop <- generate_virtual_pop(100, "Variable", rnorm, 0, 1)
#' samples <- draw_samples(pop, 3, c(1, 10))
#' plot_sampling_hist(samples, Variable, c(1, 10))
plot_sampling_hist <- function(samples, var_name, sample_size){

  # Note: inputs have already been checked in `create_sampling_hist`
  # which is not a user facing function
  sampling_hist <- create_sampling_hist(samples, {{var_name}}, sample_size)
  return(gridExtra::grid.arrange(grobs = sampling_hist, ncol = min(4, ceiling(length(sampling_hist) / 2)),
                          top = "Sampling Distribution Histograms"))

}
