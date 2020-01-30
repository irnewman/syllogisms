
#' Generates list of problem complexity in the items.
#'
#' @param simple Boolean value to include simple (1 model) problems.
#' @param complex Boolean value to include complex (2+ model) problems.
#' @param number_of_items The total number of stimuli items in the template.
#' @param number_of_cb The factor to balance instruction options in.
#'
#' @return A vector of models.

create_models <- function(simple = FALSE,
                          complex = TRUE,
                          number_of_items,
                          number_of_cb = 1)
{
  models <- c()
  if (simple) models <- c(models, "SIMPLE")
  if (complex) models <- c(models, "COMPLEX")

  model_list <- unlist(
    replicate((number_of_items / number_of_cb),
              rep(sample(models)),
              simplify = FALSE))

}
