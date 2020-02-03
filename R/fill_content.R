
#' Fills the template with the randomized content as stimuli items.
#'
#' @param template A data frame of syllogism formats.
#' @param content A data frame from create_pairs function of randomized content.
#'
#' @return Template with content filled into the item formats.

fill_content <- function(template, content)
{
  # check for misspecified template and content lengths
  if (nrow(template) != nrow(content)) {
    return(
      paste0(
        "Error: your template has ",
        nrow(template),
        " rows but you created ",
        nrow(content),
        " unique content combinations. ",
        "Please edit your create_content function call or your input template ",
        "file so these values match."
      )
    )
  }

  # create new columns in the template
  template$cat <- content$cat
  template$mem <- content$mem
  template$midterm <- content$mid_terms
  template$nonsense <- content$nonsense
  template$set_belief <- template$believability
  template$p1 <- template$p1_template
  template$p2 <- template$p2_template
  template$c <- template$c_template

  # if sensible = either, use set_belief and cat_is_A / cat_is_C to pick which
  template$category_calc <- ifelse(
    template$if_sensible == "either",
    ifelse(template$set_belief == template$cat_is_A, "A", "C"),
    "random"
  )

  # sort the template
  template <- template[order(template$category_calc), ]

  # find the number of A=category and A=member items so far
  number_of_c <- (nrow(template) / 2) - table(template$category_calc)[["C"]]
  number_of_a <- (nrow(template) / 2) - table(template$category_calc)[["A"]]

  # make sure there is an equal number of A=category and A=member items
  # NOTE: if the randomization makes that impossible, it will re-randomize
  #       in the create_stim_files function
  if (number_of_a < 0) {
    random_categories <- rep("C", number_of_c)
    template$re_run <- 1
  } else if (number_of_c < 0) {
    random_categories <- rep("A", number_of_a)
    template$re_run <- 1
  } else {
    random_categories <- sample(
      c(
        rep("A", number_of_a),
        rep("C", number_of_c)
      )
    )
    template$re_run <- 0
  }

  # variable to hold whether category was selected as A or C
  template$category <- c(
    template$category_calc[1:(nrow(template) - length(random_categories))],
    random_categories
  )

  # fill premise 1
  template$p1 <- ifelse(template$category == "A",
                        str_replace_all(template$p1, "\\bA\\b",
                                        template$cat),
                        str_replace_all(template$p1, "\\bA\\b",
                                        template$mem))
  template$p1 <- str_replace_all(
    template$p1, "\\bB\\b", template$midterm)

  # fill premise 2
  template$p2 <- ifelse(template$category == "A",
                        str_replace_all(template$p2, "\\bC\\b",
                                        template$mem),
                        str_replace_all(template$p2, "\\bC\\b",
                                        template$cat))
  template$p2 <- str_replace_all(
    template$p2, "\\bB\\b", template$midterm)

  # fill conclusion
  template$c <- ifelse(template$category == "A",
                        str_replace_all(template$c, "\\bA\\b",
                                        template$cat),
                        str_replace_all(template$c, "\\bC\\b",
                                        template$cat))

  template$c <- ifelse(template$category == "C",
                        str_replace_all(template$c, "\\bA\\b",
                                        template$mem),
                        str_replace_all(template$c, "\\bC\\b",
                                        template$mem))


  return(template)
}

