
#' Generate an E-prime output data frame.
#'
#' @param template A finished template from fill_template.
#'
#' @return A data frame in E-prime input file format.

generate_outframe <- function(template){

  # initialize the output frame
  number_of_items <- nrow(template)
  template_columns <- c("Weight", "Nested", "Procedure", "COMPLEXITY",
                        "INSTRUCTION", "PREM1", "PREM2", "CONC",
                        "VBOPTION", "IUOPTION", "SYLLNR")
  outframe <- data.frame(matrix(ncol = length(template_columns),
                                nrow = number_of_items))
  colnames(outframe) <- template_columns

  # compute variables for the output frame
  outframe$Weight <- rep(1,number_of_items)
  outframe$Nested <- rep("",number_of_items)
  outframe$Procedure <- rep("TrialProc", number_of_items)

  outframe$COMPLEXITY <- toupper(template$complexity)
  outframe$INSTRUCTION <- toupper(template$instructions)
  outframe$SYLLNR <- 1:number_of_items
  outframe$VBOPTION[outframe$INSTRUCTION == "BELIEF"] <- "Believable"
  outframe$IUOPTION[outframe$INSTRUCTION == "BELIEF"] <- "Unbelievable"
  outframe$VBOPTION[outframe$INSTRUCTION == "LOGIC"] <- "Valid"
  outframe$IUOPTION[outframe$INSTRUCTION == "LOGIC"] <- "Invalid"

  # unsure about below two options
  outframe$VBOPTION[outframe$INSTRUCTION == "LIKING"] <- "Like"
  outframe$IUOPTION[outframe$INSTRUCTION == "LIKING"] <- "Dislike"

  outframe$PREM1 <- template$p1
  outframe$PREM2 <- template$p2
  outframe$CONC <- template$c

  outframe$BELIEF <- toupper(template$believability)
  outframe$VAL <- template$validity
  outframe$VALIDITY <- toupper(ifelse(
    outframe$VAL == "N", "valid", "invalid"))
  outframe$ATMOSPHERE <- template$type
  outframe$FIGURE <- template$figure

  return(outframe)
}
