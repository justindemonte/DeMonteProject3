library(tidyverse)
library(stringr)
library(readr)

args = commandArgs(trailingOnly = TRUE)

c2 = read_delim(args[1])

keyWordRegex <- '(University|Hospital|School|Institute|Center)'

SplitAbstract <- as.list(str_split(abstract, pattern = ",")[[1]])

CollaboratorsFromAbstract <- SplitAbstract[grepl(keyWordRegex, SplitAbstract)]

fileConn = file("out.csv")
writeLines(CollaboratorsFromAbstract, fileConn)
close(fileConn)