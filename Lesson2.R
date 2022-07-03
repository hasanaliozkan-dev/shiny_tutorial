library(shiny)
data(airquality)

ui  <- fluidPage(
    titlePanel("Ozone Level!"),
    sidebarLayout(
        sidebarPanel(
            sliderInput(inputId = "bins",
                        label = "Number of Bins",
                        min=1,
                        max = 50,
                        value=30)

        ),
        mainPanel(
            plotOutput(outputId = "distplot")
        ),
    )
)

server  <- function(input,output){
    output$distplot  <- renderPlot({

        x  <-  airquality$Ozone
        x <- na.omit(x)
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        hist(x, breaks = bins,col = "#75AADB", border = "black",
         xlab = "Ozone level",
         main = "Histogram of Ozone level")
    }
    )
}
shinyApp(ui = ui, server = server)
