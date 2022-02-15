library(rlang)
library(yardstick)

mmae_vec <- function(truth, estimate, na_rm = TRUE, ...) {
  
  mmae_impl <- function(truth, estimate) {
    df <- tibble::tibble(truth = truth, estimate = estimate)
    maes <- df %>% 
      dplyr::group_by(truth) %>% 
      yardstick::mae(truth, estimate)
    
    mmae <- mean(maes$.estimate)
  }
  
  metric_vec_template(
    metric_impl = mmae_impl,
    truth = truth, 
    estimate = estimate,
    na_rm = na_rm,
    cls = "numeric",
    ...
  )
  
}

mmae <- function(data, ...) {
  UseMethod("mmae")
}

mmae <- new_numeric_metric(mmae, direction = "minimize")

mmae.data.frame <- function(data, truth, estimate, na_rm = TRUE, ...) {
  
  metric_summarizer(
    metric_nm = "mmae",
    metric_fn = mmae_vec,
    data = data,
    truth = !! enquo(truth),
    estimate = !! enquo(estimate), 
    na_rm = na_rm,
    ...
  )

}
