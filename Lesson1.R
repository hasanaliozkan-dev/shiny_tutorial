library(shiny)
library(shinythemes)


ui <- fluidPage(theme = shinytheme("united"),
                navbarPage(
                  "My First App",
                  tabPanel("Navbar 1",
                           sidebarPanel(
                             tags$h3("Input:"),
                             textInput("txt1","Given Name: ",""),
                             textInput("txt2","Surname: ",""),
                             ),#sidebarPanel
                           mainPanel(
                             h1("Header 1"),
                             h4("Output 1"),
                             verbatimTextOutput("txtout")
                           )#mainPanel
                           ),#navbarPage
                  tabPanel("Navbar 2","Hasan Ali ÖZKAN2"),#tabPanel
                  tabPanel("Navbar 3","Hasan Ali ÖZKAN3")#tabPanel
                  ),
                )#fluidPage



server <- function(input, output){
  output$txtout <- renderText({
    paste(input$txt1,input$txt2,sep = " *** ")
  })
}

shinyApp(ui, server)

