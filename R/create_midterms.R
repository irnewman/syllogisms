
create_midterms <- function(midterm_source) 
{
  number_of_items <- length(midterm_source$midterm)
  
  # compute abstract middle terms
  mid_mix <- sample(midterm_source$midterm)
  midterms <- sample(mid_mix[1:number_of_items])
  
  return(midterms)
}