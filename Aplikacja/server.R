library(shiny)
require(XML)
require(tm)
require(wordcloud)
require(RColorBrewer)
library(shiny)
library(dplyr)
load("ap.d_sorted.rda")
pal2 <- brewer.pal(8,"Dark2")
shinyServer(function(input, output) {
	
	
	data <- reactive({
		kwantyl1 <- quantile(ap.d_sorted$freq, input$kwantyle[1])
		kwantyl2 <- quantile(ap.d_sorted$freq, input$kwantyle[2])
		ap.d_sorted %>%
			filter(freq >= kwantyl1,
						 freq <= kwantyl2)
	})
	
	output$distPlot <- renderPlot({
		
		wordcloud(data$word,data$freq, scale=c(8,.2),min.freq=3,
							max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
		
	})
	
})
