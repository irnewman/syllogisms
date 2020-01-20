
create_nonsense <- function(content_pairs) 
{
  # nonsense data frame
  nonsense <- content_pairs
  
  number_of_items <- length(nonsense$cat)
  number_of_categories <- length(unique(nonsense$cat))
  category_length <- number_of_items / number_of_categories
  number_of_sections <- number_of_items / number_of_categories
  
  for (i in 1:number_of_sections) {
    indices <- c( 
      (1 + ((i-1) * number_of_categories)):
         (number_of_categories + ((i-1) * number_of_categories))
                  )
    
    old_members <- nonsense$mem[indices]
    new_members <- c(old_members[-1:-i], old_members[1:i])

    #print(old_members)
    #print(new_members)
    
    nonsense$mem[indices] <- new_members  
    
    # print(indices)
    # print(x)
    # print(y)
    # print("next")
  }
  
  return(nonsense)
}
  
  # split the member list into equal parts, of category length
    # number of sections = number of items / number of categories
    # for i from 1 to number of sections
    # (1 to number of categories) + ((i-1) * number of categories)
      # counter 1 = 1 to 16 + (16 * 0 = 0)    = 1:16
      # counter 2 = 1 to 16 + (16 * 1 = 16)   = 17:32
      # counter 3 = 1 to 16 + (16 * 2 = 32)   = 33:48
      # counter 4 = 1 to 16 + (16 * 3 = 48)   = 49:64
  # take those indices and save to another vector offset by i length
      # offset by 1
      # offset by 2
      # offset by 3
      # offset by 4

  
  # # shuffle pairs into nonsense
  # for(i in 1:number_of_items){
  #   if (i %% (number_of_items/4) == 0){
  #     counter <- counter + 1
  #   }
  #   if(i != number_of_items) {
  #     nonsense$mem[i+1] = content_pairs$mem[i]
  #   }
  #   if(i == number_of_items) {
  #     nonsense$mem[1] = content_pairs$mem[number_of_items]
  #   }
  # }
  # 
  # sorted_nonsense <- nonsense[order(nonsense$cat),]
  # 


# x <- content_pairs$mem[1:16]
# y <- c(x[-1:-1], x[1:1])
# y2 <- c(x[-1:-2], x[1:2])
# 
# 
# 
# for (i in 1:number_of_items){
#   print(i %% (number_of_items/4))
# }