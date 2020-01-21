
# ======================================================================= #
# syllogisms package: assorted code for creation                       ####
#
# Ian R Newman - ian.newman@usask.ca
#
# https://github.com/irnewman/syllogisms
# ======================================================================= #


# load libraries            ####
# ============================ #

library(dplyr)
library(stringr)
library(here)
library(syllogisms)


# load source files         ####
# ============================ #

# step 1 - load your content and template files
## this will be automated in the future
## also, these default files are saved within the package, but are left here
## to be as explicit as possible
## you may also wish to load other files than the default - simply edit the
## code below to load your prefered file(s)
## note: template file needs same number of rows as categories * members

# category-member content, original file
content_source <- read.table(paste0(here::here(),
                             "\\source_files\\content_orig.txt"),
                         header = TRUE,
                         stringsAsFactors = FALSE)
colnames(content_source) <- tolower(colnames(content_source))

# nonsense midterms
midterm_source <- read.table(paste0(here::here(),
                                    "\\source_files\\midterms.txt"),
                             header = TRUE,
                             stringsAsFactors = FALSE)
colnames(midterm_source) <- tolower(colnames(midterm_source))

# load template file
template_file <- read.table(paste0(here::here(),
                                   "\\source_files\\atmosphere_template.csv"),
                            header = TRUE,
                            sep = ",",
                            stringsAsFactors = FALSE)




# init variables            ####
# ============================ #

number_of_participants <- 1
number_of_categories <- 12
number_of_members <- 4
number_of_items <- 48

# step 2 - specify content
## content_source = text file of category-member pairs
## number_of_categories = the number of categories from the list to use
## number_of_members= the number of members from each category to use
## random_categories = whether the categories are picked randomly per
  ## participant or if they are fixed as the same for all participants
## random_members = selecting members from selected categories randomly, or
  ## fixed for all participants


# randomize a set of content pairs
content <- create_content(content_source,
                          midterm_source,
                          number_of_categories,
                          number_of_members)

                          #random_categories = TRUE,
                          #random_members = TRUE)
# NOTE: some of the random/fixed features are not fully finished
  # categories <- c("list of the categories")
  # members <- c(1, 2, 4) or list of columns


# step 3 - specify while instructions you would like to use and counterbalance
# generate list of response options
# create list of instructions (and their options)
# NOTE: number_of_cb = number of counterbalanced instruction options
# EXAMPLE:
# 48 items
# 4 atmosphere types
# 2 believability
# 2 instructions, logic/belief
# 3 figures
####
# 4 x 2 x 3 = 24, x 2 instructions = 48
# therefore, you want number_of_cb = 2, so that LOGIC/BELIEF instructions are
# balanced within every 2 rows of the file, within each condition
# MUST be changed for each new experiment, to make sure items/conditions are
# balanced
instruction_list <- create_instructions(logic = TRUE,
                                         belief = TRUE,
                                         liking = FALSE,
                                         number_of_items,
                                         number_of_cb = 2)


# step 4 - specify if manipulating number of models
# list of syllogism models
model_list <- create_models(simple = FALSE,
                            complex = TRUE,
                            number_of_items)


# step 5 - initialize the output data frame per person
# create an output template
output_frame <- generate_outframe(number_of_items,
                                  instruction_list,
                                  model_list)




# step 6 - fill the loaded template with content
template <- fill_template(template_file, content)






# put p1, p2, c in outframe
output_frame$PREM1 <- template$p1
output_frame$PREM2 <- template$p2
output_frame$CONC <- template$c




# compute belief-switch based on the negation or not in the conclusion
#template$bel_switch <- ifelse(template$c == "No", 1, 0)

# template$bel_switch <- ifelse(
#   (str_detect(template$c, "not") | str_detect(template$c, "No")),
#   1, 0)


# compute belief switch in template
  # test thoroughly
# add belief, validity, atmos, figure to outframe







# notes                     ####
# ============================ #

### A = category
#   B = nonsense
#   C = member


### assume we use an input file that contains:
# type/atmosphere
# figure
# quantifier
# conclusion
# validity
# number of models (in this instance, all complex)

### we need to create
# content pairs
  # including unbelievable pairings
# believability
# nonsense midterms
# instructions
# response options
# syllogism/item number
# fill the input file, keeping track of negations


### quantifier
# A = All are
# E = No are
# I = Some are
# O = Some are not

### conclusion
# c_a = e.g. some C are A
# a_c = e.g. some A are C


# F1
# create a list of category-member pairs for the list
#content_pairs <- create_pairs(content_source, number_of_categories)

# F2
# create a list of mixed up pairs that make no sense
#nonsense_pairs <- create_nonsense(content_pairs)

# F3
# create list of midterm non-words
# Note: this is a vector only, not a df
#mid_terms <- create_midterms(midterm_source)

# F4
# create df of half content, half nonsense
# select the first half of content and the second half of nonsense
#selected_pairs <- select_pairs(content_pairs, nonsense_pairs, mid_terms)

# maybe:
# put f1 to f4 into its own function






# F5









# goal: data frame with (in any order)
# 1. complexity (single, multiple models)
# 2. instructions (belief, logic, liking)
# 3. premise1, premise2, conclusion,
# 4. valid/belief/liking option
# 5. converse of #4, so invalid/unbelievable/dislike, or whatever
# 6. syllogism number
# 7. believability
# 8. validity
# 9. atmosphere
# 10. figure













# add files to package      ####
# ============================ #
