
create_content <- function(content_source, number_of_categories)
{
  # create a list of category-member pairs for the list
  content_pairs <- create_pairs(content_source, number_of_categories)
  
  # create a list of mixed up pairs that make no sense
  nonsense_pairs <- create_nonsense(content_pairs)
  
  # create list of midterm non-words
  mid_terms <- create_midterms(midterm_source)
  
  # create df of half content, half nonsense
  # select the first half of content and the second half of nonsense
  selected_pairs <- select_pairs(content_pairs, nonsense_pairs, mid_terms) 
  
  selected_pairs$mid_terms <- mid_terms
  
  return(selected_pairs)
  
}