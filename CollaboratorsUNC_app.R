library(tidyverse)
library(readr)
library(shiny)

# Define UI for application that draws a histogram

inputFiles <- list()


for (i in 1:10) {
  inputFiles <- append(inputFiles, read_csv(paste("words", i, ".csv", sep="")))
}


TopTenCollaborators <- read_csv("wordsKey.csv")


# Use a fluid Bootstrap layout
ui <- fluidPage(    
  
  # Give the page a title
  titlePanel("Top UNC Collaborators and Subjects"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    
    # Define the sidebar with one input
    sidebarPanel(
      selectInput("region", "Collaborator:", 
                  choices=TopTenCollaborators),
      hr(),
      helpText("Top Ten Institutions Collaborating with UNC"),
      p("Which institutions does The University of North Carolina at Chapel Hill collaborate with most frequently?  What are the likely subject emphases of these collaborations?  To answer this question, I started with the pubmed abstracts provided by Dr. Biggs.  I searched each abstract for institutions names (e.g. phrases containing the keywords university, hospital, etc.) then collected the top ten collaborators.  For each collaborator, I found the most frequently used words in abstracts involving that collaborator.  The results can be explored in this interactive application.  Select one of the top-ten-UNC collaborating institutions from the drop-down menu to explore the likely subject matter of those collaborations.")),
    
    
    # Create a spot for the barplot
    mainPanel(
      
      plotOutput("wordPlot")  
    )
    
  )
)


library(datasets)

# Define a server for the Shiny app
server <- function(input, output) {
  
  # Fill in the spot we created for a plot
  output$wordPlot <- renderPlot({
      read_csv(paste("words", 
          match(input$region,TopTenCollaborators[[1]]), ".csv", sep="")) %>%
      mutate(words=fct_reorder(words, count)) %>%
      ggplot(aes(x=words, y=count)) +
      geom_bar(stat = "identity") +
      labs(x = "Subject Terms", y="Frequency") +
      coord_flip() 
    
  })
}


# Run the application 
shinyApp(ui = ui, server = server)

