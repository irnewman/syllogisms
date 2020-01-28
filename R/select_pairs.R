

select_pairs <- function(content_pairs,
                         nonsense_pairs,
                         mid_terms,
                         number_of_sensible)
{

  groups <- content_pairs %>% group_split(cat)  # no need to sort then

  group_length <- nrow(groups[[1]])

  number_of_groups <- nrow(content_pairs) / group_length

  selected_content <- data.frame(matrix(nrow=0, ncol=2)) # edit colnum
  colnames(selected_content) <- c(colnames(content_pairs))

  #number_of_sensible <- content_numbers[["sensible"]][1]

  t_order <- rep(1:number_of_groups, group_length)

  order <- t_order[1:number_of_sensible]

  sample_numbers <- table(order)


  for (i in 1:number_of_groups) {
    selected_content <- rbind(selected_content,
                              sample_n(groups[[i]],
                              sample_numbers[[i]]))
  }


  unselected_content <- content_pairs %>%
    filter(!(mem %in% selected_content$mem))


  nonsense_content <- create_nonsense(unselected_content)


  selected_content$nonsense <- 0
  nonsense_content$nonsense <- 1

  total_content <- rbind(nonsense_content, selected_content)

  # return this with nonsense at the bottom
  # then sort the template to have nonsense at the bottom
  # attach columns, resort back to previous format


  return(total_content)
}

