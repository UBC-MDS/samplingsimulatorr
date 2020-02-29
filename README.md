## samplingsimulatorr

### Overview

`samplingsimulatorr` is an R package intended to assist those teaching or learning basic statistical inference.

This package allows users to generate virtual populations which can be sampled from in order to compare and contrast sample vs sampling distributions for different sample sizes.  The package also allows users to sample from the generated virtual population (or any other population), plot the distributions, and view summaries for the parameters of interest.


### Function Descriptions

- `generate_virtual_pop` creates a virtual population.
    - **Inputs** : distribution function (i.e. `rnorm`, `rexp`, etc), the paramaters required by the distribution function, and the size of the population.
    - **Outputs**: the virtual population as a tibble
- `draw_samples` generates samples of different sizes
    - **Inputs** : population to sample from, the sample size, and the number of samples
    - **Outputs**: returns a tibble with the sample number in one column and value in a second column.
- `plot_sample_hist` creates sample distributions for different sample sizes.
    - **Inputs** : population to sample from, the samples to plot, and a vector of the sample sizes
    - **Outputs**: returns a grid of sample distribution plots
- `plot_sampling_dist` creates sampling distributions for different sample sizes.
    - **Inputs** : population to sample from, the samples to plot, and a vector of the sample sizes
    - **Outputs**: returns a grid of sampling distribution plots
- `stat_summary`: returns a summary of the statistical parameters of interest
    - **Inputs**: population, samples, parameter(s) of interest
    - **Outputs**: summary tibble


#### How these fit into the R ecosystem?

To the best of our knowledge, there is currently no existing R package with the specific functionality to create virtual populations and make the specific sample and sampling distributions described above. We do make use of many existing R packages and expand on them to make very specific functions. These include:
 - built-in r distribution functions such as `rnorm` to sample from distributions
 - `rep_sample_n` to generate random samples
 - `ggplot2` to create plots
Python pandas already includes some summary statistics functions such as .describe(), however our package will be more customizable. Our summary will only include the statistical parameters of interest and will provide a comparison between the sample, sampling, and true population parameters.

### Installation:

```
Will be updated once functions are created
```

### Features
- Will be updated once functions are created

### Dependencies

- Will be updated once functions are created

### Usage

- Will be updated once functions are created

### Documentation
The official documentation is hosted on Read the Docs: <https://samplingsimulatorpy.readthedocs.io/en/latest/>

### Credits
This package was created with Cookiecutter and the UBC-MDS/cookiecutter-ubc-mds project template, modified from the [pyOpenSci/cookiecutter-pyopensci](https://github.com/pyOpenSci/cookiecutter-pyopensci) project template and the [audreyr/cookiecutter-pypackage](https://github.com/audreyr/cookiecutter-pypackage).
