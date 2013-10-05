###########################################################
#### R script to convert json file produced by scrapy to 
#### dtaa sets and list contianing the information.
#### -> One data sets with all single value parameters
#### -> One list contianing all multiple value parameters
#### Requires package RJSONIO + methods
###########################################################

require(RJSONIO)
#### Import from .json file (Change to appropriate filename
JSONList <- fromJSON("../scraper/data/test.json")
#names(JSONList[[2]])

### naive scoring function
scoringFunc <- function(tomatchList, scoresDataFrame) {
	sum(
		apply(scoresDataFrame, MARGIN=1, function(item){
			resVec <- grep(item[1], tomatchList, ignore.case=TRUE, perl=TRUE)
			as.integer(item[2])*length(resVec)
		})
	)
}

### hardcoded Score_List for naive Scoring function
awardScores <- data.frame(
	rbind(
	# FINAL
	c("Grand Prize",324.8),
	c("1st Runner Up",154.0),
	c("2nd Runner Up",123.7),
	c("Advance to Championship",33.9),
	c("Finalist",62.1), 
	c("Advance to Software Jamboree",33.9),
	c("Best Wiki",35.2),
	c("Best Poster",30.1),
	c("Best Presentation",33.4),
	c("Best Human Practices Advance",32.0),
	c("Best Experimental Measurement",35.7),
	c("Best New BioBrick Part, Natural",38.0),
	c("Best New BioBrick Part or Device, Engineered",38.5),
	c("Best Model",40.8),
	c("Safety Commendation",40.8),
	c("Best Food & Energy Project",56.5),
	c("Best New Application Project",65.7),
	c("Best Environment Project",59.2),
	c("Best Health & Medicine Project",63.9),
	c("Best Foundational Advance Project",65.7),
	c("Best Manufacturing Project",56.8),
	c("Best Software",54.0),
	c("Best Software Tool",54.0),
	c("Best Requirements Engineering",36.7),
	c("Best Eugene Based Design",34.3),
	c("Best SBOL Based Tool",34.7),
	c("Best Genome Compiler Based Design",31.4),
	c("Best Clotho App",32.1),
	c("Best Information Processing Project",42.5),
	c("Best Interaction with the Parts Registry",43.1),
	c("Best Rookie Team",30.1),
	c("iGEMers Prize",62.1),
	# REGIONAL
	c("Grand Prize",83.5),
	c("Regional Finalist",21.5),
	c("Best Wiki",14.8),
	c("Best Poster",13.0),
	c("Best Presentation",15.3),
	c("Best Human Practices Advance",15.3),
	c("Best Experimental Measurement Approach",16.7),
	c("Best New BioBrick Part, Natural, (?=Americas|Asia|Europe|Latin America|Americas West|Americas East)",17.6),
	c("Best New BioBrick Device, Engineered",17.6),
	c("Best Model",17.7),
	c("Best New Standard",18.9),
	c("Safety Commendation",15.7),
	# MEDALS
	c("Gold",15.6),
	c("Silver",9.3),
	c("Bronze",4.4)
	)
)

#### Produce empty Parameters data frame
DATParametersFromJSON <- data.frame()

#### Go through all teams and write parameters to dataframe
#### Add queries for single value parameters here
#### Watch out for empty parameters! (e.g. track)
ErrorListRegion <- c()
ErrorListTrack <- c()
ErrorListWiki <- c()
ErrorListUrl <- c()
ErrorListIC <- c()
ErrorListProject <- c()
for (i in 1:length(JSONList)) {
	name <- paste(JSONList[[i]]$name, JSONList[[i]]$year, sep = "")
	DATParametersFromJSON[name, "name"] <- JSONList[[i]]$name
	DATParametersFromJSON[name, "year"] <- as.numeric(JSONList[[i]]$year)
	if(length(JSONList[[i]]$region) == 0) { 
		DATParametersFromJSON[name, "region"] <- ""
		ErrorListRegion <- c(ErrorListRegion, name)
	} else DATParametersFromJSON[name, "region"] <- JSONList[[i]]$region
	if(length(JSONList[[i]]$track) == 0) {
		DATParametersFromJSON[name, "track"] <- ""
		ErrorListTrack <- c(ErrorListTrack, name)
	} else DATParametersFromJSON[name, "track"] <- JSONList[[i]]$track
	if(length(JSONList[[i]]$medal) == 0) DATParametersFromJSON[name, "medal"] <- ""
	else DATParametersFromJSON[name, "medal"] <- JSONList[[i]]$medal
	DATParametersFromJSON[name, "students_count"] <- length(JSONList[[i]]$students)
	DATParametersFromJSON[name, "advisors_count"] <- length(JSONList[[i]]$advisors)
	DATParametersFromJSON[name, "instructors_count"] <- length(JSONList[[i]]$instructors)
	if(length(JSONList[[i]]$wiki) == 0) {
		DATParametersFromJSON[name, "wiki"] <- ""
		ErrorListWIki <- c(ErrorListWiki, name)
	} else DATParametersFromJSON[name, "wiki"] <- JSONList[[i]]$wiki
	if(length(JSONList[[i]]$url) == 0) {
		DATParametersFromJSON[name, "url"] <- ""
		ErrorListUrl <- c(ErrorListUrl, name)
	} else DATParametersFromJSON[name, "url"] <- JSONList[[i]]$url
	if(length(JSONList[[i]]$project) == 0) {
		DATParametersFromJSON[name, "project"] <- ""
		ErrorListProject <- c(ErrorListProject, name)
	} else DATParametersFromJSON[name, "project"] <- JSONList[[i]]$project
	DATParametersFromJSON[name, "awards_regional_count"] <- length(JSONList[[i]]$awards_regional)
	DATParametersFromJSON[name, "awards_championship_count"] <- length(JSONList[[i]]$awards_championship)
	DATParametersFromJSON[name, "biobrick_count"] <- length(JSONList[[i]]$parts)
	if(length(JSONList[[i]]$information_content) == 0) {
		DATParametersFromJSON[name, "information_content"] <- 0
		ErrorListIC <- c(ErrorListIC, name)
	} else DATParametersFromJSON[name, "information_content"] <- as.numeric(JSONList[[i]]$information_content)
}

#### Produce empty Parameters data frame
DATContentsFromJSON <- list()

#### Go through all teams and write parameters to list
#### Add queries for multiple value parameters here
#### Watch out for empty parameters!
for (i in 1:length(JSONList)) {
	name <- paste(JSONList[[i]]$name, JSONList[[i]]$year, sep = "")
	DATContentsFromJSON[[name]] <- list()
	DATContentsFromJSON[[name]][["year"]] <- JSONList[[i]]$year
	if (length(JSONList[[i]]$awards_regional) == 0) DATContentsFromJSON[[name]][["awards_regional"]] <- ""
	else DATContentsFromJSON[[name]]["awards_regional"] <- JSONList[[i]]["awards_regional"]
	if (length(JSONList[[i]]$awards_championship) == 0) DATContentsFromJSON[[name]][["awards_championship"]] <- ""
	else DATContentsFromJSON[[name]]["awards_championship"] <- JSONList[[i]]["awards_championship"]
	## Check Championship Awards
	DATContentsFromJSON[[name]]$awards_championship[grep("Grand Prize", DATContentsFromJSON[[name]]$awards_championship)] <- "Grand Prize"
	DATContentsFromJSON[[name]]$awards_championship[grep("(1st)|(First) Runner Up", DATContentsFromJSON[[name]]$awards_championship, perl=TRUE)] <- "1st Runner Up"
	DATContentsFromJSON[[name]]$awards_championship[grep("(2nd)|(Second) Runner Up", DATContentsFromJSON[[name]]$awards_championship, perl=TRUE)] <- "2nd Runner Up"
	DATContentsFromJSON[[name]]$awards_championship[grep("Environment", DATContentsFromJSON[[name]]$awards_championship)] <- "Best Environment Project"
	DATContentsFromJSON[[name]]$awards_championship[grep("Energy", DATContentsFromJSON[[name]]$awards_championship)] <- "Best Food & Energy Project"
	DATContentsFromJSON[[name]]$awards_championship[grep("Health", DATContentsFromJSON[[name]]$awards_championship)] <- "Best Health & Medicine Project"
	DATContentsFromJSON[[name]]$awards_championship[grep("Foundational", DATContentsFromJSON[[name]]$awards_championship)] <- "Best Foundational Advance Project"
	DATContentsFromJSON[[name]]$awards_championship[grep("New Application", DATContentsFromJSON[[name]]$awards_championship)] <- "Best New Application Project"
	DATContentsFromJSON[[name]]$awards_championship[grep("Part, Natural", DATContentsFromJSON[[name]]$awards_championship)] <- "Best New BioBrick Part, Natural"
	DATContentsFromJSON[[name]]$awards_championship[grep("Best Model", DATContentsFromJSON[[name]]$awards_championship)] <- "Best Model"
	DATContentsFromJSON[[name]]$awards_championship[grep("Information Processing", DATContentsFromJSON[[name]]$awards_championship)] <- "Best Information Processing Project"
	DATContentsFromJSON[[name]]$awards_championship[grep("Software Tool", DATContentsFromJSON[[name]]$awards_championship)] <- "Best Software"
	DATContentsFromJSON[[name]]$awards_championship[grep("Presentation", DATContentsFromJSON[[name]]$awards_championship)] <- "Best Presentation"
	## Check Regional Awards
	DATContentsFromJSON[[name]]$awards_regional[grep("Grand Prize", DATContentsFromJSON[[name]]$awards_regional)] <- "Grand Prize"
	DATContentsFromJSON[[name]]$awards_regional[grep("Finalist", DATContentsFromJSON[[name]]$awards_regional)] <- "Regional Finalist"
	DATContentsFromJSON[[name]]$awards_regional[grep("Human Practices", DATContentsFromJSON[[name]]$awards_regional)] <- "Best Human Practices Advance"
	DATContentsFromJSON[[name]]$awards_regional[grep("Experimental Measurement", DATContentsFromJSON[[name]]$awards_regional)] <- "Best Experimental Measurement Approach"
	DATContentsFromJSON[[name]]$awards_regional[grep("Model", DATContentsFromJSON[[name]]$awards_regional)] <- "Best Model"
	DATContentsFromJSON[[name]]$awards_regional[grep("Device, Engineered", DATContentsFromJSON[[name]]$awards_regional)] <- "Best New BioBrick Device, Engineered"
	DATContentsFromJSON[[name]]$awards_regional[grep("Part, Natural", DATContentsFromJSON[[name]]$awards_regional)] <- "Best New BioBrick Part, Natural"
	DATContentsFromJSON[[name]]$awards_regional[grep("Standard", DATContentsFromJSON[[name]]$awards_regional)] <- "Best New Standard"
	DATContentsFromJSON[[name]]$awards_regional[grep("Poster", DATContentsFromJSON[[name]]$awards_regional)] <- "Best Poster"
	DATContentsFromJSON[[name]]$awards_regional[grep("Presentation", DATContentsFromJSON[[name]]$awards_regional)] <- "Best Presentation"
	DATContentsFromJSON[[name]]$awards_regional[grep("Wiki", DATContentsFromJSON[[name]]$awards_regional)] <- "Best Wiki"
	DATContentsFromJSON[[name]]$awards_regional[grep("Safety", DATContentsFromJSON[[name]]$awards_regional)] <- "Safety Commendation"
	if (length(JSONList[[i]]$parts_range) == 0) DATContentsFromJSON[[name]][["parts_range"]] <- ""
	else DATContentsFromJSON[[name]]["parts_range"] <- JSONList[[i]]["parts_range"]
	if (length(JSONList[[i]]$parts) == 0) DATContentsFromJSON[[name]][["parts"]] <- ""
	else DATContentsFromJSON[[name]][["parts"]] <- JSONList[[i]]$parts
	if (length(JSONList[[i]]$meshterms) == 0) DATContentsFromJSON[[name]][["meshterms"]] <- ""
	else DATContentsFromJSON[[name]][["meshterms"]] <- JSONList[[i]]$meshterms
	if (length(JSONList[[i]]$methods) == 0) DATContentsFromJSON[[name]][["methods"]] <- ""
	else DATContentsFromJSON[[name]][["methods"]] <- JSONList[[i]]$methods
	if (length(JSONList[[i]]$topwords) == 0) DATContentsFromJSON[[name]][["topwords"]] <- ""
	else DATContentsFromJSON[[name]][["topwords"]] <- JSONList[[i]]$topwords
	DATContentsFromJSON[[name]]["project"] <- JSONList[[i]]["project"]
	DATContentsFromJSON[[name]]["abstract"] <- JSONList[[i]]["abstract"]
	## Meshterms is named numeric vector of term-counts
	if (length(JSONList[[i]]$meshterms) == 0) DATContentsFromJSON[[name]]["meshterms"] <- c()
	else DATContentsFromJSON[[name]]["meshterms"] <- JSONList[[i]]["meshterms"]
}

## Correct Medals
DATParametersFromJSON$medal[grep("[Bb]ronze", DATParametersFromJSON$medal, perl=TRUE)] <- "Bronze"
DATParametersFromJSON$medal[grep("[Ss]ilver", DATParametersFromJSON$medal, perl=TRUE)] <- "Silver"
DATParametersFromJSON$medal[grep("[Gg]old", DATParametersFromJSON$medal, perl=TRUE)] <- "Gold"
## Correct Region
DATParametersFromJSON$region[grep("America", DATParametersFromJSON$region, perl=TRUE)] <- "America"
DATParametersFromJSON$region <- gsub("Canada", "America", DATParametersFromJSON$region)
DATParametersFromJSON$region <- gsub("US", "America", DATParametersFromJSON$region)
DATParametersFromJSON$region <- gsub("--Specify Region--", "No region specified", DATParametersFromJSON$region)
## Correct Track
DATParametersFromJSON$track[grep("Medic", DATParametersFromJSON$track, perl=TRUE)] <- "Health & Medicine"
DATParametersFromJSON$track[grep("Energy", DATParametersFromJSON$track, perl=TRUE)] <- "Food & Energy"
DATParametersFromJSON$track[grep("Foundational", DATParametersFromJSON$track, perl=TRUE)] <- "Foundational Advance"

for(i in 1:dim(DATParametersFromJSON)[1]) {
	## use naive scoring function to calculate certain scores
	DATParametersFromJSON[i, "score"] <- as.numeric(scoringFunc(c(DATContentsFromJSON[[i]][["awards_regional"]],DATContentsFromJSON[[i]][["awards_championship"]],DATParametersFromJSON[i, "medal"]), awardScores))
	#str(c(JSONList[[i]][["awards_regional"]],JSONList[[i]][["awards_championship"]],JSONList[[i]][["medal"]]))
}

### normalize by year
for(y in min(DATParametersFromJSON$year):max(DATParametersFromJSON$year) ) {
	m <- max(DATParametersFromJSON$score[DATParametersFromJSON$year==y])
	DATParametersFromJSON$score[DATParametersFromJSON$year==y] <- DATParametersFromJSON$score[DATParametersFromJSON$year==y]/m
}

#### Write dataframe and list to one .RData file
save(DATParametersFromJSON, DATContentsFromJSON, file = "../homepage/data/DataFromJSON.RData")
