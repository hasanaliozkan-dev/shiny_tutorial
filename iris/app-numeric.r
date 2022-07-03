
library(shiny)
library(data.table)
library(randomForest)

model <- readRDS("model.rds")
ui <- pageWithSidebar(

  headerPanel('Iris Predictor'),
  sidebarPanel(
    tags$label(h3('Input parameters')),
    numericInput("Sepal.Length", 
                 label = "Sepal Length", 
                 value = 5.1),
    numericInput("Sepal.Width", 
                 label = "Sepal Width", 
                 value = 3.6),
    numericInput("Petal.Length", 
                 label = "Petal Length", 
                 value = 1.4),
    numericInput("Petal.Width", 
                 label = "Petal Width", 
                 value = 0.2),
    actionButton("submitbutton", "Submit", 
                 class = "btn btn-primary")
  ),
  mainPanel(
    tags$label(h3('Status/Output')), 
    verbatimTextOutput('contents'),
    tableOutput('tabledata') 
  )
)


server <- function(input, output, session) {
  datasetInput <- reactive({
    df <- data.frame(
      Name = c("Sepal Length",
               "Sepal Width",
               "Petal Length",
               "Petal Width"),
      Value = as.character(c(input$Sepal.Length,
                             input$Sepal.Width,
                             input$Petal.Length,
                             input$Petal.Width)),
      stringsAsFactors = FALSE)
    Species <- 0
    df <- rbind(df, Species)
    input <- transpose(df)

    write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)
    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    Output <- data.frame(Prediction=predict(model,test), round(predict(model,test,type="prob"), 3))
    print(Output)
  })

  output$contents <- renderPrint({
    if (input$submitbutton>0) {
      isolate("Calculation complete.")
    } else {
      return("Server is ready for calculation.")
    }
  })
  output$tabledata <- renderTable({
    if (input$submitbutton>0) {
      isolate(datasetInput())
    }
  })
}

shinyApp(ui = ui, server = server)