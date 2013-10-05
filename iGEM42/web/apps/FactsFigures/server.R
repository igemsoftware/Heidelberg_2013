## get all stuff in global up and running
source("global.R")

shinyServer(function(input, output) {

# big function, which takes as input the split data.frames by ddply and returns different summary statistics
timelineDatGenerator <- function(x) {
	output = data.frame(
		"Teams" = nrow(x),
		"Students" = sum(x$students_count),
		"Advisors" = sum(x$advisors_count),
		"Instructors" = sum(x$instructors_count),
		"ChampionshipAwards" = sum(x$awards_championship_count))
	return(output)
}

timelineNvd3Gen <- function(x) {
	timelineDat <- ddply(x, c("year","region"), timelineDatGenerator)
	#now another hack to make sure even teams/categories not present in all years can be represented by nvd3
	for (year in 2007:2012) {
		for (region in unique(timelineDat$region)) {
			if (length(which(timelineDat$year == year & timelineDat$region == region)) == 0) {
				newEntry = data.frame(year = year, region = region, Teams= 0, Students= 0, Advisors = 0, Instructors = 0, ChampionshipAwards=0)
				timelineDat = rbind(timelineDat, newEntry)
			}
		}
	}
	timelineDat = timelineDat[order(timelineDat$year),]
	timelineDat
}
timelineNvd3GenTrack <- function(x) {
	timelineDat <- ddply(x, c("year","track"), timelineDatGenerator)
	#now another hack to make sure even teams/categories not present in all years can be represented by nvd3
	for (year in 2007:2012) {
		for (track in unique(timelineDat$track)) {
			if (length(which(timelineDat$year == year & timelineDat$track == track)) == 0) {
				newEntry = data.frame(year = year, track = track, Teams= 0, Students= 0, Advisors = 0, Instructors = 0, ChampionshipAwards=0)
				timelineDat = rbind(timelineDat, newEntry)
			}
		}
	}
	timelineDat = timelineDat[order(timelineDat$year),]
	timelineDat
}
timelineNvd3GenMedal <- function(x) {
	timelineDat <- ddply(x, c("year","medal"), timelineDatGenerator)
	#now another hack to make sure even teams/categories not present in all years can be represented by nvd3
	for (year in 2007:2012) {
		for (medal in unique(timelineDat$medal)) {
			if (length(which(timelineDat$year == year & timelineDat$medal == medal)) == 0) {
				newEntry = data.frame(year = year, medal = medal, Teams= 0, Students= 0, Advisors = 0, Instructors = 0, ChampionshipAwards=0)
				timelineDat = rbind(timelineDat, newEntry)
			}
		}
	}
	timelineDat = timelineDat[order(timelineDat$year),]
	timelineDat
}

# ok time for some reactive ACTION
dat2 <- reactive({bbqSauceFilter(dat, input)})
timelineDatRegion <- reactive({timelineNvd3Gen(dat2())})
timelineDatTrack <- reactive({timelineNvd3GenTrack(dat2())})
timelineDatMedal <- reactive({timelineNvd3GenMedal(dat2())})

output$myChart <- renderChart({
	if (input$x == "Year") {
		if (input$Sort == "Region") timelinePlot <- nPlot(as.formula(paste0(input$Tsum,"~year")), group = "region", data = timelineDatRegion(), type = "stackedAreaChart", id = "chart", dom = "myChart")
		else if(input$Sort == "Track") timelinePlot <- nPlot(as.formula(paste0(input$Tsum,"~year")), group = "track", data = timelineDatTrack(), type = "stackedAreaChart", id = "chart", dom = "myChart")
		else if(input$Sort == "Medal") timelinePlot <- nPlot(as.formula(paste0(input$Tsum,"~year")), group = "medal", data = timelineDatMedal(), type = "stackedAreaChart", id = "chart", dom = "myChart")
		timelinePlot$yAxis(tickFormat = "#!function(y) { return (y).toFixed(0) }!#", axisLabel = paste0(units[[input$Tsum]],tolower(input$Sort)), width = 60)
		timelinePlot$xAxis(tickFormat = "#!function(x) { return (x).toFixed(0) }!#", axisLabel = "Year")
		sums <- c()
		checkset <- timelineDatRegion()
		for (i in 2007:2012) {
			sums <- c(sums, sum(checkset[checkset$year==i, input$Tsum]))
		}
		if (max(sums) < 6) {
			height <- 80 + (320/6*max(sums))
			timelinePlot$params$height <- height
			output$padding <- renderUI({
				style <- tags$style(paste0('#myChart{padding-top:', (400-height)/2, 'px;} #myChart svg{position:relative; top:10px;}'))
				return(style)})
		}
		else output$padding <- renderUI({return()})
		return(timelinePlot)
	} else {
		p1 <- nPlot(as.formula(paste0(Choices[[input$y]],"~",Choices[[input$x]])), group = tolower(input$Sort), data = dat2(), type = 'scatterChart', id = "chart", dom = "myChart")
		p1$yAxis(axisLabel = units[[input$y]], width =60)
		p1$xAxis(axisLabel = units[[input$x]])
		return(p1)
	}
})
output$TeamList <- renderTable({
	if (input$TeamDisplay == "0") return()
	else {
		outputData <- dat2()
		if (input$TeamSort == "Year") outputData <- outputData[order(outputData$year, decreasing = TRUE),]
		else if (input$TeamSort == "Score") outputData <- outputData[order(outputData$score, decreasing = TRUE),]
		else outputData <- outputData[order(outputData$name),]
		outputData <- data.frame(Name=outputData$name, Year=outputData$year, Wiki=outputData$wiki, Title=outputData$project)
		for (i in 1:dim(outputData)[1]) {
			if (outputData$Title[i] == "-- Not provided yet --") outputData$Title[i] <- "-"
		}
		if (input$TeamDisplay == "all") return(outputData)
		else {
			outputData <- head(outputData, n=as.numeric(input$TeamDisplay))
			return(outputData)
		}
	}
})

#end shinyServer
})