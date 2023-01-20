# Amazonas fire regimes under climate change scenarios

[![DOI](https://zenodo.org/badge/384492461.svg)](https://zenodo.org/badge/latestdoi/384492461)


* Code and Data for the paper

Saravia, L., Bond-Lamberty, B., & Suweis, S. (2021). Amazon fire regimes under climate change scenarios. EcoEvoRxiv. https://doi.org/10.32942/osf.io/nr23w



## R Markdown files description


* AmazonasClusterSizeDistribution.Rmd :

	Estimation of monthly forest fires from modis data fire cluster size distribution, 
	incluing analysis of Empirical dynamic modelling, ( Sugihara et al. 2012. Detecting causality in complex ecosystems.Science, 338: 496–500) not used in the paper.

* AmazonasModelFireParameters.Rmd

	From fire clusters size estiamate the ignition probability and GAM modelling for maxtemp and precipitation using RCP 4.5 & 8.5

* AmazonasFitNetLogo.Rmd: 

	Using the DynamicFireForest.nlogo model at <https://github.com/lsaravia/FireNL> make latin hypercubic sampling to fit the model and make predictions up to 2060

* FireNLsimulations.Rmd

	Exploratory simulations of the DynamicFireForest.nlogo model 

* R/test_ABC.R  

  Validation of the use of  max_total_patch (Anual maximum of monthly fire size) for parameter estimation with ABC
  
## Folders

	| 
	+--- R: R code by L. Saravia
  |
  +--- Source: Google Earth Engine Code to download the MODIS, Climaterra and NEX-GDDP CMIP5 proyections.
  |
  +--- Data: Saved R data with simulations, Fire, and Climate. (Attached in Release)


