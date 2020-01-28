
#random_categories = TRUE,
#random_members = TRUE

create_content <- function(template,
                           content_source,
                           midterm_source,
                           number_of_categories = 0,
                           number_of_members = 0)
{
  # check for invalid inputs
  if (number_of_categories > nrow(content_source)) {
    return(print(paste0("Error: number of categories specified: ",
                        number_of_categories,
                        " exceeds maximum categories in content file selected."

    )))
  }

  if (number_of_members > ncol(content_source) - 1) {
    return(print(paste0("Error: number of members specified: ",
                        number_of_members,
                        ", exceeds maximum members in content file selected."
    )))
  }

  # set defaults to max per content file
  if (number_of_categories == 0) {
    number_of_categories <- nrow(content_source)
  }
  if (number_of_members == 0) {
    number_of_members <- ncol(content_source) - 1
  }

  # create a list of category-member pairs for the list
  content_pairs <- create_pairs(content_source,
                                number_of_categories,
                                number_of_members)

  # create a list of mixed up pairs that make no sense
  nonsense_pairs <- create_nonsense(content_pairs)

  # create list of midterm non-words
  number_of_items <- number_of_categories * number_of_members
  mid_terms <- create_midterms(midterm_source, number_of_items)

  # create df of half content, half nonsense
  number_of_sensible <- table(template$sensibility)[["sensible"]]

  # select the first half of content and the second half of nonsense
  selected_pairs <- select_pairs(content_pairs, nonsense_pairs, mid_terms,
                                 number_of_sensible)

  selected_pairs <- cbind(selected_pairs, mid_terms)
  colnames(selected_pairs) <- c("cat", "mem", "nonsense", "mid_terms")

  return(selected_pairs)

}
