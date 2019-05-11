
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ggshuffle

<!-- badges: start -->

<!-- badges: end -->

**ggshuffle** is a RStudio-Addin that uses the
[rstudioapi](https://github.com/rstudio/rstudioapi) package and provides
a GUI to give a visual tool to determine if your
[ggplot2](https://github.com/tidyverse/ggplot2) charts appearance if
affected by the order in which your points/lines are being plotted.

## Installation

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("EmilHvitfeldt/ggshuffle")
```

## Example

**ggshuffle** can be used by highlighting some ggplot2 code and clicking
the `ggshuffle` button in the Addins tab or by passing a ggplot2 object
to the `ggshuffle()` function.

``` r
library(ggplot2)
## basic example code

ggg <- ggplot(na.omit(txhousing), aes(volume, median, color = year)) +
  geom_point()

ggshuffle(ggg)
```

![Screenshot](man/figures/ggshuffle-demo.gif)
