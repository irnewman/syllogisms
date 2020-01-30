
#' Randomize the non-words in the stimuli.
#'
#' @param midterm_source A data frame of non-words.
#' @param number_of_items The total number of stimuli items in the template.
#'
#' @return The non-words randomly ordered.

create_midterms <- function(midterm_source, number_of_items)
{
  # randomly shuffle the non-words
  midterms <- data.frame(sample_n(midterm_source, number_of_items))

  return(midterms)
}
