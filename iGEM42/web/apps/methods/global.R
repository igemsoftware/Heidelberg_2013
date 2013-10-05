load("../../data/DataFromJSON.RData")
dat <- DATParametersFromJSON

## Calculate Top 10
methods <- c()
for(i in 1:length(DATContentsFromJSON)) methods <- c(methods, names(DATContentsFromJSON[[i]]$methods))
methodslevels <- levels(as.factor(methods))
Top10 <- data.frame(Method=methodslevels, Teams=rep(0, length(methodslevels)))
for(i in 1:length(methodslevels)) {
	Top10$Teams[which(Top10$Method==methodslevels[i])] <- length(which(methods == methodslevels[i]))
}
Top10 <- Top10[order(Top10$Teams, decreasing=TRUE),]
Top10 <- data.frame(Method = Top10$Method, Teams = Top10$Teams)

myChoicesForTeamDisplay <- c("0", "5", "10", "20", "50", "100", "all")
myChoicesForTeamSort <- c("Year", "Alphabetic", "Score")
myChoicesForMethodCluster <- c("Genomics", "Proteomics", "Imaging", "Bioanalytics", "(Bio-)Informatics", "Engineering", "Physiology", "Biophysics, Chemical biology")
myChoicesForMethods <- list(	"Genomics" = c(
		"Primer design",
		"Traditional cloning",
		"Gibson",
		"Restriction Digestion",
		"Ligation",
		"Sequencing",
		"Sanger sequencing",
		"Next generation sequencing",
		"PCR",
		"Microarray",
		"Transformation",
		"DNA extraction",
		"DNA preparation",
		"Insert preparation",
		"Gel electrophoresis",
		"Gel extraction",
		"Mutagenesis",
		"Bacterial artificial chromosome",
		"FISH",
		"Genome deletion",
		"Northern Blot",
		"Southern Blot"),
	"Proteomics" = c(
		"Fusion proteins",
		"Protein interaction",
		"Western Blot",
		"ELISA",
		"Immuno assays",
		"Coimmunoprecipitation",
		"Protein purification"),
	"Imaging" = c(
		"FRET",
		"Electron microscopy",
		"Fluorescence microscopy",
		"Imaging"),
	"Bioanalytics" = c(
		"Interaction chromatography",
		"Thin layer chromatography",
		"Ion exchange chromatography",
		"Chromatography",
		"Flow cytometry",
		"Cell fractionation",
		"Cell counting",
		"Southwestern blot",
		"Phenotypic analysis",
		"Spectroscopy",
		"Spectrometry"),
	"(Bio-)Informatics" = c(
		"Computer simulation",
		"Computer model",
		"Bioinformatics",
		"Image processing",
		"Neural networks"),
	"Engineering" = c(
		"Assembly line",
		"Drug production",
		"Encapsulation",
		"Kill switch",
		"Fermentation",
		"Directed delivery"),
	"Physiology" = c(
		"Patch clamp",
		"Mouse model",
		"Intercellular signaling",
		"Intracellular signaling"),
	"Biophysics, Chemical biology" = c(
		"Crystallography",
		"NMR",
		"Mass spectrometry") )
							
FilterForMethods <- function(data, input) {
	keepteams <- c()
	if (input$L1 == "Genomics") method <- "L12"
	else if (input$L1 == "Proteomics") method <- "L22"
	else if (input$L1 == "Imaging") method <- "L32"
	else if (input$L1 == "Bioanalytics") method <- "L42"
	else if (input$L1 == "(Bio-)Informatics") method <- "L52"
	else if (input$L1 == "Engineering") method <- "L62"
	else if (input$L1 == "Physiology") method <- "L72"
	else if (input$L1 == "Biophysics, Chemical biology") method <- "L82"
	Contents <- DATContentsFromJSON
	for	(i in 1:length(DATContentsFromJSON)) {
		if (length(which(names(Contents[[i]]$methods) == input[[method]])) != 0) keepteams <- c(keepteams, names(Contents)[i])
	}
	if (length(keepteams) != 0) data <- data[keepteams,]
	else return(data.frame("name" = "No", "year" = "Teams", "wiki" = "using", "score"=c("Teams", "for this method"), "project"="this method"))
	if (length(grep("NA\\.", row.names(data), perl=TRUE)) != 0 ) data <- data[-grep("NA\\.", row.names(data), perl=TRUE),]
	if (length(which(row.names(data) == "NA")) == 1) data <- data[-which(row.names(data) == "NA"),]
	rm(keepteams)
	rm(Contents)
	return(data)
}