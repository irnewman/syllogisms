
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

  # create stimuli folder
  stim_folder <- paste0(here::here(),
                        "\\stimfiles")

  if(file.exists(stim_folder)) {
    setwd(file.path(stim_folder))
  } else {
    dir.create(file.path(stim_folder))
    setwd(file.path(stim_folder))
  }

  # create folder for current set of stimuli creation
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


    outframe_filename <- paste0(getwd(),
                            "\\stimlist",
                            i, ".txt")

    template_filename <- paste0(getwd(),
                            "\\template",
                            i, ".csv")


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


    if (unique(filled_template$re_run == 1)) {
      # re do it all
      print("re-running")
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


    # EDIT THIS
    output_frame <- generate_outframe(filled_template)



    # save output files
    write.table(output_frame, outframe_filename,
                row.names = FALSE, quote = FALSE, sep="\t")

    write.table(filled_template, template_filename,
                row.names = FALSE, quote = FALSE, sep=",")

  }


}
