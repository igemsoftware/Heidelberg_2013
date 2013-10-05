shinyUI(
	bootstrapPage(
		includeHTML("style.css"),
		div(id="wrapper",
			div(class="container-fluid", id="Top",
				div(id="Select",
					selectInput(inputId="L1",
						label="Choose Category",
						choices=myChoicesForMethodCluster,
						selected=myChoicesForMethodCluster[1]),
					conditionalPanel(
						condition="input.L1 == 'Genomics'",
						selectInput(inputId="L12",
							label="Choose Method",
							choices=myChoicesForMethods$Genomics,
							selected=myChoicesForMethods$Genomics[1])),
					conditionalPanel(
						condition="input.L1 == 'Proteomics'",
						selectInput(inputId="L22",
							label="Choose Method",
							choices=myChoicesForMethods$Proteomics,
							selected=myChoicesForMethods$Proteomics[1])),
					conditionalPanel(
						condition="input.L1 == 'Imaging'",
						selectInput(inputId="L32",
							label="Choose Method",
							choices=myChoicesForMethods$Imaging,
							selected=myChoicesForMethods$Imaging[1])),
					conditionalPanel(
						condition="input.L1 == 'Bioanalytics'",
						selectInput(inputId="L42",
							label="Choose Method",
							choices=myChoicesForMethods$Bioanalytics,
							selected=myChoicesForMethods$Bioanalytics[1])),
					conditionalPanel(
						condition="input.L1 == '(Bio-)Informatics'",
						selectInput(inputId="L52",
							label="Choose Method",
							choices=myChoicesForMethods[["(Bio-)Informatics"]],
							selected=myChoicesForMethods[["(Bio-)Informatics"]][1])),
					conditionalPanel(
						condition="input.L1 == 'Engineering'",
						selectInput(inputId="L62",
							label="Choose Method",
							choices=myChoicesForMethods$Engineering,
							selected=myChoicesForMethods$Engineering[1])),
					conditionalPanel(
						condition="input.L1 == 'Physiology'",
						selectInput(inputId="L72",
							label="Choose Method",
							choices=myChoicesForMethods$Physiology,
							selected=myChoicesForMethods$Physiology[1])),
					conditionalPanel(
						condition="input.L1 == 'Biophysics, Chemical biology'",
						selectInput(inputId="L82",
							label="Choose Method",
							choices=myChoicesForMethods[["Biophysics, Chemical biology"]],
							selected=myChoicesForMethods[["Biophysics, Chemical biology"]][1])),
					selectInput(
						inputId="TeamDisplay",
						label="Display table of teams",
						choices=myChoicesForTeamDisplay,
						selected="5" ),
					selectInput(
						inputId="TeamSort",
						label="Sorted by",
						choices=myChoicesForTeamSort,
						selected="Score" )
				),
				div(id="Welcome",
					h3("Find experimental expertise"),
					p("Here you can select which method you want to find some experts for. This is a good opportunity to find collaboration partners. Currently this is only based on the abstracts the teams submitted, but it will be extended to include all the methods from the whole wikis. Be careful, since the abstracts from 2007 or 2008 can't be found outside the wikis these teams are not included here! Besides that: Have fun.")
				)
			),
			div(id="Output",
				div(class="span4",
					h4("See the top 10 methods used:"),
					tableOutput(outputId="Top10")
				),
				div(class="container-fluid",
					h4("Teams using the selected method:"),
					tableOutput(outputId="TeamList")
				)
			)
		)
	)
)		