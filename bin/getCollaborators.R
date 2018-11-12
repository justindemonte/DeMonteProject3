library(tidyverse)
library(stringr)
library(readr)

args = commandArgs(trailingOnly = TRUE)

infile <- read_lines(args[1])

index <- match(1, str_detect(pattern = "Author information", infile))

# these variables hold the author info from the file and the "abstract proper" from the file, respectively

authorInfo <- infile[index]

abstract <- infile[index+1]

# Gets the Collaborators 

keyWordRegex <- '(University|Hospital|School|Institute|Center)'

SplitAuthorInfo <- as.list(str_split(authorInfo, pattern = ",")[[1]])

CollaboratorsFromAbstract <- SplitAuthorInfo[grepl(keyWordRegex, SplitAuthorInfo)]

Collaborators <- unlist(CollaboratorsFromAbstract)

Collaborators <- unique(Collaborators)

# Creates tibble and output csv

abstractVector <- rep(abstract,length(Collaborators))

output <- tibble(abstrct = abstractVector, Collab = Collaborators)

write_csv(output, "out.csv")

