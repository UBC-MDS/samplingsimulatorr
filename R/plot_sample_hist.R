#' Create a sample histogram from a population
#'
#' This function creates a grid of sample distributions from a population for different sample sizes.
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
#' plot_sample_hist(pop, samples, "Variable", c(1, 10))
plot_sample_hist <- function(pop, samples, var_name, n_s){

  # get var_name as string to check it is in df
  col_name <- deparse(substitute(var_name))

  # START TESTS ON INPUTS
  # check pop df input
  if (!is.data.frame(samples)) {
    stop("'pop' should be input as a dataframe")
  }
  if (!is.element(col_name, colnames(samples))) {
    stop(paste0("var_name (", col_name,") must be a column in 'pop' df"))
  }

  # check samples df input
  if (!is.data.frame(samples)) {
    stop("'samples' should be input as a dataframe")
  }
  if (!is.element(col_name, colnames(samples))) {
    stop(paste0("var_name (", col_name,") must be a column in 'samples' df"))
  }

  # check n_s (number of samples )
  if (!is.numeric(unlist(n_s)))
    stop("sample sizes should be numeric")
  for (i in n_s) {
    if (i < 1)
      stop("Samples sizes must be >=1")
    if (!is.element(i, unique(samples$size)))
      stop("Can only include sample sizes in 'size' column of 'samples' df")
  }

  # create an empty list of sample histograms
  samples_hist <- list()

  nrows <- round(length(n_s) / 4, digits=0)
  if (round(length(n_s) / 4, digits=0) > 1) {
    nrows <- 1
  } else {
    nrows <- round(length(n_s) / 4, digits=0) > 1
  }
  # for each
  for (i in 1:length(n_s)){
    samples_hist[[i]] <- samples %>%
      filter(replicate == 1, size == n_s[i]) %>%
      ggplot() +
      geom_histogram(aes({{var_name}}, ..density..)) +
      ggtitle(paste("Sample Size=", n_s[i])) +
      theme(plot.title = element_text(size = 10)) +
      theme_bw()
    if (i > 1){
      samples_hist[[i]] <- samples_hist[[i]] + theme(axis.title.y=element_blank(),
                                                     axis.text.y=element_blank(),
                                                     axis.ticks.y=element_blank())
    }

  }

  samples_hist[[length(n_s) + 1]] <-
    pop %>%
    ggplot() + geom_histogram(aes({{var_name}}, ..density..)) +
    ggtitle("True Population") +
    theme(plot.title = element_text(size = 10),
          axis.title.y=element_blank(),
          axis.text.y=element_blank(),
          axis.ticks.y=element_blank()) +
    theme_bw()


  return(grid.arrange(grobs = samples_hist, nrow=1, top = "Sample Distribution Histograms"))
}
