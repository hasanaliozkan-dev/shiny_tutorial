library(shiny)
library(shinythemes)


ui <- fluidPage(theme = shinytheme("yeti"),
                navbarPage(
                  theme = shinytheme("cerulean"),
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
                             verbatimTextOutput("txtout") #txtout
                           )#mainPanel
                           ),#navbarPage
                  tabPanel("Navbar 2","Hasan Ali ÖZKAN2"),#tabPanel
                  tabPanel("Navbar 3","Hasan Ali ÖZKAN3")#tabPanel
                  ),
                )#fluidPage





shinyApp(ui, server)
 

