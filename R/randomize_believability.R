
randomize_believability <- function(template,
                                    counterbalance_columns,
                                    believability_options,
                                    instructions_options)
{

  return_template <- data.frame(matrix(nrow=0, ncol=ncol(template)+1))
  colnames(return_template) <- c(colnames(template), "believability")

  cb_factor <- length(believability_options) * length(instructions_options)

  # split template into groups based on counterbalancing variables
  grouped_template <- split(template,
                            template[counterbalance_columns], drop = TRUE)

  # check for counterbalancing issues
  if (nrow(grouped_template[[1]]) %% cb_factor != 0) {
    return(print("Error: counterbalancing does not factor evenly"))
  }


  for (i in 1:length(grouped_template)) {

    current_group <- data.frame(grouped_template[[i]])

    # randomize order of current group
    current_group <- current_group[sample(nrow(current_group)), ]

    # if all are the same or all are different
    if (length(unique(current_group$problem_type)) == 1
        | length(unique(current_group$problem_type)) == nrow(current_group)) {

      bel <- sample(
        rep(sample(believability_options),
                 (nrow(current_group) / length(believability_options)))
      )
      current_group$believability <- bel
    }

    sorted_group <- current_group[order(current_group$believability), ]


    sorted_group$instructions <- unlist(replicate(
      nrow(sorted_group) / length(instructions_options),
      sample(instructions_options), simplify = FALSE))


    # fill in the "either" options
    sorted_group$sensibility[
      sorted_group$sensibility == "either" &
        sorted_group$believability == "believable" &
        sorted_group$if_sensible == "unbelievable"] <- "nonsense"

    sorted_group$sensibility[
      sorted_group$sensibility == "either" &
        sorted_group$believability == "unbelievable" &
        sorted_group$if_sensible == "unbelievable"] <- "sensible"

    sorted_group$sensibility[
      sorted_group$sensibility == "either" &
        sorted_group$believability == "believable" &
        sorted_group$if_sensible == "believable"] <- "sensible"

    sorted_group$sensibility[
      sorted_group$sensibility == "either" &
        sorted_group$believability == "unbelievable" &
        sorted_group$if_sensible == "believable"] <- "nonsense"

    return_template <- rbind(return_template, sorted_group)
  }


  return(return_template)

  # in this condition:
  # if all conclusion+conc_format are the same, just split evenly and randomize
      # what if the counterbalancing is not a factor that's an even number???

  # instructions <- unlist(
  #   replicate((number_of_items / number_of_cb),
  #             rep(sample(options)),
  #             simplify = FALSE))
  # if length of this = 1, they are the same, so just randomize

  # length == nrow(that group), they are all different, so just randomize

  # otherwise, find the matching ones, if any (not sure how yet)


  # actually, find any that match, then randomize those, but not that simple

}
