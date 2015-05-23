library(shiny)
library(shinythemes)
 
 
shinyUI(fluidPage(theme = shinytheme("united"),
  headerPanel("",tags$head(
  tags$img(src="logotipo.png", height="50px", align = "right")
  )),
 
  titlePanel("Statistical Influence of Variables in Staff Rotation Analysis - Liliana Pacheco"),
  navbarPage("Contents",
             tabPanel("Instructions",
                      sidebarLayout(
                        sidebarPanel(
                          
                          helpText("The purpose of this application is to show from a series of demographic variables,",
                                   "which of them may have a statistical influence on the event of Retiring or Not",
                                   "retiring from a specific company.")
                          
                        ),       
                        mainPanel(      
                          p("Here we have the general instructions for this web application:"),
                          tags$ol(
                          tags$li(strong("Data:"),"This panel shows you the dataset and its variables."), 
                          tags$li(strong("Bivariate - Descriptives:"), "This panel shows the Stacked bar graph of a demographic variable for you to choose and the percentage 
                                  of employees who have retired from the company.", br("Also, you will see a table showing
                                  the frequencies, row and column percentages. And finally the results of a Chi-square Test.")), 
                          tags$li(strong("Model:"), "This panel shows the logistic model results of the variables you choose and Retirement.")
                        )
                        )
                      )
             ),
             tabPanel("Data",
               sidebarLayout(
                 sidebarPanel(
                   
                   #Si se desea que cargue el archivo manualmente
#                    fileInput('file1', 'Seleccionar Archivo',
#                            accept=c('text/csv', 
#                           'text/comma-separated-values,text/plain', 
#                           '.csv')),
 
                   p("We use the dataset that contains the results of a  
                      survey made with a group of employees from a
                     company during December. Here we have:",
                     strong("Demographic variables,"),strong("Performance variables"), "and", strong("Income.")),
                   numericInput("num", label = h4("How many rows do you want to see first?"), value = 10)
                                      ,width=3.5),
                      
                 mainPanel(
                   
                   dataTableOutput('data_table')
                          )
                            )
                   ),
             tabPanel("Bivariate - Descriptives",
                      sidebarLayout(
                        sidebarPanel(
                          
                          radioButtons("socio", "Demographics:",
                              c("Gender" = "Gender",
                              #"Programa" = "Programa",
                              "City" = "City",
                              "Were you studing when you began working?" = "Studing.when.started",
                              "Are you currently studing?" = "Currently.studing",
                              "Level of Education" = "Level.of.education",
                              "Condition of studies" = "State.of.studies",
                              "Area of studies" = "Area.of.studies",
                              "Are you the head of your household?" = "Head.of.household",
                              "Part of your income is for your household?" = "Part.of.your.income.is.for.household",
                              "Do you have children?" = "Has.Children",
                              "Are you satisfied working in this company?" = "Satisfaction"
                              )),
#                          							Retirement	Days of work	Months of work	Performance	Mean Performance	Fixed Income	Variable Income
                          
                          br(),
                          selectInput("select", label = h4("Choose the X axis orientation"), 
                          choices = list("Horizontal" = 1, "Vertical" = 2), 
                          selected = 1)
                        ,width=3), 
                      mainPanel(      
                      plotOutput("apilado"),
                      tableOutput('tabla'),
                      verbatimTextOutput("chicuad")
                      
                      )
                      )
             ),
tabPanel("Model",
         sidebarLayout(
           sidebarPanel(
           						
             
             radioButtons("regresora", "Choose a variable for the logistic model:",
                          c("Age" = "Age",
                            "Days working" = "Days.of.work",
                            "Months working" = "Months.of.work",
                            "Mean Performance" = "Mean.Performance",
                            "Fixed Income" = "Fixed.Income",
                            "Variable Income" = "Variable.Income",
                            "Mean Adhesion" = "Mean.Adhesion",
                            "Mean Ratio Connections/Shift" = "Mean.Ratio.Connections.Shift",
                            "Mean AHT" = "Mean.AHT"))
 
                  
             
             
           ),       
           mainPanel(      
           plotOutput("graficoModelo"),
           #verbatimTextOutput("graficoModelo"),
           verbatimTextOutput("modelo")
             
           )
         )
)
 
)
)
)
