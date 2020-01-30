
#' Create sensible pairs of categories and members.
#'
#' @param content_source A data frame of category-member combinations.
#' @param number_of_categories The number of categories to select from.
#' @param number_of_members The number of members per category to select from.
#'
#' @return A data frame of sensible category-member pairs.

create_pairs <- function(content_source,
                         number_of_categories,
                         number_of_members)
{
  # randomize order of the categories
  content <- sample_n(content_source, number_of_categories)

  # initialize data frame
  content_df <- data.frame(matrix(nrow = 0, ncol = 2),
                           stringsAsFactors = FALSE)

  # assign category-member pairings in category and member columns
  for (i in 1:number_of_members) {
    content_df <- rbind(
      content_df,
      data.frame(cat = content$cat,
                 mem = content[[paste0("mem", i)]],
                 stringsAsFactors = FALSE)
    )
  }

  return(content_df)
}


