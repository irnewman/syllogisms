
fill_content <- function(template, content)
{
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

  template$cat <- content$cat
  template$mem <- content$mem
  template$midterm <- content$mid_terms
  template$nonsense <- content$nonsense
  template$set_belief <- template$believability

  template$p1 <- template$p1_template
  template$p2 <- template$p2_template
  template$c <- template$c_template




  # IF SENSIBLE = EITHER, use set_belief and cat_is_A / cat_is_C to pick which


  template$category_calc <- ifelse(
    template$if_sensible == "either",
    ifelse(template$set_belief == template$cat_is_A, "A", "C"),
    "random"
  )

  template <- template[order(template$category_calc), ]





  #print(table(template$category))





  number_of_c <- (nrow(template) / 2) - table(template$category)[["C"]]
  number_of_a <- (nrow(template) / 2) - table(template$category)[["A"]]

  print(number_of_a)
  print(number_of_c)



  if (number_of_a < 1) {
    random_categories <- rep("C", number_of_c)
    template$re_run <- 1
  } else if (number_of_c < 1) {
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



  template$category <- c(
    template$category_calc[1:(nrow(template) - length(random_categories))],
    random_categories
  )



  # premise 1
  template$p1 <- ifelse(template$category == "A",
                        str_replace_all(template$p1, "\\bA\\b",
                                        template$cat),
                        str_replace_all(template$p1, "\\bA\\b",
                                        template$mem))
  template$p1 <- str_replace_all(
    template$p1, "\\bB\\b", template$midterm)

  # premise 2
  template$p2 <- ifelse(template$category == "A",
                        str_replace_all(template$p2, "\\bC\\b",
                                        template$mem),
                        str_replace_all(template$p2, "\\bC\\b",
                                        template$cat))
  template$p2 <- str_replace_all(
    template$p2, "\\bB\\b", template$midterm)


  # conclusion
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


##test_content <- sample_n(content, 48)
#content <- test_content


#
#     template$p2 <- str_replace_all(
#       template$p2, "\\bB\\b", template$mid_terms)
#     template$p2 <- str_replace_all(
#       template$p2, "\\bC\\b", template$mem)
#
#     template$c <- str_replace_all(
#       template$c, "\\bA\\b", template$cat)
#     template$c <- str_replace_all(
#       template$c, "\\bC\\b", template$mem)
#
#
#
#
#   template$p1 <- str_replace_all(
#     template$p1, "\\bA\\b", content$cat)
#   template$p1 <- str_replace_all(
#     template$p1, "\\bB\\b", content$mid_terms)
#
#   template$p2 <- str_replace_all(
#     template$p2, "\\bB\\b", content$mid_terms)
#   template$p2 <- str_replace_all(
#     template$p2, "\\bC\\b", content$mem)
#
#   template$c <- str_replace_all(
#     template$c, "\\bA\\b", content$cat)
#   template$c <- str_replace_all(
#     template$c, "\\bC\\b", content$mem)

#template$nonsense <- content$nonsense



# filled_template <- template %>%
#   mutate(believability = case_when(
#
#     (conc_format == "C-A"
#      & conclusion == "O"
#      & nonsense == 0) ~ "unbelievable",
#     (conc_format == "C-A"
#      & conclusion == "O"
#      & nonsense == 1) ~ "believable",
#
#     (conc_format == "C-A"
#      & conclusion == "E"
#      & nonsense == 0) ~ "unbelievable",
#     (conc_format == "C-A"
#      & conclusion == "E"
#      & nonsense == 1) ~ "believable",
#
#     (conc_format == "C-A"
#      & conclusion == "I"
#      & nonsense == 0) ~ "believable",
#     (conc_format == "C-A"
#      & conclusion == "I"
#      & nonsense == 1) ~ "unbelievable",
#
#     (conc_format == "C-A"
#      & conclusion == "A"
#      & nonsense == 0) ~ "unbelievable",
#     (conc_format == "C-A"
#      & conclusion == "A"
#      & nonsense == 1) ~ "unbelievable",
#
#     (conc_format == "A-C"
#      & conclusion == "O"
#      & nonsense == 0) ~ "believable",
#     (conc_format == "A-C"
#      & conclusion == "O"
#      & nonsense == 1) ~ "believable",
#
#     (conc_format == "A-C"
#      & conclusion == "E"
#      & nonsense == 0) ~ "unbelievable",
#     (conc_format == "A-C"
#      & conclusion == "E"
#      & nonsense == 1) ~ "believable",
#
#     (conc_format == "A-C"
#      & conclusion == "I"
#      & nonsense == 0) ~ "believable",
#     (conc_format == "A-C"
#      & conclusion == "I"
#      & nonsense == 1) ~ "unbelievable",
#
#     (conc_format == "A-C"
#      & conclusion == "A"
#      & nonsense == 0) ~ "unbelievable",
#     (conc_format == "A-C"
#      & conclusion == "A"
#      & nonsense == 1) ~ "unbelievable",
#   ))


# IF C-A
# O = are not, nonsense FALSE = unbelievable, TRUE = believable
# E = No are, nonsense TRUE = believable, FALSE = unbelievable
# I = some are, nonsense TRUE = unbelievable, FALSE = believable
# A = all are, nonsense TRUE = unbelievable, FALSE = unbelievable too

# IF A-C
# O = are not, nonsense FALSE = believable, nonsense TRUE = believable too
# E = No are, nonsense FALSE = unbelievable, TRUE = believable
# I = some are, nonsense TRUE = unbelievable, FALSE = believable
# A = all are, nonsense TRUE = unbelievable, FALSE = unbelievable too








# does the negation reverse the believability of the conclusion?
# template$bel_switch <- ifelse(
#   (str_detect(template$c, "not") | str_detect(template$c, "No")),
#   1, 0)


# template$believability <- ifelse(
#   template$nonsense == 0,
#   ifelse(template$bel_switch == 0, "believable", "unbelievable"),
#   ifelse(template$bel_switch == 0, "unbelievable", "believable")
# )


#template$category[template$category == "random"] <- sample(c("A", "C"))




# IF if_sensible = believable
# and sensibility = sensible THEN believable
# THEN COMPARE set_belief to cat_is_A and cat_is_C columns and MATCH

# IF if_sensible = believable
# and sensibility = nonsense THEN unbelievable

# IF if_sensible = unbelievable
# and sensibility = sensible THEN unbelievable

# IF if_sensible = unbelievable
# and sensibility = nonsense THEN believable


#
#   filled_template[
#     filled_template$cat_is_A == "either"
#     & filled_template$cat_is_C == "either"] <- sample(c("A", "C"), 1)
#
#
#
#   filled_template$category <- lapply(sample(c("A", "C"), 1))
#
#
#
#
#   filled_template <- template %>%
#     mutate(category = case_when(
#       (cat_is_A == "either" & cat_is_C == "either") ~ sample(c("A", "C"), 1,
#                                                              replace = TRUE)
#       )
#
#
#
#       )





# If set_belief == believable
# and IF sensible = believable
# then if cat_is_A is:
# believable then set A=category
# unbelievable then set A=member
# either then randomly pick A=category or A=member
