
summarize_files <- function(filled_template)
{
  # unfinished, will load all csv in output folder, calculate summary, save
  # this is quickly hard coded for now, won't work for anything else yet

  t <- data.frame(
    f1 <- table(filled_template$figure)[[1]],
    f2 <- table(filled_template$figure)[[2]],
    f4 <- table(filled_template$figure)[[3]],

    t1 <- table(filled_template$type)[[1]],
    t2 <- table(filled_template$type)[[2]],
    t3 <- table(filled_template$type)[[3]],
    t4 <- table(filled_template$type)[[4]],

    valid <- table(filled_template$validity)[[1]],
    invalid <- table(filled_template$validity)[[2]],

    believable <- table(filled_template$believability)[[1]],
    unbelievable <- table(filled_template$believability)[[2]],

    A_is_category <- table(filled_template$category)[[1]],
    C_is_category <- table(filled_template$category)[[2]]
  )


  colnames(t) <- c("f1", "f2", "f4",
                   "t1", "t2", "t3", "t4",
                   "valid", "invalid",
                   "believable", "unbelievable",
                   "A_is_category", "C_is_category")


  return(t)

  # summary
  # table(filled_template$type)
  # table(filled_template$figure)
  # table(filled_template$models)
  # table(filled_template$complexity)
  # table(filled_template$validity)
  # table(filled_template$believability)
  # table(filled_template$category)
}
