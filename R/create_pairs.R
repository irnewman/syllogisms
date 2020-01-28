
create_pairs <- function(content_source,
                         number_of_categories,
                         number_of_members)
{
  # randomize content
  content <- sample_n(content_source, number_of_categories)

  # assign category-member pairings
  content_df <- data.frame(matrix(nrow = 0, ncol = 2),
                           stringsAsFactors = FALSE)

  for (i in 1:number_of_members) {
    content_df <- rbind(
      content_df,
      data.frame(cat = content$cat,
                 mem = content[[paste0("mem", i)]],
                 stringsAsFactors = FALSE)
    )
  }

  sorted_content <- content_df[order(content_df$cat),]



  return(content_df)
}


