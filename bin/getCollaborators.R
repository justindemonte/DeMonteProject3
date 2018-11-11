library(tidyverse)
library(stringr)
library(readr)

args = commandArgs(trailingOnly = TRUE)

abstract <- read_file(args[1])

keyWordRegex <- '(University|Hospital|School|Institute|Center)'

SplitAbstract <- as.list(str_split(abstract, pattern = ",")[[1]])

CollaboratorsFromAbstract <- SplitAbstract[grepl(keyWordRegex, SplitAbstract)]

Collaborators <- as.data.frame(unlist(CollaboratorsFromAbstract))

fileConn = file("out.csv")
write_csv(Collaborators, fileConn)
close(fileConn)
