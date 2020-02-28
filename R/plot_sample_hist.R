#' Create a sample histogram from a population
#' 
#' This function creates a grid of sample distributions from a population.
#' Author: Holly Williams
#'
#' @param pop the virtual population as a tibble
#' @param samples the samples as a tibble
#' @param var_name the name of the variable/parameter of interest that is being generated
#' @param n_s a vector of the sample sizes
#'
#' @return a grid of the sample distributions
#' @export
#'
#' @examples
#' pop <- generate_virtual_pop(100, "Variable", rnorm, 0, 1)
#' samples <- draw_samples(pop, 3, c(1, 10))
#' plot_sample_hist(pop, samples, var_name, c(1, 10))
plot_sample_hist <- function(pop, samples, var_name, n_s){
  
}