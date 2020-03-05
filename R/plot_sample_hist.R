#' Create a sample histogram from a population
#'
#' This function creates a grid of sample distributions from a population for different sample sizes.
#' Author: Holly Williams
#'
#' @param pop the virtual population as a tibble
#' @param samples the samples as a tibble
#' @param var_name the name of the column for the variable that is being generated
#' @param n_s a vector of the sample sizes
#'
#' @return a list of the sample histogram plots
#' @export
#'
#' @examples
#' pop <- generate_virtual_pop(100, height, rnorm, 0, 1)
#' samples <- draw_samples(pop, 3, c(1, 10))
#' plot_sample_hist(pop, samples, height, c(1, 10))
plot_sample_hist <- function(pop, samples, var_name, n_s){
  # Note: inputs have already been tested in `create_sample_histograms`
  # which is not user facing
  sample_hist <- create_sample_histograms(pop, samples, {{var_name}}, n_s)
  num_rows_plots  <- max(1, round(length(sample_hist) / 4))
  return(gridExtra::grid.arrange(grobs = sample_hist, nrow=num_rows_plots,
                      top = "Sample Distribution Histograms"))
}
