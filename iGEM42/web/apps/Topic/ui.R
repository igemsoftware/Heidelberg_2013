shinyUI(
	bootstrapPage(
		includeHTML("style.css"),
		div(id="wrapper",
			div(class="container-fluid", id="Top",
				div(id="Select",
					textInput(inputId="FILTopic",
						label="Enter a topic",
						value="Some Topic"),
					selectInput(
						inputId="TeamDisplay",
						label="Display table of teams",
						choices=myChoicesForTeamDisplay,
						selected="5" ),
					selectInput(
						inputId="TeamSort",
						label="Sorted by",
						choices=myChoicesForTeamSort,
						selected="Score" ),
					includeHTML("javascript.js")
				),
				div(id="Welcome",
					h3("Find expertise on a certain topic"),
					p("Here you can find teams by the topics they worked on. Just type a term in the text box to the left, select how many teams you want to see and start browsing. If the term you want to enter is red this means, that there was no exact match in out data, but you can still try to find something similar. The topics were determined only according to the abstracts submitted. Thus the 2007 and 2008 teams are not yet included. You can also get a good overview of the hot topics by looking at the top 10 table.")  
				)
			),
			div(class="container-fluid", id="Output",
				div(class="span4",
					h4("See the top 10 topics:"),
					tableOutput(outputId="Top10")
				),
				div(class="container-fluid",
					h4("Teams who worked on the selected topic:"),
					tableOutput(outputId="TeamList")
				)
			)
		)
	)
)		