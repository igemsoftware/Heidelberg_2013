load("../../data/DataFromJSON.RData")
dat <- DATParametersFromJSON

## Calculate Top 10
topics <- c()
for(i in 1:length(DATContentsFromJSON)) topics <- c(topics, names(DATContentsFromJSON[[i]]$meshterms))
topicslevels <- levels(as.factor(topics))
Top10 <- data.frame(Topic=topicslevels, Teams=rep(0, length(topicslevels)))
for(i in 1:length(topicslevels)) {
	Top10$Teams[which(Top10$Topic==topicslevels[i])] <- length(which(topics == topicslevels[i]))
}
Top10 <- Top10[order(Top10$Teams, decreasing=TRUE),]
Top10 <- data.frame(Topic = Top10$Topic, Teams = Top10$Teams)


myChoicesForTeamDisplay <- c("0", "5", "10", "20", "50", "100", "all")
myChoicesForTeamSort <- c("Year", "Alphabetic", "Score")
							
FilterForTopics <- function(data, input) {
	keepteams <- c()
	Contents <- DATContentsFromJSON
	for	(i in 1:length(DATContentsFromJSON)) {
		if (length(agrep(input$FILTopic, names(Contents[[i]]$meshterms), ignore.case=TRUE, max.distance=list(ins=2, del=1, subs=1))) != 0) keepteams <- c(keepteams, names(Contents)[i])
	}
	if (length(keepteams) != 0) data <- data[keepteams,]
	else return(data.frame("name" = "No", "year" = "Teams", "wiki" = "working", "score"=c("Teams", "for this method"), "project"="on this topic."))
	if (length(grep("NA\\.", row.names(data), perl=TRUE)) != 0 ) data <- data[-grep("NA\\.", row.names(data), perl=TRUE),]
	if (length(which(row.names(data) == "NA")) == 1) data <- data[-which(row.names(data) == "NA"),]
	rm(keepteams)
	rm(Contents)
	return(data)
}