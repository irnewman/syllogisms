
# ======================================================================= #
# syllogisms package: assorted code for creation                       ####
#
# Ian R Newman - ian.newman@usask.ca
#
# https://github.com/irnewman/syllogisms
# ======================================================================= #


# load libraries            ####
# ============================ #

library(syllogisms)


# load template file
template_file <- read.table(paste0(here::here(),
                                   "\\source_files\\atmosphere_template.csv"),
                            header = TRUE,
                            sep = ",",
                            stringsAsFactors = FALSE)


start_time <- Sys.time()
create_stim_files(template_file,
                  content_source = syllogisms::content_pairs,
                  midterm_source = syllogisms::nonsense_words,
                  counterbalance_columns <- c("type", "figure"),
                  believability_options <- c("believable", "unbelievable"),
                  instructions_options <- c("logic", "belief"),
                  number_of_categories = 12,
                  number_of_members = 4,
                  number_of_participants = 100)
end_time <- Sys.time()
end_time - start_time

# library(dplyr)
# library(stringr)
# library(here)
# data.table::fwrite(template, "working_template.csv")

# load source files         ####
# ============================ #

# category-member content, original file
content_source <- syllogisms::content_pairs

# nonsense midterms
midterm_source <- syllogisms::nonsense_words


#template <- template_file  # for testing
# note: going to rename this function




# init variables            ####
# ============================ #

number_of_participants <- 1
number_of_categories <- 12
number_of_members <- 4
number_of_items <- 48

# specify these values for each study
counterbalance_columns <- c("type", "figure")
believability_options <- c("believable", "unbelievable")
instructions_options <- c("logic", "belief")


# create stimuli files      ####
# ============================ #



create_stim_files(template_file,
                  content_source,
                  midterm_source,
                  counterbalance_columns,
                  believability_options,
                  instructions_options,
                  number_of_categories,
                  number_of_members,
                  number_of_participants)













#
#
# template <- expand_template(template_file,
#                             counterbalance_columns,
#                             believability_options,
#                             instructions_options)
#
# # randomize a set of content pairs
# content <- create_content(template,
#                           content_source,
#                           midterm_source,
#                           number_of_categories,
#                           number_of_members)
#
#
#
# # step 6 - fill the loaded template with content
# filled_template <- fill_template(template, content)
#
#
#






# step 1 - load your content and template files
## this will be automated in the future
## also, these default files are saved within the package, but are left here
## to be as explicit as possible
## you may also wish to load other files than the default - simply edit the
## code below to load your prefered file(s)
## note: template file needs same number of rows as categories * members


# content_source <- read.table(paste0(here::here(),
#                              "\\source_files\\content_orig.txt"),
#                          header = TRUE,
#                          stringsAsFactors = FALSE)
# colnames(content_source) <- tolower(colnames(content_source))


# midterm_source <- read.table(paste0(here::here(),
#                                     "\\source_files\\midterms.txt"),
#                              header = TRUE,
#                              stringsAsFactors = FALSE)
# colnames(midterm_source) <- tolower(colnames(midterm_source))












# step 2 - specify content
## content_source = text file of category-member pairs
## number_of_categories = the number of categories from the list to use
## number_of_members= the number of members from each category to use
## random_categories = whether the categories are picked randomly per
  ## participant or if they are fixed as the same for all participants
## random_members = selecting members from selected categories randomly, or
  ## fixed for all participants




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
# model_list <- create_models(simple = FALSE,
#                             complex = TRUE,
#                             number_of_items)


# step 5 - initialize the output data frame per person
# create an output template
output_frame <- generate_outframe(template)








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





## HOW TO ADD FILES TO PACKAGE

content_pairs <- content_source  # saving to another name
nonsense_words <- midterm_source

usethis::use_data(content_pairs, nonsense_words,
                  internal = TRUE, overwrite = TRUE)








# problem fixing            ####
# ============================ #

# # random order of categories
# categories <- sample(unique(content_pairs$cat))
# categories <- c(rep(categories, 2))

groups <- content_pairs %>% group_split(cat)  # no need to sort then

group_length <- nrow(groups[[1]])

selected_content <- data.frame(matrix(nrow=0, ncol=2)) # edit colnum
colnames(selected_content) <- c(colnames(content_pairs))
#selected_content$nonsense <- 0

# IF GROUPS ARE EVEN - do first, then fix for odd

if (group_length %% 2 == 0) {
  group_order <- sample(1:length(groups))
  for (i in group_order) {
    selected_content <- rbind(selected_content,
                              sample_n(groups[[i]],
                                       (group_length / 2)
                              )
    )
  }
} else if (group_length %% 2 == 1) {
  group_order <- sample(1:length(groups))
  even_order <- sample(length(groups), (length(groups)/2))
  odd_order <- setdiff(group_order, even_order)
  for (i in even_order) {
    selected_content <- rbind(selected_content,
                              sample_n(groups[[i]],
                                       1)
                              )
  }
  for (j in odd_order) {
    selected_content <- rbind(selected_content,
                              sample_n(groups[[j]],
                                       2)
    )
  }
}

unselected_content <- content_pairs %>%
  filter(!(mem %in% selected_content$mem))


categories <- content_pairs$cat[1:nrow(unselected_content)]
test_sort <- data.frame(categories, stringsAsFactors = FALSE)
test_sort$order <- 1:nrow(test_sort)
test_sort <- test_sort[order(test_sort$cat), ]
unselected_content <- unselected_content[order(unselected_content$cat), ]

test_sort <- cbind(test_sort, unselected_content)

test_sort <- test_sort[order(test_sort$order), ]

nonsense_content <- create_nonsense(test_sort) %>%
  select(cat, mem)


selected_content$nonsense <- 0
nonsense_content$nonsense <- 1


total_content <- rbind(selected_content, nonsense_content)

total_content <- total_content[order(total_content$cat), ]






# testing
#total_content <- total_content[order(total_content$cat), ]

#selected_content <- selected_content[order(selected_content$cat), ]
#
content_pairs <- content_pairs[order(content_pairs$cat),]

#
#
# # unselected_content <-
# #   unselected_content[order(match(categories,
# #                                  unselected_content$cat)),]
# # IF I CAN SORT NONSENSE BY CATEGORIES, IT SHOULD WORK
#
# nonsense_content <- create_nonsense(unselected_content)
# nonsense_content$nonsense <- 1
# selected_content$nonsense <- 0
#
# combined_test <- rbind(selected_content, nonsense_content)
# combined_test <- combined_test[order(combined_test$cat), ]
#
#
# nonsense_test <- c()
# unused_members <- unselected_content
# unused_groups <- unselected_content %>%
#   group_split(cat)
# unused_order <- sample(1:length(unused_groups))
#
# # need to make sure sample_n isn't matching groups
# # THIS DOESNT WORK PROPERLY
# for (j in unused_order) {
#
#   current_rows <- sample_n(unused_members, nrow(unused_groups[[j]]))
#   current_rows
#
#   while (length(unique(current_rows$cat)) == 1
#          | unused_groups[[j]]$cat[1] %in% unique(current_rows$cat)
#   ) {
#     print("resampling")
#     current_rows <- sample_n(unused_members, nrow(unused_groups[[j]]))
#
#   }
#   #
#   #     if (unused_groups[[1]]$cat[1] %in% unique(current_rows$cat)) {
#   #       print("shit")
#   #     }
#
#   nonsense_test <- rbind(nonsense_test, current_rows)
#   # unused_members <- unused_members %>%
#   #   filter(!current_rows)
#   unused_members <- setdiff(unused_members, current_rows)
# }
#
# #nonsense_test <- nonsense_test[order(nonsense_test$cat),]
#
#
# unselected_content$test <- nonsense_test$mem
#
# sorted_content <- unselected_content[order(unselected_content$cat),]
# sorted_content$mem <- NULL
#


#test_pairs <- content_pairs[order(content_pairs$cat),]
#test_pairs$nonsense <- rep(c(0,1), nrow(test_pairs)/2)









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







# code to make presentation

t <- content_source %>%
  filter(cat == "dogs" | cat == "criminals"
         | cat == "vegetables" | cat == "weapons") %>%
  select(c(cat, mem1, mem2, mem3))

to <- create_pairs(t, 4, 3)

t2 <- create_nonsense(to)

t3 <- select_pairs(to, t2, midterm_source)





data.table::fwrite(to, "step4.1.csv")
data.table::fwrite(t2, "step4.2.csv")
data.table::fwrite(content, "step4.3.csv")
data.table::fwrite(template, "step7.csv")



# add files to package      ####
# ============================ #
