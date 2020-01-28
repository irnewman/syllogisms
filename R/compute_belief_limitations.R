

# unfinished, not sure if all I have here is necessary
# RENAME THIS FUNCTION TOO

compute_belief_limitations <- function(template)
{

  template <- template %>%
    mutate(
      sensibility = case_when(
        (conclusion == "O" | conclusion == "A") ~ "sensible",
        (conclusion == "E" | conclusion == "I") ~ "either"
      )
    ) %>%
    mutate(
      cat_is_A = case_when(
        (conclusion == "O" & conc_format == "C-A") ~ "unbelievable",
        (conclusion == "O" & conc_format == "A-C") ~ "believable",
        (conclusion == "A" & conc_format == "C-A") ~ "unbelievable",
        (conclusion == "A" & conc_format == "A-C") ~ "believable",
        (conclusion == "I") ~ "either",
        (conclusion == "E") ~ "either"
      )
    ) %>%
    mutate(
      cat_is_C = case_when(
        (conclusion == "O" & conc_format == "C-A") ~ "believable",
        (conclusion == "O" & conc_format == "A-C") ~ "unbelievable",
        (conclusion == "A" & conc_format == "C-A") ~ "believable",
        (conclusion == "A" & conc_format == "A-C") ~ "unbelievable",
        (conclusion == "I") ~ "either",
        (conclusion == "E") ~ "either"
      )
    ) %>%
    mutate(
      if_sensible = case_when(
        (conclusion == "O" | conclusion == "A") ~ "either",
        (conclusion == "I") ~ "believable",
        (conclusion == "E") ~ "unbelievable"
      )
    ) %>%
    mutate(
      problem_type = paste0(premise1, premise2, conclusion, "-",
                            str_remove(conc_format, "-"))
    )

  return(template)
}
