#' Create a sample histogram from a population
#'
#' This function creates a grid of sample distributions from a population for different sample sizes.
#' Author: Holly Williams
#'
#' @param pop the virtual population as a tibble
#' @param samples the samples as a tibble
#' @param var_name the name of the column for the variable that is being generated
#' @param sample_size a vector of the sample sizes
#'
#' @return a list of the sample histogram plots
#' @export
#'
#' @importFrom magrittr %>%
#' @examples
#' pop <- generate_virtual_pop(100, height, rnorm, 0, 1)
#' samples <- draw_samples(pop, 3, c(1, 10))
#' create_sample_histograms(pop, samples, height, c(1, 10))
create_sample_histograms <- function(pop, samples, var_name, sample_size){

  # START INPUT TESTS #
  # convert var_name to string for testing
  col_name <- toString(rlang::get_expr(rlang::enquo(var_name)))

  # check pop df input
  if (!"data.frame" %in% c(class(pop))) {
    stop("'pop' should be input as a dataframe")
  }

  # check samples df input
  if (!"data.frame" %in% c(class(samples))) {
    stop("'samples' should be input as a dataframe")
  }
  if (!is.element(col_name, colnames(samples))) {
    stop("var_name must be a column in 'samples' df")
  }

  # check sample_size (number of samples )
  if (!is.numeric(unlist(sample_size)))
    stop("sample sizes should be numeric")
  for (i in sample_size) {
    if (i < 1)
      stop("Samples sizes must be >=1")
    if (!is.element(i, unique(samples$size)))
      stop("Can only include sample sizes in 'size' column of 'samples' df")
  }

  # create an empty list of sample histograms
  samples_hist <- list()

  # for each sample size, generate tidy data needed for histogram plots
  # using filter and replicate, then make the plots
  for (i in 1:length(sample_size)){
    samples_hist[[i]] <- samples %>%
      dplyr::filter(replicate == 1, size == sample_size[i]) %>%
      ggplot2::ggplot() +
      ggplot2::geom_histogram(ggplot2::aes({{var_name}}, ..density..)) +
      ggplot2::ggtitle(paste("Sample Size=", sample_size[i])) +
      ggplot2::theme_bw() +
      ggplot2::theme(plot.title = ggplot2::element_text(size = 10))

    if (i > 1){
      samples_hist[[i]] <- samples_hist[[i]] +
        ggplot2::theme(axis.title.y = ggplot2::element_blank(),
                       axis.text.y = ggplot2::element_blank(),
                       axis.ticks.y = ggplot2::element_blank())
    }

  }

  # create true population histograms
  samples_hist[[length(sample_size) + 1]] <-
    pop %>%
    ggplot2::ggplot() + ggplot2::geom_histogram(ggplot2::aes({{var_name}}, ..density..)) +
    ggplot2::ggtitle("True Population") +
    ggplot2::theme_bw() +
    ggplot2::theme(plot.title = ggplot2::element_text(size = 10),
                   axis.title.y = ggplot2::element_blank(),
                   axis.text.y = ggplot2::element_blank(),
                   axis.ticks.y = ggplot2::element_blank())


  return(samples_hist)
}
