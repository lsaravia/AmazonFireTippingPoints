# Amazonas fire regimes under climate change scenarios



* Data readed from MODIS files and simulations 

## R Markdown files description

  AmazonasFitNetLogo.Rmd           ClusterSizeDistribution_old.Rmd  ModelFireParameters_old.Rmd                presentationWSC.Rmd
AmazonasFitNetLogo_old.Rmd           AmazonasModelFireParameters.Rmd  FireNLsimulations.Rmd            NABorealForestClusterSizeDistribution.Rmd  results.Rmd


* AmazonasClusterSizeDistribution.Rmd :

		Estimation of monthly forest fires from modis data fire cluster size distribution, 
		incluing analysis of Empirical dynamic modelling, ( Sugihara et al. 2012. Detecting causality in complex ecosystems.Science, 338: 496–500) not used in the paper.

* AmazonasModelFireParameters.Rmd

		From fire clusters size estiamate the ignition probability and GAM modelling for maxtemp and precipitation using RCP 4.5 & 8.5

* AmazonasFitNetLogo.Rmd: 

		Using the DynamicFireForest.nlogo model at <https://github.com/lsaravia/FireNL> make latin hypercubic sampling to fit the model and make predictions up to 2060

* FireNLsimulations.Rmd

		Exploratory simulations of the DynamicFireForest.nlogo model 

## Folders

	| 
	+--- R: R code by L. Saravia
    |
    +--- Source: Google Earth Engine Code to download the MODIS, Climaterra and NEX-GDDP CMIP5 proyections.
    |
    +--- Data: Saved R data with simulations, Fire, and Climate. (Attached in Release)


