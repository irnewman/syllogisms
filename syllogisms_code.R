
# ======================================================================= #
# syllogisms package: assorted code for creation                       ####
#
# Ian R Newman - ian.newman@usask.ca
#
# https://github.com/irnewman/syllogisms
# ======================================================================= #


# directions coming soon    ####
# ============================ #

library(syllogisms)

template_file <- read.table(paste0(here::here(),
                                   "\\source_files\\atmosphere_template.csv"),
                            header = TRUE,
                            sep = ",",
                            stringsAsFactors = FALSE)

create_stim_files(template_file,
                  content_source = syllogisms::content_pairs,
                  midterm_source = syllogisms::nonsense_words,
                  counterbalance_columns = c("type", "figure"),
                  believability_options = c("believable", "unbelievable"),
                  instructions_options = c("logic", "belief"),
                  number_of_categories = 12,
                  number_of_members = 4,
                  number_of_participants = 1)
