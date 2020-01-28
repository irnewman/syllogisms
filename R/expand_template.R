
expand_template <- function(template,
                            counterbalance_columns,
                            believability_options,
                            instructions_options)
{

  expanded_template <- randomize_believability(
    compute_belief_limitations(template),
    counterbalance_columns,
    believability_options,
    instructions_options)

  expanded_template <-
    expanded_template[order(expanded_template$sensibility), ]

  return(expanded_template)

}
