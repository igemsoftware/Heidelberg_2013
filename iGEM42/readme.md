Overview
========
This is the iGEM42 tool, developed by the iGEM Team Heidelberg during iGEM 2013. It is capable of collecting, condensing and displaying data on the past igem years.

Directory structure
-------------------
* __web/__: contains the web interface, written in R using the shiny and rCharts packages.
* __scraper/__: contains the scraping and text mining scripts written in python.
* __analysis__/: contains the R script analysing and converting the generated data.

Python stuff
============
These Python packages can be installed with pip by running
`pip install package`
If you are on Mac OS X or Linux, you need to run this as root:
`sudo pip install package`

Main packages
--------------
* __Python__ (2.7)
* __...__

Other stuff that is loaded by some of our python functions:
-----------------------------------------------------------

* __json__: integration with .json format
* __scrapy__: webscraping framework used for the data generation
* __ntlk__: natural language toolkit used for text mining
* __optparse__: parser used for command line options
* __twisted__: event handling library for coordinating the scraping
* __re__: library for regular expressions in python

R stuff
=======
All R packages, including the base distribution are accessible on http://cran.r-project.org/.

* __base distribution__: basic R environment
* __shiny__: generating R compatible web applications
* __rCharts__: generating elaborate graphs and graphics
* __devtools__: required for installing rCharts
* __RJSONIO__: needed for data conversion from JSON to R

Web integration
---------------
To integrate the apps in a different homepage include an iframe to display the app from corresponding folder. The minimum folders needed are:
* __web/apps__
* __web/data__