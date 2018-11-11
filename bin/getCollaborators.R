library(tidyverse)
library(stringr)
library(readr)

args = commandArgs(trailingOnly = TRUE)


abstract <- read_file(args[1])
abstract <- str_replace_all(abstract, "[\r\n]" , "")


keyWordRegex <- '(University|Hospital|School|Institute|Center)'

SplitAbstractCommas <- as.list(str_split(abstract, pattern = ",")[[1]])

CollaboratorsFromAbstract <- SplitAbstractCommas[grepl(keyWordRegex, SplitAbstractCommas)]

Collaborators <- unlist(CollaboratorsFromAbstract)

Collaborators <- unique(Collaborators)

abstractVector <- list2 <- rep(abstract,length(Collaborators))

output <- tibble(abstract = abstractVector, Collab = Collaborators)

write_csv(output, "out.csv")

