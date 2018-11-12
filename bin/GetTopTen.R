library(tidyverse)
library(readr)
library(stringr)

args <- commandArgs(trailingOnly = TRUE)

CollaboratorsTbl <- read_csv(args[1])

# Remove entries where column headings appear in merged csv file

CollaboratorsTbl <- CollaboratorsTbl %>%
  filter(Collab != "Collab")

# Count and sort by collaborators

CollaboratorsSorted <- CollaboratorsTbl %>%
  group_by(Collab) %>%
  count() %>%
  arrange(desc(n))

# Get vector of Top collaborator names

TopTenNames <- CollaboratorsSorted$Collab[9:25]

TopTenNames <- TopTenNames[c(-2,-5,-6,-7,-9,-14,-17)]

# Create a subset of the original tibble for only the "#1" collaborator

test1 <- 
  1:10 %>%
  lapply(function(x) {
    y = CollaboratorsTbl %>%
      filter(Collab==TopTenNames[[x]]) %>%
      {paste(unique(.$abstrct), sep="", collapse = " ")} %>%
       str_split(pattern = " ") %>%
       table() %>%
      {as.tibble(cbind.data.frame(words = names(.), count = as.integer(.)))} 
      
  })

test1 <- lapply(test1, . %>% arrange(desc(count)))

# remove irrelevant words

FilterStopWords <- c("H", "CI,", "In", "This","3","The","We","=", "95%","a", "able", "about", "across", "after", "all", "almost", "also", "am", "among", "an", "and", "any", "are", "as", "at", "be", "because", "been", "but", "by", "can", "cannot", "could", "dear", "did", "do", "does", "either", "else", "ever", "every", "for", "from", "get", "got", "had", "has", "have", "he", "her", "hers", "him", "his", "how", "however", "i", "if", "in", "into", "is", "it", "its", "just", "least", "let", "like", "likely", "may", "me", "might", "most", "must", "my", "neither", "no", "nor", "not", "of", "off", "often", "on", "only", "or", "other", "our", "own", "rather", "said", "say", "says", "she", "should", "since", "so", "some", "than", "that", "the", "their", "them", "then", "there", "these", "they", "this", "tis", "to", "too", "us", "wants", "was", "we", "were", "what", "when", "where", "which", "while", "who", "whom", "why", "will", "with", "would", "yet", "you", "your")

test1 <- lapply(test1, . %>% filter(!words %in% FilterStopWords))

test1 <- lapply(test1, . %>% top_n(10))


write_csv(as.data.frame(TopTenNames), "wordsKey.csv")
write_csv(test1[[1]], paste("words", 1, "Key.csv", sep=""))

for (i in 1:10) {
  write_csv(test1[[i]], paste("words", i, ".csv", sep=""))
}





