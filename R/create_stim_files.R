
#' Wrapper function to automate stimuli list creation.
#'
#' @param template_file User provided data frame of syllogism formats.
#' @param content_source A data frame of category-member combinations.
#' @param midterm_source A data frame of non-words.
#' @param counterbalance_columns Vector of factors to counterbalance within.
#' @param believability_options Vector of levels of believability manipulation.
#' @param instructions_options Vector of levels of instructional manipulation.
#' @param number_of_categories The number of categories to select from.
#' @param number_of_members The number of members per category to select from.
#' @param number_of_participants The number of lists to create, 1 per person.
#'
#' @return Nothing - but timestamped folder of files generated.

create_stim_files <- function(template_file,
                              content_source,
                              midterm_source,
                              counterbalance_columns,
                              believability_options,
                              instructions_options,
                              number_of_categories,
                              number_of_members,
                              number_of_participants)
{

  # create parent stimuli folder
  stim_folder <- paste0(here::here(),
                        "\\stimfiles")
  if(file.exists(stim_folder)) {
    setwd(file.path(stim_folder))
  } else {
    dir.create(file.path(stim_folder))
    setwd(file.path(stim_folder))
  }

  # create timestamped folder for current set of stimuli creation
  timestamp_folder <- paste0(getwd(),
                             "\\",
                        format(Sys.time(), "%F__%H-%M"))
  if(file.exists(timestamp_folder)) {
    setwd(file.path(timestamp_folder))
  } else {
    dir.create(file.path(timestamp_folder))
    setwd(file.path(timestamp_folder))
  }


  for (i in 1:number_of_participants) {

    # set unique filename per participant
    outframe_filename <- paste0(getwd(),
                            "\\stimlist",
                            i, ".txt")
    template_filename <- paste0(getwd(),
                            "\\template",
                            i, ".csv")

    # compute template columns
    template <- expand_template(template_file,
                                counterbalance_columns,
                                believability_options,
                                instructions_options)

    # generate randomized content
    content <- create_content(template,
                              content_source,
                              midterm_source,
                              number_of_categories,
                              number_of_members)

    # fill template with content
    filled_template <- fill_template(template, content)

    # if imbalanced randomization found, re-run
    if (unique(filled_template$re_run == 1)) {
      template <- expand_template(template_file,
                                  counterbalance_columns,
                                  believability_options,
                                  instructions_options)
      content <- create_content(template,
                                content_source,
                                midterm_source,
                                number_of_categories,
                                number_of_members)
      filled_template <- fill_template(template, content)
    }

    # create E-prime output
    output_frame <- generate_outframe(filled_template)

    # save output files
    write.table(output_frame, outframe_filename,
                row.names = FALSE, quote = FALSE, sep="\t")
    write.table(filled_template, template_filename,
                row.names = FALSE, quote = FALSE, sep=",")

  }
}
