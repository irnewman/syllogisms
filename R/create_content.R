
#' Create randomized content in order to fill the template
#'
#' @param template A data frame of syllogism formats.
#' @param content_source A data frame of category-member combinations.
#' @param midterm_source A data frame of nonsense non-words.
#' @param number_of_categories The number of categories to select from.
#' @param number_of_members The number of members per category to select from.
#'
#' @return A data frame of randomized content combinations.

create_content <- function(template,
                           content_source,
                           midterm_source,
                           number_of_categories = 0,
                           number_of_members = 0)
{
  # check for invalid number of categories
  if (number_of_categories > nrow(content_source)) {
    return(print(paste0("Error: number of categories specified: ",
                        number_of_categories,
                        " exceeds maximum categories in content file selected."

    )))
  }

  # check for invalid number of members
  if (number_of_members > ncol(content_source) - 1) {
    return(print(paste0("Error: number of members specified: ",
                        number_of_members,
                        ", exceeds maximum members in content file selected."
    )))
  }

  # fix column names if not lowercase
  colnames(template) <- tolower(colnames(template))
  colnames(content_source) <- tolower(colnames(content_source))
  colnames(midterm_source) <- tolower(colnames(midterm_source))


  # set defaults to max per content file
  if (number_of_categories == 0) {
    number_of_categories <- nrow(content_source)
  }
  if (number_of_members == 0) {
    number_of_members <- ncol(content_source) - 1
  }

  # create a list of sensible category-member pairs
  content_pairs <- create_pairs(content_source,
                                number_of_categories,
                                number_of_members)

  # create a list of nonsense category-member
  nonsense_pairs <- create_nonsense(content_pairs)

  # create list of midterm non-words
  number_of_items <- number_of_categories * number_of_members
  mid_terms <- create_midterms(midterm_source, number_of_items)

  # determine how many nonsense pairs are required for the stimuli
  number_of_sensible <- table(template$sensibility)[["sensible"]]

  # select the sensible and nonsense content
  selected_pairs <- select_pairs(content_pairs, nonsense_pairs, mid_terms,
                                 number_of_sensible)
  selected_pairs <- cbind(selected_pairs, mid_terms)
  colnames(selected_pairs) <- c("cat", "mem", "nonsense", "mid_terms")

  return(selected_pairs)
}
