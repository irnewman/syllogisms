
create_models <- function(simple = FALSE,
                          complex = TRUE,
                          number_of_items,
                          number_of_cb = 1)
{
  models <- c()
  if (simple) models <- c(models, "SIMPLE")
  if (complex) models <- c(models, "COMPLEX")
  
  model_list <- unlist(
    replicate((number_of_items / number_of_cb),
              rep(sample(models)), 
              simplify = FALSE))

}