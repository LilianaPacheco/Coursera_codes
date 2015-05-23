library(shiny)
source("grafico.R")
source("tablas.R")
source("chicuadrado.R")
source("modelo.R")
source("grafico_logistico.R")
library(shinythemes)
datos = read.csv2("Base inicial.csv",header=T,sep=";",enc="latin1")
 
 
# Define server logic for random distribution application
shinyServer(function(input, output) {
  output$contents <- renderDataTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath, header=T, sep=";")
    
  })  
  
  output$data_table<-renderDataTable({
    
    #    inFile <- input$file1
    filas<-input$num
    #    if (is.null(inFile))
    #      return(NULL)
    #    mydat<-read.csv(inFile$datapath, header=T, sep=";")
    mydat<-datos
    head(mydat,filas)
  })
  
  
  # Reactive expression to generate the requested distribution.
  # This is called whenever the inputs change. The output
  # functions defined below then all use the value computed from
  # this expression
  data <- reactive({
    variable <- switch(input$variable,
                       norm = rnorm,
                       unif = runif,
                       lnorm = rlnorm,
                       exp = rexp,
                       rnorm
    )
    
    variable(input$n) #recordemos que cada rdist(necesita tamaño)
  })
  
  # Generate a plot of the data. Also uses the inputs to build
  # the plot label. Note that the dependencies on both the inputs
  # and the data reactive expression are both tracked, and
  # all expressions are called in the sequence implied by the
  # dependency graph
  output$plot <- renderPlot({
    variable <- input$variable
    n <- input$n
    
    hist(data(), 
         main=paste('r', variable, '(', n, ')', sep=''))
  })
  
  # Generate a summary of the data
  output$summary <- renderPrint({
    summary(data())
  })
  
  
  #
  selectedData <- reactive({
    inFile <- input$file1
    #mydat<-read.csv(inFile$datapath, header=T, sep=";")
    mydat<-datos
    mydat[,input$socio]
  })
  
  #Salidas tabulares de la función
  output$tabla <- renderTable({
    
    #inFile <- input$file1
    mydat<-datos
    sentido<-input$select
    var2<-"Retirement"
    #mydat<-read.csv(inFile$datapath, header=T, sep=";")
    tablas(mydat,input$socio,var2, sentido)
    
  }) 
  
  #Generar los gráficos apilados
  output$apilado <- renderPlot({
    
    #inFile <- input$file1
    sentido<-input$select
    #mydat<-read.csv(inFile$datapath, header=T, sep=";")
    mydat<-datos
    #grafico(selectedData(),mydat$Retirado, sentido)
    var2<-"Retirement"
    #mydat<-read.csv(inFile$datapath, header=T, sep=";")
    grafico(mydat,input$socio,var2, sentido)
  }) 
  #Generar tabla chicuadrado
  output$chicuad <- renderPrint({
    
    sentido<-input$select
    mydat<-datos
    var2<-"Retirement"
    chic(mydat,input$socio,var2, sentido)
  }) 
  #Generar modelo logóstico
  output$modelo <- renderPrint({
    
    mydat<-datos
    var2<-"Retirement"
    modelo(mydat,input$regresora,var2)
  })   
  
  #Generar grafico logóstico
  output$graficoModelo <- renderPlot({
    
    mydat<-datos
    var2<-"Retirement"
    grafico.logistico(mydat,input$regresora,var2)
  })
})
