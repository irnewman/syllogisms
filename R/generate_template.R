
generate_template <- function(number_of_items, instruction_list, model_list){
  
  template_columns <- c("Weight", "Nested", "Procedure", "COMPLEXITY", 
                        "INSTRUCTION", "PREM1", "PREM2", "CONC", 
                        "VBOPTION", "IUOPTION", "SYLLNR")
  outframe <- data.frame(matrix(ncol = length(template_columns),
                                nrow = number_of_items))
  colnames(outframe) <- template_columns
  
  outframe$Weight <- rep(1,number_of_items)
  outframe$Nested <- rep("",number_of_items)
  outframe$Procedure <- rep("TrialProc", number_of_items)
  outframe$COMPLEXITY <- model_list
  outframe$INSTRUCTION <- instruction_list
  outframe$SYLLNR <- 1:number_of_items
  outframe$VBOPTION[outframe$INSTRUCTION == "BELIEF"] <- "Believable"
  outframe$IUOPTION[outframe$INSTRUCTION == "BELIEF"] <- "Unbelievable"
  outframe$VBOPTION[outframe$INSTRUCTION == "LOGIC"] <- "Valid"
  outframe$IUOPTION[outframe$INSTRUCTION == "LOGIC"] <- "Invalid"
  # unsure about below two options
  outframe$VBOPTION[outframe$INSTRUCTION == "LIKING"] <- "Like"
  outframe$IUOPTION[outframe$INSTRUCTION == "LIKING"] <- "Dislike"
  
  return(outframe)
}