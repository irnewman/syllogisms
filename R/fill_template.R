### quantifier
# A = All are
# E = No are
# I = Some are
# O = Some are not

# figure 1 = AB-BC
# figure 2 = BA-CB
# figure 3 = AB-CB
# figure 4 = BA-BC

fill_template <- function(template_file, content)
{
  A <- "All "
  E <- "No "
  I <- "Some "
  O <- c("Some ", "not ")

  f1 <- c("A ", "B.", "B ", "C.")
  f2 <- c("B ", "A.", "C ", "B.")
  f3 <- c("A ", "B.", "C ", "B.")
  f4 <- c("B ", "A.", "B ", "C.")

  ac <- c("A ", "C.")
  ca <- c("C ", "A.")

  are <- "are "


  template <- template_file %>%
    mutate(
      p1_template = case_when(
        (figure==1 & premise1 == 'A') ~ paste0(A, f1[1], are, f1[2]),
        (figure==1 & premise1 == 'E') ~ paste0(E, f1[1], are, f1[2]),
        (figure==1 & premise1 == 'I') ~ paste0(I, f1[1], are, f1[2]),
        (figure==1 & premise1 == 'O') ~ paste0(O[1], f1[1], are, O[2], f1[2]),

        (figure==2 & premise1 == 'A') ~ paste0(A, f2[1], are, f2[2]),
        (figure==2 & premise1 == 'E') ~ paste0(E, f2[1], are, f2[2]),
        (figure==2 & premise1 == 'I') ~ paste0(I, f2[1], are, f2[2]),
        (figure==2 & premise1 == 'O') ~ paste0(O[1], f2[1], are, O[2], f2[2]),

        (figure==3 & premise1 == 'A') ~ paste0(A, f3[1], are, f3[2]),
        (figure==3 & premise1 == 'E') ~ paste0(E, f3[1], are, f3[2]),
        (figure==3 & premise1 == 'I') ~ paste0(I, f3[1], are, f3[2]),
        (figure==3 & premise1 == 'O') ~ paste0(O[1], f3[1], are, O[2], f3[2]),

        (figure==4 & premise1 == 'A') ~ paste0(A, f4[1], are, f4[2]),
        (figure==4 & premise1 == 'E') ~ paste0(E, f4[1], are, f4[2]),
        (figure==4 & premise1 == 'I') ~ paste0(I, f4[1], are, f4[2]),
        (figure==4 & premise1 == 'O') ~ paste0(O[1], f4[1], are, O[2], f4[2])),

      p2_template = case_when(
        (figure==1 & premise2 == 'A') ~ paste0(A, f1[3], are, f1[4]),
        (figure==1 & premise2 == 'E') ~ paste0(E, f1[3], are, f1[4]),
        (figure==1 & premise2 == 'I') ~ paste0(I, f1[3], are, f1[4]),
        (figure==1 & premise2 == 'O') ~ paste0(O[1], f1[3], are, O[2], f1[4]),

        (figure==2 & premise2 == 'A') ~ paste0(A, f2[3], are, f2[4]),
        (figure==2 & premise2 == 'E') ~ paste0(E, f2[3], are, f2[4]),
        (figure==2 & premise2 == 'I') ~ paste0(I, f2[3], are, f2[4]),
        (figure==2 & premise2 == 'O') ~ paste0(O[1], f2[3], are, O[2], f2[4]),

        (figure==3 & premise2 == 'A') ~ paste0(A, f3[3], are, f3[4]),
        (figure==3 & premise2 == 'E') ~ paste0(E, f3[3], are, f3[4]),
        (figure==3 & premise2 == 'I') ~ paste0(I, f3[3], are, f3[4]),
        (figure==3 & premise2 == 'O') ~ paste0(O[1], f3[3], are, O[2], f3[4]),

        (figure==4 & premise2 == 'A') ~ paste0(A, f4[3], are, f4[4]),
        (figure==4 & premise2 == 'E') ~ paste0(E, f4[3], are, f4[4]),
        (figure==4 & premise2 == 'I') ~ paste0(I, f4[3], are, f4[4]),
        (figure==4 & premise2 == 'O') ~ paste0(O[1], f4[3], are, O[2], f4[4])),

      c_template = case_when(
        (conc_format=="A-C" & conclusion == 'A') ~ paste0(A, ac[1],
                                                          are, ac[2]),
        (conc_format=="A-C" & conclusion == 'E') ~ paste0(E, ac[1],
                                                          are, ac[2]),
        (conc_format=="A-C" & conclusion == 'I') ~ paste0(I, ac[1],
                                                          are, ac[2]),
        (conc_format=="A-C" & conclusion == 'O') ~ paste0(O[1], ac[1],
                                                        are, O[2], ac[2]),

        (conc_format=="C-A" & conclusion == 'A') ~ paste0(A, ca[1],
                                                          are, ca[2]),
        (conc_format=="C-A" & conclusion == 'E') ~ paste0(E, ca[1],
                                                          are, ca[2]),
        (conc_format=="C-A" & conclusion == 'I') ~ paste0(I, ca[1],
                                                          are, ca[2]),
        (conc_format=="C-A" & conclusion == 'O') ~ paste0(O[1], ca[1],
                                                          are, O[2], ca[2]))

    )


  filled_template <- fill_content(template, content)

  return(filled_template)
}
