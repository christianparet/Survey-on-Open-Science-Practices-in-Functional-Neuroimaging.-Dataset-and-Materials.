 Project: Open Science Practices in Neuroimaging

## Welcome

Thank you for visiting this project page. Great, that you are interested to learn more about this research.
This github project is authored by Nike Unverhau, Maurizio Sicorello, Madita Stirner & Christian Paret from the Central Institute of Mental Health in Mannheim, Germany. It has received valuable support from Franklin Feingold and Russ Poldrack, Center for Open and Reproducible Science in Stanford USA.

## Project description

Functional Magnetic Resonance Imaging (fMRI) is widely used in the generation and testing of biological models of mental disorder, but reluctance in the field to adopt open science practices may threaten scientific progress. For reproducible science, it is pivotal to differentiate confirmatory and exploratory hypotheses via preregistration of studies, and to provide data for re-use by peer researchers. Addressing the neuroimaging community directly with an online survey, this project aims to give an overview of how much researchers commit to current open science practices.
This github project provides materials, code and data acquired for and developed for this project.
_____________________________________________________________________________________________________________________________________________

## Content
 
This directory contains:

	- Four folders with R scripts
		1. Code for figures*
		2. Code for follow up analyses (Bayesian Factor, Factoranalysis and Significance Testing) 
		3. Code to analyze demographic data (country of residence, sample descriptives) 
		4. Code to import data 
	- The datafile "rdata_open-science-practices_2021-01-25_18-48" comprising the surveydata gathered via socisurvey
	- A pdf of the questionnaire (OSQ.pdf)
	- This README file with instructions	
	

## How to get started

	1. Download repository by clicking "Download ZIP" under "Code". 
	2. Open ZIP folder on your Computer. 
	3. Open "Code to import data".
	4. Open R-Script "import_open-science-practices_2021_02_26_12-20.r" and execute the whole script.
	5. A dialogue window opens. Choose the data frame to import by clicking on file "rdata_open-science-practices_2021_02_26_12-20.csv".
	6. The data frame called "OSQ_daten" should be in R's global environment.
	7. Open the R Script that you want to use to produce plots or analyze the data.

## Further information

	- Code for producing plots is named the following way: "OSQ_XX", where "XX" is the abbreviation of the respective question category*
	- Gender information has been removed from the published dataset to protect the privacy of the survey participants.
	
	
## *Abbreviations of question categories
		--> GQ = General Questions
		--> BI = BIDS
		--> PR = Preregistration
		--> DS = Data Sharing
		--> NA = Neuroimaging Data Analysis Software
		--> SP = Stimulus Presentation Software
		--> PD = Participant Demographics/ Sociodemographic Information