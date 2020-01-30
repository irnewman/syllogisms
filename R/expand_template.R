
#' Expands the template with necessary variables to fill with content.
#'
#' @param template A data frame of syllogism formats.
#' @param counterbalance_columns Vector of factors to counterbalance within.
#' @param believability_options Vector of levels of believability manipulation.
#' @param instructions_options Vector of levels of instructional manipulation.
#'
#' @return Template with columns used to fill template.

expand_template <- function(template,
                            counterbalance_columns,
                            believability_options,
                            instructions_options)
{

  # randomly allocate items to believability conditions
  expanded_template <- randomize_believability(
    compute_belief_limitations(template),
    counterbalance_columns,
    believability_options,
    instructions_options)

  # sort the data frame before returning
  expanded_template <-
    expanded_template[order(expanded_template$sensibility), ]

  return(expanded_template)
}
