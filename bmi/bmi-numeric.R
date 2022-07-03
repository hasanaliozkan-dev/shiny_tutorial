library(shiny)
library(shinythemes)


ui <- fluidPage(theme = shinytheme("united"),
                navbarPage("BMI Calculator:",
                           
                           tabPanel("Home",
                  
                                    sidebarPanel(
                                      HTML("<h3>Input parameters</h3>"),
                                      numericInput("height", 
                                                  label = "Height", 
                                                  value = 175),
                                      numericInput("weight", 
                                                  label = "Weight", 
                                                  value = 70 
                                                  ),
                                      
                                      actionButton("submitbutton", 
                                                   "Submit", 
                                                   class = "btn btn-primary")
                                    ),
                                    
                                    mainPanel(
                                      tags$label(h3('Status/Output')),
                                      verbatimTextOutput('contents'),
                                      tableOutput('tabledata')
                                    ) 
                                    
                           ),
                           tabPanel("About", 
                                    titlePanel("About"), 
                                    div(includeMarkdown("bmi/about.md"), 
                                        align="justify")
                           ) 
                           
                )
) 



server <- function(input, output, session) {
  

  datasetInput <- reactive({  
    
    bmi <- input$weight/( (input$height/100) * (input$height/100) )
    bmi <- data.frame(bmi)
    names(bmi) <- "BMI"
    print(bmi)
    
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
