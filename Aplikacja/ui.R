library(shiny)
require(XML)
require(tm)
require(wordcloud)
require(RColorBrewer)
library(dplyr)

shinyUI(fluidPage(
	
	# Application title
	titlePanel("Chmura słów zbudowana na wszystkich wystemowanych artykułach"),
	
	# Sidebar with a slider input for number of bins
	sidebarLayout(
		sidebarPanel(
			sliderInput("kwantyle",
									"Wybierz dolny i górny kwantyl do ucięcia najczęściej
									i najrzadziej występujących słów",
									min = 0,
									max = 1,
									step = 0.01,
									value = c(0,1))
		),
		
		# Show a plot of the generated distribution
		mainPanel(
			plotOutput("distPlot")
		)
	)
))
