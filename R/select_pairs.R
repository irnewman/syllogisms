
#' Select the content pairs from sensible, nonsense, and non-words.
#'
#' @param content_pairs A data frame of sensible category-member pairs.
#' @param nonsense_pairs A data frame of nonsense category-member pairs.
#' @param mid_terms A data frame of non-words.
#' @param number_of_sensible The number of sensible pairs to use.
#'
#' @return A data frame of the selected content for the list.

select_pairs <- function(content_pairs,
                         nonsense_pairs,
                         mid_terms,
                         number_of_sensible)
{
  # split content into groups
  groups <- content_pairs %>% group_split(cat)  # no need to sort then
  group_length <- nrow(groups[[1]])
  number_of_groups <- nrow(content_pairs) / group_length

  # initialize data frame
  selected_content <- data.frame(matrix(nrow=0, ncol = 2))
  colnames(selected_content) <- c(colnames(content_pairs))

  # max order of groups
  t_order <- rep(1:number_of_groups, group_length)

  # limit of that order as the number of sensible, remaining are nonsense
  order <- t_order[1:number_of_sensible]
  content_order <- c()

  # frequency of each category
  sample_numbers <- table(order)

  # select only the number of sensible, taking 1 from each category at a time
  for (i in 1:number_of_groups) {
    selected_content <- rbind(selected_content,
                              sample_n(groups[[i]],
                                       sample_numbers[[i]]))
    for (j in 1:sample_numbers[[i]]) {
      multiplier <- (j - 1) * number_of_groups
      content_order <- c(content_order, (i + multiplier))
    }
  }
  selected_content$nonsense <- 0

  # the remaining items are nonsense
  unselected_content <- content_pairs %>%
    filter(!(mem %in% selected_content$mem))

  # if there are some nonsense, randomize their category-member pairs
  if (nrow(unselected_content) > 0) {
    nonsense_content <- create_nonsense(unselected_content)
    nonsense_content$nonsense <- 1
    total_content <- rbind(nonsense_content, selected_content)
    total_content$order <- c(1:nrow(nonsense_content),
                             content_order + nrow(nonsense_content))
    # otherwise, only use the selected sensible content
  } else {
    # re-order the selections so no repetitions within a condition
    selected_content$order <- content_order
    total_content <- selected_content
  }

  total_content <- total_content[order(total_content$order), ]
  total_content$order <- NULL

  return(total_content)
}

