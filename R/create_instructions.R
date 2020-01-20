
create_instructions <- function(logic = TRUE,
                                belief = TRUE,
                                liking = FALSE,
                                number_of_items,
                                number_of_cb = 1)
{
  options <- c()
  if (logic) options <- c(options, "LOGIC")
  if (belief) options <- c(options, "BELIEF")
  if (liking) options <- c(options, "LIKING")
  
  instructions <- unlist(
    replicate((number_of_items / number_of_cb),
              rep(sample(options)), 
              simplify = FALSE))

  return(instructions)
}
