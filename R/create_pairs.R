
create_pairs <- function(content_source, number_of_categories) 
{
  # randomize content
  content <- sample_n(content_orig, number_of_categories) 
  
  # assign category-member pairings
  content_df = rbind(
    data.frame(cat = content$cat, mem = content$mem1,
               stringsAsFactors = FALSE),
    data.frame(cat = content$cat, mem = content$mem2,
               stringsAsFactors = FALSE),
    data.frame(cat = content$cat, mem = content$mem3,
               stringsAsFactors = FALSE),
    data.frame(cat = content$cat, mem = content$mem4,
               stringsAsFactors = FALSE)
  )
  
  return(content_df)
}