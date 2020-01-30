
#' Generates randomized instructions for stimuli items.
#'
#' @param logic Boolean value to include logic instructions.
#' @param belief Boolean value to include belief instructions.
#' @param liking Boolean value to include liking instructions.
#' @param number_of_items The total number of stimuli items in the template.
#' @param number_of_cb The factor to balance instruction options in.
#'
#' @return A vector of instructions.

create_instructions <- function(logic = TRUE,
                                belief = TRUE,
                                liking = FALSE,
                                number_of_items,
                                number_of_cb = 1)
{
  options <- c()
  if (logic) options <- c(options, "LOGIC")
  if (belief) options <- c(options, "BELIEF")
  if (liking) options <- c(options, "LIKING")

  instructions <- unlist(
    replicate((number_of_items / number_of_cb),
              rep(sample(options)),
              simplify = FALSE))

  return(instructions)
}
