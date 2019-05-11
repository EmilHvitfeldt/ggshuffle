shuffle_options <- function(x) {
  c("original", "random", names(x$mapping))
}

shuffle_ggplot <- function(x, name, rev = FALSE) {
  x$data <- switch(name,
                   original = x$data,
                   random = dplyr::sample_frac(x$data),
                   dplyr::arrange(x$data, !!x$mapping[[name]]))

  if (rev) {
    x$data <- dplyr::arrange(x$data, dplyr::desc(dplyr::row_number()))
  }
  x
}
