#' Generates samples of different sizes
#' 
#' This function draws samples of various sizes from a population.
#' Author: Lise Braaten
#'
#' @param pop the virtual population as a tibble
#' @param reps the number of replication for each sample size as an integer value
#' @param n_s the sample size for each one of the samples as an array
#'
#' @return a two column tibble containing the sample numbers and sample values
#' @export
#'
#' @examples
#' pop <- generate_virtual_pop(100, "Variable", rnorm, 0, 1)
#' samples <- draw_samples(pop, 3, c(1, 10))
draw_samples <- function(pop, reps, n_s){
    
    #check that pop input has at least one value and is a tibble
    if(nrow(pop) <= 0 || typeof(pop) != 'list') {
        stop("Population input is not a valid tibble")
    }
    
    #check reps input is an integer value
    if((reps - round(reps)) != 0) {
        stop("Number of replications input must be an integer value")
    }
    
    #check reps input is greater than 0
    if(reps <= 0 ){
        stop("Number of replications must be greater than 0")
    }
    
    #check that all values of n_s array are integer values
    for (i in n_s){
        if((i - round(i)) != 0){
            stop("At least one value in n_s array is not an integer value")
        }
    }
        
    samples <- list()
  
    for (sample_size in 1:length(n_s)){
        for (rep in 1:length(reps)){
            samples[[sample_size * length(reps) + rep]] <- pop %>% 
                rep_sample_n(size = n_s[sample_size], reps = reps[rep], replace = TRUE) %>% 
                mutate(size = n_s[sample_size], rep_size = reps[rep])
        }
    }

  return(bind_rows(samples))
}