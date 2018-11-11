library(tidyverse)
library(stringr)
library(readr)

args = commandArgs(trailingOnly = TRUE)

abstract <- read_file(args[1])

keyWordRegex <- '(University|Hospital|School|Institute|Center)'

SplitAbstract <- as.list(str_split(abstract, pattern = ",")[[1]])

CollaboratorsFromAbstract <- SplitAbstract[grepl(keyWordRegex, SplitAbstract)]

Collaborators <- unlist(CollaboratorsFromAbstract)

output <- c(abstract,Collaborators)

fileConn = file("out.csv")
writeLines(output, fileConn,sep="; ;")
close(fileConn)
