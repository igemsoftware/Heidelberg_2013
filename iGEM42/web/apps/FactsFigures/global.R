## Packages:
require(rCharts)
require(plyr)

## Load Data:
load("../../data/DataFromJSON.RData")
dat <- DATParametersFromJSON
dat$score <- dat$score * 100

## Layout choice lists:
Choices <- list(	"Year" = "year",
					"Number of Students" = "students_count",
					"Number of Advisors" = "advisors_count",
					"Number of Instructors" = "instructors_count",
					"Score" = "score",
					"Number of BioBricks" = "biobrick_count",
					"Number of Championship Awards" = "awards_championship_count",
					"Number of Regional Awards" = "awards_regional_count")
myChoicesForX = c("Year", "Number of Students", "Number of Advisors", "Number of Instructors", "Score", "Number of BioBricks", "Number of Championship Awards", "Number of Regional Awards")
myChoicesForY = c("Number of Students", "Number of Advisors", "Number of Instructors", "Score", "Number of BioBricks", "Number of Championship Awards", "Number of Regional Awards")
units <- list(	"Teams" = "Number of teams / ",
				"Students" = "Number of students / ",
				"Instructors" = "Number of instructors / ",
				"Advisors" = "Number of advisors / ",
				"ChampionshipAwards" = "Number of championship awards / ",
				"Number of Students" = "Number of students / team",
				"Number of Advisors" = "Number of advisors / team",
				"Number of Instructors" = "Number of instructors / team",
				"Score" = "Score / team [%]",
				"Number of BioBricks" = "BioBricks submitted / team",
				"Number of Championship Awards" = "Championship awards / team",
				"Number of Regional Awards" = "Regional awards / team" )
myChoicesForTimeline = c("Teams", "Students", "Instructors", "Advisors", "ChampionshipAwards")
myChoicesForSort = c("Region", "Track", "Medal")
myChoicesForRegion <- levels(as.factor(dat$region))
myChoicesForTrack <- levels(as.factor(DATParametersFromJSON$track))
myChoicesForScore <- c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
myChoicesForMedal <- c("", "Bronze", "Silver", "Gold")
myChoicesForRegional_awards <- c("", "Grand Prize", "Regional Finalist", "Best Wiki", "Best Poster", "Best Presentation", "Best Human Practices Advance", "Best Experimental Measurement Approach", "Best Foundational Advance", "Best New BioBrick Part, Natural", "Best New BioBrick Device, Engineered", "Best Model", "Best New Standard", "Safety Commendation")
myChoicesForChampionship_awards <- c("", "Grand Prize", "1st Runner Up", "2nd Runner Up", "Best Rookie Team", "Advance to Software Jamboree", "Advance to Championship", "Finalist", "Best Wiki", "Best Poster", "Best Presentation", "Best Human Practices Advance", "Best Experimental Measurement", "Best Foundational Advance", "Best New BioBrick Part, Natural", "Best New BioBrick Part or Device, Engineered", "Best Model", "Best New Standard", "Safety Commendation", "Best Food & Energy Project", "Best New Application Project", "Best Environment Project", "Best Health & Medicine Project", "Best Manufacturing Project", "Best Software", "Best Requirements Engineering", "Best Eugene Based Design", "Best SBOL Based Tool", "Best Genome Compiler Based Design", "Best Clotho App", "Best Information Processing Project", "Best Interaction with the Parts Registry", "iGEMers Prize")
myChoicesForBB_count <- c(0, 5, 10, 20, 50, 100, 200, ">200")
myChoicesForStudents_count <- c(0, 5, 10, 15, 20, ">20")
myChoicesForAdvisors_count <- c(0, 2, 4, 6, 8, 10, 12, 14, ">14")
myChoicesForInstructors_count <- c(0, 2, 5, 10, 15, ">15")
myChoicesForInformation_content <- c("0", "0.4", "0.45", "0.5", "0.55", "0.6")
myChoicesForYear <- c(2007,2008,2009,2010,2011,2012)
myChoicesForTeamDisplay <- c("0", "5", "10", "20", "50", "100", "all")
myChoicesForTeamSort <- c("Year", "Alphabetic", "Score")

# big ass filter
bbqSauceFilter <- function(data, input){
	data <- FilterForYear(data, input)
	data <- FilterForTeamName(data, input)
	data <- FilterForAbstract(data, input)
	data <- FilterForMedal(data, input)
	data <- FilterForRegion(data, input)
	data <- FilterForTrack(data, input)
	data <- FilterForScore(data, input)
	data <- FilterForInformation_content(data, input)
	data <- FilterForBiobrick_count(data, input)
	data <- FilterForStudents_count(data, input)
	data <- FilterForAdvisors_count(data, input)
	data <- FilterForInstructors_count(data, input)
	data <- FilterForRegionalAwards(data, input)
	data <- FilterForChampionshipAwards(data, input)
	return(data)
}
FilterForYear <- function(data, input) {
	delete <- which(data$year < input$FILyear_min | data$year > input$FILyear_max)
	if (length(delete) != 0) data <- data[-delete,]
	rm(delete)
	return(data)
}
FilterForTeamName <- function(data, input) {
	keepteams <- c()
	Names <- unlist(strsplit(input$FILname, ", "))
	Names <- unlist(strsplit(Names, ","))
	for (i in 1:length(Names)) {
		keepteams <- c(keepteams, grep(Names[i], data$name))
	}
	if (length(keepteams) != 0) data <- data[keepteams,]
	rm(keepteams)
	return(data)
}
FilterForRegion <- function(data, input) {
	matchRegion <- rep(0, times=length(data$region))
	for (i in 1:length(input$FILregion)) {
		matchRegion[which(data$region == input$FILregion[i])] <- 1
	}
	delete <- which(matchRegion == 0)
	if (length(delete) != 0) data <- data[-delete,]
	rm(matchRegion)
	rm(delete)
	return(data)
}
FilterForTrack <- function(data, input) {
	matchTrack <- rep(0, times=length(data$track))
	for (i in 1:length(input$FILtrack)) {
		matchTrack[which(data$track == input$FILtrack[i])] <- 1
	}
	delete <- which(matchTrack == 0)
	if (length(delete) != 0) data <- data[-delete,]
	rm(matchTrack)
	rm(delete)
	return(data)
}
FilterForStudents_count <- function(data, input) {
	if (input$FILstudents_count_min == ">20") data <- data[-which(data$students_count < 20),]
	else if (input$FILstudents_count_max == ">20" & input$FILstudents_count_min != "0") data <- data[-which(data$students_count < as.numeric(input$FILstudents_count_min)),]
	else if (input$FILstudents_count_max == ">20" & input$FILstudents_count_min == "0") return(data)
	else data <- data[-which(data$students_count < as.numeric(input$FILstudents_count_min) | data$students_count > as.numeric(input$FILstudents_count_max)),]
	return(data)
}
FilterForAdvisors_count <- function(data, input) {
	if (input$FILadvisors_count_min == ">14") data <- data[-which(data$advisors_count < 14),]
	else if (input$FILadvisors_count_max == ">14" & input$FILadvisors_count_min != "0") data <- data[-which(data$advisors_count < as.numeric(input$FILadvisors_count_min)),]
	else if (input$FILadvisors_count_max == ">14" & input$FILadvisors_count_min == "0") return(data)
	else data <- data[-which(data$advisors_count < as.numeric(input$FILadvisors_count_min) | data$advisors_count > as.numeric(input$FILadvisors_count_max)),]
	return(data)
}
FilterForInstructors_count <- function(data, input) {
	if (input$FILinstructors_count_min == ">15") data <- data[-which(data$instructors_count < 15),]
	else if (input$FILinstructors_count_max == ">15" & input$FILinstructors_count_min != "0") data <- data[-which(data$instructors_count < as.numeric(input$FILinstructors_count_min)),]
	else if (input$FILinstructors_count_max == ">15" & input$FILinstructors_count_min == "0") return(data)
	else data <- data[-which(data$instructors_count < as.numeric(input$FILinstructors_count_min) | data$instructors_count > as.numeric(input$FILinstructors_count_max)),]
	return(data)
}
FilterForScore <- function(data, input) {
	delete <- which(data$score < as.numeric(input$FILscore_min) | data$score > as.numeric(input$FILscore_max))
	if (length(delete) != 0) data <- data[-delete,]
	rm(delete)
	return(data)
}
FilterForBiobrick_count <- function(data, input) {
	if (input$FILbiobrick_count_min == ">200") data <- data[-which(data$biobrick_count < 200),]
	else if (input$FILbiobrick_count_max == ">200" & input$FILbiobrick_count_min != "0") data <- data[-which(data$biobrick_count < as.numeric(input$FILbiobrick_count_min)),]
	else if (input$FILbiobrick_count_max == ">200" & input$FILbiobrick_count_min == "0") return(data)
	else data <- data[-which(data$biobrick_count < as.numeric(input$FILbiobrick_count_min) | data$biobrick_count > as.numeric(input$FILbiobrick_count_max)),]
	return(data)
}
FilterForAbstract <- function(data, input) {
	if (input$FILabstract == FALSE) return(data)
	delete <- c()
	for (i in 1:length(row.names(data))) {
		if (DATContentsFromJSON[[row.names(data)[i]]]$abstract == "-- No abstract provided yet --") delete <- c(delete, i)
	}
	if(length(delete) != 0) data <- data[-delete,]
	rm(delete)
	return(data)
}
FilterForInformation_content <- function(data, input) {
	if (length(which(data$information_content < as.numeric(input$FILinformation_content))) != 0)	data <- data[-which(data$information_content < as.numeric(input$FILinformation_content)),]
	return(data)
}
FilterForMedal <- function(data, input) {
	matchMedal <- rep(0, times=length(data$medal))
	for (i in 1:length(input$FILmedal)) {
		matchMedal[which(data$medal == input$FILmedal[i])] <- 1
	}
	delete <- which(matchMedal == 0)
	if (length(delete) != 0) data <- data[-delete,]
	rm(matchMedal)
	rm(delete)
	return(data)
}
FilterForRegionalAwards <- function(data, input) {
	keepteams <- c()
	Contents <- DATContentsFromJSON
	for (i in 1:length(input$FILawards_regional)) {
		deleteindex <- c()
		if (input$FILawards_regional[i] == "") {
			for (j in 1:length(names(Contents))) {
				if (Contents[[j]]$awards_regional[1] == "") {
					keepteams <- c(keepteams, names(Contents)[j])
					deleteindex <- c(deleteindex, j)
				}
			}
			if (length(deleteindex) != 0) Contents <- Contents[-deleteindex]
		} else {
			for (j in 1:length(names(Contents))) {
				if (length(grep(input$FILawards_regional[i], Contents[[j]]$awards_regional)) != 0) {
					keepteams <- c(keepteams, names(Contents)[j])
					deleteindex <- c(deleteindex, j)
				}
			}
			if (length(deleteindex) != 0) Contents <- Contents[-deleteindex]
		}
	}
	if (length(keepteams) != 0) data <- data[keepteams,]
	if (length(grep("NA\\.", row.names(data), perl=TRUE)) != 0 ) data <- data[-grep("NA\\.", row.names(data), perl=TRUE),]
	if (length(which(row.names(data) == "NA")) == 1) data <- data[-which(row.names(data) == "NA"),]
	rm(keepteams)
	rm(Contents)
	rm(deleteindex)
	return(data)
}
FilterForChampionshipAwards <- function(data, input) {
	keepteams <- c()
	Contents <- DATContentsFromJSON
	for (i in 1:length(input$FILawards_championship)) {
		deleteindex <- c()
		if (input$FILawards_championship[i] == "") {
			for (j in 1:length(names(Contents))) {
				if (Contents[[j]]$awards_championship[1] == "") {
					keepteams <- c(keepteams, names(Contents)[j])
					deleteindex <- c(deleteindex, j)
				}
			}
			if (length(deleteindex) != 0) Contents <- Contents[-deleteindex]
		} else {
			for (j in 1:length(names(Contents))) {
				if (length(grep(input$FILawards_championship[i], Contents[[j]]$awards_championship)) != 0) {
					keepteams <- c(keepteams, names(Contents)[j])
					deleteindex <- c(deleteindex, j)
				}
			}
			if (length(deleteindex) != 0) Contents <- Contents[-deleteindex]
		}
	}
	if (length(keepteams) != 0) data <- data[keepteams,]
	if (length(grep("NA\\.", row.names(data), perl=TRUE)) != 0 ) data <- data[-grep("NA\\.", row.names(data), perl=TRUE),]
	if (length(which(row.names(data) == "NA")) == 1) data <- data[-which(row.names(data) == "NA"),]
	rm(keepteams)
	rm(Contents)
	rm(deleteindex)
	return(data)
}