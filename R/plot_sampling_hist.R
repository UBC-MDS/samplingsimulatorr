#' Create a sampling distribution histogram from samples
#'
#' This function creates a grid sampling distribution histogram of the mean of different sample sizes drawn from a population
#' Author: Yue(Alex) Jiang
#'
#' @param pop the virtual population as a tibble
#' @param samples the samples as a tibble
#' @param var_name the name of the variable/parameter of interest that is being generated
#' @param n_s a vector of the sample sizes
#' @param reps the number of replication for each sample size as an integer
#'
#' @return a grid of the sampling distributions
#' @export
#'
#' @examples
#' pop <- generate_virtual_pop(100, "Variable", rnorm, 0, 1)
#' samples <- draw_samples(pop, 3, c(1, 10))
#' plot_sampling_hist(pop, samples, var_name, c(1, 10), 3)
plot_sampling_hist <- function(pop, samples, var_name, n_s, reps){
  if (!"data.frame" %in% c(class(samples))) stop("Samples should be a data frame or a tibble")
  if (!is.numeric(reps) == TRUE) stop("Number of replications should be a numerical value, a vector with length 1")
  for (i in n_s){
    if (class(i) != "numeric") stop("Samples' sizes should be a list or a vector with only numeric values")
  }

  samples <-
    samples %>%
    ungroup()

  x_min <-
    samples %>%
    select({{var_name}}) %>%
    unlist() %>%
    quantile(0.05)

  x_max <-
    samples %>%
    ungroup() %>%
    select({{var_name}}) %>%
    unlist() %>%
    quantile(0.95)


  summary <-
    samples %>%
    group_by(replicate, size, rep_size) %>%
    summarise(mean = mean({{var_name}}))


  sampling_dist<- list()
  for (i in 1:length(n_s)){
    sampling_dist[[ i ]] <-
      summary %>%
      filter(size == n_s[i]) %>%
      ggplot() + geom_histogram(aes(mean, ..density..)) +
      ggtitle(paste("sample size", n_s[i])) +
      coord_cartesian(xlim = c(x_min, x_max)) +
      theme(plot.title = element_text(size = 10))
    if (i > 1){
      sampling_dist[[i]] <- sampling_dist[[i]] + theme(axis.title.y=element_blank(),
                                                       axis.text.y=element_blank(),
                                                       axis.ticks.y=element_blank())
    }

  }

  return(grid.arrange(grobs = sampling_dist, nrow=1, top = "Sampling Distribution Histograms"))

}
