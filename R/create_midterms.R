
create_midterms <- function(midterm_source, number_of_items)
{
  # compute abstract middle terms
  midterms <- data.frame(sample_n(midterm_source, number_of_items))
  #midterms <- sample(mid_mix[1:number_of_items])

  return(midterms)
}
