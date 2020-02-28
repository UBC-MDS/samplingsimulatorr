#' Generates samples of different sizes
#' 
#' This function draws samples of various sizes from a population.
#' Author: Lise Braaten
#'
#' @param pop the virtual population as a tibble
#' @param reps the number of replication for each sample size as an integer
#' @param n_s the sample size for each one of the samples as an array
#'
#' @return a two column tibble containing the sample numbers and sample values
#' @export
#'
#' @examples
#' pop <- generate_virtual_pop(100, "Variable", rnorm, 0, 1)
#' samples <- draw_samples(pop, 3, c(1, 10))
draw_samples <- function(pop, sample_size, n_samples){
  
}