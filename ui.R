library(shinyBS)
library(shiny)
library(plotly)

shinyUI(fluidPage(
 
  navbarPage( title = div(a(img(src = "CareerScoreLogo_white.png", height = 38, width = 280),href="https://careerscore.com/")),  theme = "NavbarStyle.css",
      tabPanel(title = 'Skills',  icon=icon("bar-chart"),
          fluidRow(column(width = 6,  fluidRow(column(width = 12, offset = 3, selectInput("skill", label = h3("Select a Skill"), 
                                                                                choices = list("AJAX", "Android", "Angular", "C#", "COBOL", "CSS", "dJango", "Drupal", "Groovy", "Hadoop", "HTML", "iOS", "Jasmine", "Java", "JavaScript", "jQuery", "J2EE", "Linux", "Mongo", ".NET", "Node", "Objective C", "Perl", "PHP", "Python", "R", "Ruby", "Scala", "SQL", "UI/UX", "XML"), selected = "JavaScript")
          )), fluidRow(plotlyOutput("skill2titles", width = "100%", height = 540)), column(width = 12, offset = 3, sliderInput("topTitles","Show Top", min = 5,max = 25,value = 5))),
            
                   
                   column(width = 6, fluidRow(column(width = 12, offset = 2,  uiOutput("titleSelectBox"))),  fluidRow(plotlyOutput("title2skills", width = "100%", height = 540)), column(width = 12, offset = 4, sliderInput("topSkills","Show Top", min = 5,max = 20,value = 5)))
                   )         
              ),
      
      tags$head(tags$style('
                       nav .container:first-child {
                           margin-left:10px; width: 100%;
                           }')),
      tags$script(includeHTML("share.html"))
  )
  
))
