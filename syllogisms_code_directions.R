
# ======================================================================= #
# syllogisms package: directions for use                               ####
#
# Ian R Newman - ian.newman@usask.ca
#
# https://github.com/irnewman/syllogisms
# ======================================================================= #


# install/load the package  ####
# ============================ #
# Run this code to install the package from github. You can run it again to
# update the package to its latest version. This will also install 3 other
# packages if you do not have them (dplyr, stringr, here). Loading the package
# with "library(syllogisms)" will load all the required packages.

devtools::install_github("irnewman/syllogisms")
library(syllogisms)


# load the template file    ####
# ============================ #
# The user must load a template file in comma separated format. There are also
# required columns in the file for this package to work properly:

# item = a list of item numbers, one for each problem per stimuli list
# premise1 = single capital letter in AEIO format
# premise2 = single capital letter in AEIO format
# conclusion = single capital letter in AEIO format
# conc_format = either C-A or A-C
# complexity = specifying either simple or complex problem type
# validity = specifying validity of the problem
# figure = single numeral of 1, 2, 3, or 4 as problem figure format
# type = single numeral of 1, 2, 3, or 4 as problem atmosphere type

# The column header is case specific (i.e., "item" not "Item"). You may include
# any other columns you would like as identifiers, but the required columns
# must be included.

# This step is intended to be automated and further tested. Altering the
# arguments of the function below will likely result in errors currently.
# You may safely edit the number of categories, members, and participants.
# Ideally, this will be improved soon. Please contact me in the meantime if
# you have any issues.

# Running the below code will load the csv file into a data frame. There are
# other R functions other than read.table() than can load a file like this.
# All that is necessary is that the file is loaded as a data frame.

# You may need to edit part of this function to find where you saved your
# template file. Calling here::here() will use the current working directory
# of this R script. I use a subfolder called "source_files" but you may
# change that to any folder name or omit that step and remove that from the
# function call below. Similarly, you may rename your template file and alter
# the function call below.

# Running this will load your template file.
template_file <- read.table(paste0(here::here(),
                                   "\\source_files\\atmosphere_template.csv"),
                            header = TRUE,
                            sep = ",",
                            stringsAsFactors = FALSE)


# specify parameters        ####
# ============================ #
# Run the below function to generate your stimuli. You need to specify all of
# parameters carefully. Note that any files saved to this package can be
# updated or added to at any point. Also note that the number of items in your
# template file must be the same as number of categories * number of members.

# template_file = the name of the data frame you loaded your csv into
# content_source = a file of category-member pairs saved in the package
# midterm_source = a file of non-words saved in the package
# counterbalance_columns = conditions to balance believability/instructions in
# believability_options = conditions of the believability manipulation
# instructions_options = conditions of the instructional manipulation
# number_of_categories = number of categories (current max = 16) to select from
# number_of_members = number of members per category to select from
# number_of_participants = number of stimuli lists you would like to create

create_stim_files(template_file,
                  content_source = syllogisms::content_pairs,
                  midterm_source = syllogisms::nonsense_words,
                  counterbalance_columns = c("type", "figure"),
                  believability_options = c("believable", "unbelievable"),
                  instructions_options = c("logic", "belief"),
                  number_of_categories = 12,
                  number_of_members = 4,
                  number_of_participants = 1)


# That's all that is needed. The files should be saved into a timestamped folder
# as a subdirectory of the current working directory. Depending on the number
# of participants set, it may take a couple minutes to run to completion. On my
# (fairly old) computer, creating 100 lists took about 90 seconds.


# end                       ####
# ============================ #
