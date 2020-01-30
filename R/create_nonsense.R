
#' Create nonsense pairs of categories and members.
#'
#' @param content_pairs A data frame of sensible category-member pairs.
#'
#' @return A data frame of nonsense category-member pairs.

create_nonsense <- function(content_pairs)
{
  # initialize variables
  nonsense <- content_pairs
  number_of_items <- length(nonsense$cat)
  number_of_categories <- length(unique(nonsense$cat))
  category_length <- number_of_items / number_of_categories

  # content pairs are listed ungrouped, this finds how many repetitions in list
  number_of_sections <- number_of_items / number_of_categories

  # pair category with member from a different category, unique every time
  for (i in 1:number_of_sections) {
    indices <- c(
      (1 + ((i-1) * number_of_categories)):
         (number_of_categories + ((i-1) * number_of_categories))
                  )

    old_members <- nonsense$mem[indices]
    new_members <- c(old_members[-1:-i], old_members[1:i])
    nonsense$mem[indices] <- new_members
  }

  return(nonsense)
}
