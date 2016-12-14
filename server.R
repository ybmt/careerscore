library(shinyBS)
library(shiny)
library(plotly)

D <- read.csv(file="Skills_By_Title_DEN_tester.csv", header=TRUE, sep=",")
N <- read.csv(file="Skills_By_Title_NUM_tester.csv", header=TRUE, sep=",")
rownames(D) <- D$Title
clickedTitle = ''

MyData <- read.csv(file="Titles_By_Skill.csv", header=TRUE, sep=",")
print(MyData)


shinyServer(function(input, output, session) {
  
  output$titleSelectBox <- renderUI(
    selectInput("title",  h3("Select a Title"), rownames(D), selected = ".NET Developer", width='400px')
  )
  
  observe({
    event.data <- event_data("plotly_click", source = "titleBarChart")
    if(is.null(event.data)==F){
      clickedTitle <- as.character(event.data['y'])
      updateSelectInput(session, "title", selected=clickedTitle)
    }
  })
  
  observe({
    event.data <- event_data("plotly_click", source = "skillBarChart")
    if(is.null(event.data)==F){
      clickedSkill <- as.character(event.data['y'])
      updateSelectInput(session, "skill", selected=clickedSkill)
    }
  })
 
  output$title2skills <- renderPlotly({
    
    f1 <- list( family = "Montserrat, sans-serif",size = 18,color = "lightblack")
    f2 <- list(family = "Montserrat, sans-serif",size = 14,color = "lightblack")
    m = list(l = 150, t=45, r=150)
    SubN = subset(N, Title == input$title & Ordinal < input$topSkills)
    ylab <- list(title = "", tickfont = f2)
    xlab <- list(range = c(0, max(SubN$num)*100/D[input$title,'den']+9.9), ticksuffix = '%', title = "", dtick = 10)
    
    plot_ly( SubN, x = rev(num)*100/D[input$title,'den'], y = rev(Skill), opacity = 0.6, type = "bar", orientation = 'h', source = "skillBarChart",
             text = paste0(round(rev(num)*100/D[input$title,'den'],digits=2),'% = ',rev(num),'/',D[input$title,'den']), hoverinfo = "text+all", marker = list(color = rgb(255/255,173/255,0/255)))%>% 
layout(xaxis = xlab, yaxis = ylab, titlefont = f1, margin = m, title = paste('Percent of skills required in',input$title,'postings'))

    

  })
  
  output$skill2titles <- renderPlotly({
    f1 <- list( family = "Montserrat, sans-serif",size = 18,color = "lightblack")
    f2 <- list(family = "Montserrat, sans-serif",size = 14,color = "lightblack")
    m = list(l = 300, t=45)
    S = subset(MyData, Skill == input$skill & Ordinal < input$topTitles)
    ylab <- list(title = "", tickfont = f2)
    xlab <- list(range = c(0, max(S$Ratio)*100+9.9), ticksuffix = '%', title = "", dtick = 10)
    
    plot_ly( S, x = rev(Ratio)*100, y = rev(Title), opacity = 0.6, type = "bar", orientation = 'h', source = "titleBarChart",
             text = paste0(rev(Ratio)*100,'% = ',rev(num),'/',rev(den)), hoverinfo = "text+all", marker = list(color = rgb(36/255,195/255,200/255)))%>% 
        layout(xaxis = xlab, yaxis = ylab, titlefont = f1, margin = m, title = paste('Percent of job posts that request knowledge of',input$skill))
  })
  
})
