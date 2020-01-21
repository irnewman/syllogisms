
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

  template$p1 <- template$p1_template
  template$p2 <- template$p2_template
  template$c <- template$c_template


  template$p1 <- str_replace_all(
    template$p1, "\\bA\\b", content$cat)
  template$p1 <- str_replace_all(
    template$p1, "\\bB\\b", content$mid_terms)

  template$p2 <- str_replace_all(
    template$p2, "\\bB\\b", content$mid_terms)
  template$p2 <- str_replace_all(
    template$p2, "\\bC\\b", content$mem)

  template$c <- str_replace_all(
    template$c, "\\bA\\b", content$cat)
  template$c <- str_replace_all(
    template$c, "\\bC\\b", content$mem)

  template$nonsense <- content$nonsense



  filled_template <- template %>%
    mutate(believability = case_when(

      (conc_format == "C-A"
       & conclusion == "O"
       & nonsense == 0) ~ "unbelievable",
      (conc_format == "C-A"
       & conclusion == "O"
       & nonsense == 1) ~ "believable",

      (conc_format == "C-A"
       & conclusion == "E"
       & nonsense == 0) ~ "unbelievable",
      (conc_format == "C-A"
       & conclusion == "E"
       & nonsense == 1) ~ "believable",

      (conc_format == "C-A"
       & conclusion == "I"
       & nonsense == 0) ~ "believable",
      (conc_format == "C-A"
       & conclusion == "I"
       & nonsense == 1) ~ "unbelievable",

      (conc_format == "C-A"
       & conclusion == "A"
       & nonsense == 0) ~ "unbelievable",
      (conc_format == "C-A"
       & conclusion == "A"
       & nonsense == 1) ~ "unbelievable",

      (conc_format == "A-C"
       & conclusion == "O"
       & nonsense == 0) ~ "believable",
      (conc_format == "A-C"
       & conclusion == "O"
       & nonsense == 1) ~ "believable",

      (conc_format == "A-C"
       & conclusion == "E"
       & nonsense == 0) ~ "unbelievable",
      (conc_format == "A-C"
       & conclusion == "E"
       & nonsense == 1) ~ "believable",

      (conc_format == "A-C"
       & conclusion == "I"
       & nonsense == 0) ~ "believable",
      (conc_format == "A-C"
       & conclusion == "I"
       & nonsense == 1) ~ "unbelievable",

      (conc_format == "A-C"
       & conclusion == "A"
       & nonsense == 0) ~ "unbelievable",
      (conc_format == "A-C"
       & conclusion == "A"
       & nonsense == 1) ~ "unbelievable",
    ))


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






  return(template)

}


##test_content <- sample_n(content, 48)
#content <- test_content


