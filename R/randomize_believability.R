
#' Randomly allocate which items are which believability condition in this list.
#'
#' @param template A data frame of syllogism formats.
#' @param counterbalance_columns Vector of factors to counterbalance within.
#' @param believability_options Vector of levels of believability manipulation.
#' @param instructions_options Vector of levels of instructional manipulation.
#'
#' @return Template with columns for believability and instructions set.

randomize_believability <- function(template,
                                    counterbalance_columns,
                                    believability_options,
                                    instructions_options)
{
  # initialize data frame
  return_template <- data.frame(matrix(nrow=0, ncol=ncol(template)+1))
  colnames(return_template) <- c(colnames(template), "believability")

  # determine the factor that the counterbalancing must evenly divide into
  cb_factor <- length(believability_options) * length(instructions_options)

  # split template into groups based on counterbalancing variables
  grouped_template <- split(template,
                            template[counterbalance_columns], drop = TRUE)

  # check for counterbalancing issues
  if (nrow(grouped_template[[1]]) %% cb_factor != 0) {
    return(print("Error: counterbalancing does not factor evenly"))
  }


  for (i in 1:length(grouped_template)) {

    # randomize order of items within each group
    current_group <- data.frame(grouped_template[[i]])
    current_group <- current_group[sample(nrow(current_group)), ]

    # if all item formats are the same or all are different, randomly sample all
    # currently: randomly samples all anyway, may change eventually
    if (length(unique(current_group$problem_type)) == 1
        | length(unique(current_group$problem_type)) == nrow(current_group)
        | length(current_group$problem_type) == nrow(current_group)) {
      bel <- sample(
        rep(sample(believability_options),
                 (nrow(current_group) / length(believability_options)))
      )
      current_group$believability <- bel
    }

    # sort the current group to balance instructions with believability
    sorted_group <- current_group[order(current_group$believability), ]
    sorted_group$instructions <- unlist(replicate(
      nrow(sorted_group) / length(instructions_options),
      sample(instructions_options), simplify = FALSE))

    # fill in the "either" options based on the randomly selected believability
    # NOTE: if either sensibility will work, then need to check whether each
    #       item is believable or unbelievable, and which sensibilitity is
    #       allowed in that case
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
}
