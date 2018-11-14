library(tidyverse)
library(readr)
library(shiny)

# Define UI for application that draws a histogram

inputFiles <- list()

hope <- read_csv("words2.csv")
hope

for (i in 1:10) {
  inputFiles <- append(inputFiles, read_csv(paste("words", i, ".csv", sep="")))
}


TopTenCollaborators <- read_csv("wordsKey.csv")

choice <- TopTenCollaborators[[1]][1]

try <- paste("temp",match(choice,TopTenCollaborators[[1]]), sep="")
try
# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).

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
      helpText("Top Ten Institutions Collaborating with UNC")
    ),
    
    # Create a spot for the barplot
    mainPanel(
      plotOutput("wordPlot")  
    )
    
  )
)



# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(datasets)

# Define a server for the Shiny app
server <- function(input, output) {
  
  # Fill in the spot we created for a plot
  output$wordPlot <- renderPlot({
      read_csv(paste("words", 
          match(input$region,TopTenCollaborators[[1]]), ".csv", sep="")) %>%
      arrange(count) %>%
      ggplot(aes(x=words, y=count)) +
      geom_bar(stat = "identity")
    # Render a barplot
    #  barplot(inputFiles[,input$region]*1000, 
    #        main=input$region,
    #        ylab="Number of Telephones",
    
    #        xlab="Year")
  })
}


# Run the application 
shinyApp(ui = ui, server = server)

