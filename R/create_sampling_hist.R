#' Create a sampling distribution histogram from samples
#'
#' This function creates a list of sampling distribution histogram of the mean of different sample sizes drawn from a population
#' Author: Yue(Alex) Jiang
#'
#'
#' @param samples the samples as a tibble
#' @param var_name the name of the variable/parameter of interest that is being generated
#' @param n_s a vector of the sample sizes
#'
#' @return a list of the sampling distributions
#' @export
#'
#' @importFrom magrittr %>%
#' @importFrom stats quantile
#' @examples
#' pop <- generate_virtual_pop(100, "Variable", rnorm, 0, 1)
#' samples <- draw_samples(pop, 3, c(1, 10))
#' create_sampling_hist(samples, Variable, c(1, 10))
create_sampling_hist <- function(samples, var_name, n_s){

  # convert var_name to string for testing
  col_name <- toString(rlang::get_expr(rlang::enquo(var_name)))

  # check the validity of inputs
  if (!"data.frame" %in% c(class(samples)))
    stop("Samples should be a data frame or a tibble")

  if (!is.element(col_name, colnames(samples))) {
    stop(" Variable must be a column in 'samples' df")
  }

  if (!is.element("replicate", colnames(samples))) {
    stop("The input samples dataframe should have contain 'replicate', 'size', and 'rep_size' columns")
  }

  if (!is.element("size", colnames(samples))) {
    stop("The input samples dataframe should have contain 'replicate', 'size', and 'rep_size' columns")
  }

  if (!is.element("rep_size", colnames(samples))) {
    stop("The input samples dataframe should have contain 'replicate', 'size', and 'rep_size' columns")
  }

  for (i in n_s){
    if (class(i) != "numeric")
      stop("Samples' sizes should be a list or a vector with only numeric values")
    if (!is.element(i, unique(samples$size)))
      stop("Can only include sample sizes in 'size' column of 'samples' df")
  }

  samples <-
    samples %>%
    dplyr::ungroup()

  x_min <-
    samples %>%
    dplyr::select({{var_name}}) %>%
    unlist() %>%
    quantile(0.05)

  x_max <-
    samples %>%
    dplyr::ungroup() %>%
    dplyr::select({{var_name}}) %>%
    unlist() %>%
    quantile(0.95)


  summary <-
    samples %>%
    dplyr::group_by(replicate, size, rep_size) %>%
    dplyr::summarise(mean = mean({{var_name}}))


  sampling_dist<- list()
  for (i in 1:length(n_s)){
    sampling_dist[[ i ]] <-
      summary %>%
      dplyr::filter(size == n_s[i]) %>%
      ggplot2::ggplot() +
      ggplot2::geom_histogram(ggplot2::aes(mean, ..density..)) +
      ggplot2::ggtitle(paste("sample size", n_s[i])) +
      ggplot2::coord_cartesian(xlim = c(x_min, x_max)) +
      ggplot2::theme(plot.title = ggplot2::element_text(size = 10))
    if (i > 1){
      sampling_dist[[i]] <- sampling_dist[[i]] +
        ggplot2::theme(axis.title.y = ggplot2::element_blank(),
                       axis.text.y = ggplot2::element_blank(),
                       axis.ticks.y = ggplot2::element_blank())
    }

  }

  return(sampling_dist)
}
