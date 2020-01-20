

select_pairs <- function(content_pairs, nonsense_pairs, mid_terms) 
{
  number_of_items <- length(content_pairs$cat)
  
  # FIX
  
  sorted_content <- content_pairs[order(content_pairs$cat),]
  sorted_content$believable <- 1
  sorted_nonsense <- nonsense_pairs[order(nonsense_pairs$cat),]
  sorted_nonsense$believable <- 0
  
  selected_content <- sorted_content %>%
    filter(row_number() %% 2 == 0)
  
  selected_nonsense <- sorted_nonsense %>%
    filter(row_number() %% 2 == 1)
  
  joined_pairs <- rbind(selected_content, selected_nonsense)
  
  mixorder <- sample(1:number_of_items)
  
  selected_pairs <- joined_pairs[mixorder, ]
  
  # #df %>% dplyr::filter(row_number() %% 2 == 0) ## Select even rows
  # #df %>% dplyr::filter(row_number() %% 2 == 1) ## Select odd rows
  # 
  # # need a better way to ensure half/half in each
  # content_mix <- content_pairs[mixorder,]
  # content_mix_nonsense = nonsense_pairs[mixorder,]
  # 
  # # believable and unbelievable combinations
  # content_mix_single_b <- 
  #   content_mix[1:(number_of_items/2),]
  # content_mix_single_ub <-
  #   content_mix_nonsense[((number_of_items/2)+1):number_of_items,]
  # 
  # content_mix <- rbind(content_mix_single_b, content_mix_single_ub)
  
  return(selected_pairs)
}


# 
# t <- content_pairs %>% 
#   group_by(cat) %>%
#   filter(row_number() <= cat * n())