# rds files parameters

* Data/ignition_prob.rds -- Ignition probability estimated from MODIS

* Data/Estimated_bF.csv -- Ignition probability for NetLogo simulations

* Data/EstimatedGam_bF.csv -- Gam Estimated ingnition probability for the period with MODIS data 

* Data/Predicted_bF_rcp85.csv -- GAM estimated ignition probability using CMIP5 RCP8.5 up to 2060

* Data/Predicted_bF_rcp45.csv -- GAM estimated ignition probability using CMIP5 RCP4.5 up to 2060

* Data/TerraClimatePrAmazonas.csv -- Actual historical data for average max temp and total precipitation for Amazonas

* Data/GDPP_rcp45_Amazon.csv -- Predicted CMIP5 RCP4.5 data for average max temp and total precipitation for Amazonas

* Data/GDPP_rcp85_Amazon.csv -- Predicted CMIP5 RCP8.5 data for average max temp and total precipitation for Amazonas

* Data/patch_size_BurnedArea_Amazon.rds -- Patch sizes from monthly MODIS data

* Data/patch_dfp_BurnedArea_Amazon.rds -- Fitted parameters patch size distributions from data by period = Annual

* Data/patch_sizes_p_BurnedArea_Amazon.rds -- patch size distributions from data by period = Annual

* Simulations/best_Amazon20yearsTot_lhs.rds -- Posterior from first ABC comparing monthly fire size 

	

* Simulations/fittedExponentsAmazon21post.rds -- Posterior of parameters after ABC for fire time series -

* Simulations/bestFittedExponentsAmazon21yearsPost.rds -- Posterior of parameters after ABC selection for power law exponent 

* simExponentsAmazonPostTheta300.rds -- Calculation of power law exponents for a sample of 100 posteriors after ABC selection for power-law exponents with data estimated bF (ignition probability).

* simExponentsAmazonPostfittedBF.rds -- Same as previous with GAM estimated bF


# csv simulation files

* Base path = /home/leonardo/Academicos/GitProjects/fireNL

* Data/Estimated_bF.csv -- Estimated fire ignition probability from MODIS

* 

* Amazon20years450newNorm1_lhs.csv Amazon20years450newNorm2_lhs.csv Amazon20years450newNorm3_lhs.csv Amazon20years450newNorm4_lhs.csv
  Amazon20years450newNorm5_lhs.csv Amazon20years450newNorm6_lhs.csv -- Simulations for initial ABC 

* Amazon20years450Post100_distinct.csv Amazon20years450Post150_distinct.csv Amazon20years450Post200_distinct.csv
  Amazon20years450Post250_distinct.csv Amazon20years450Post300_distinct.csv -- Simulations from posterior of first ABC fitting fire time series 

* Amazon21years449postTheta300_distinct.csv

		Simulations using 100 posterior from bestFittedExponentsAmazon21yearsPost.rds 

* Amazon21years449PostfittedBF_distinct.csv

		Simulations using 100 posterior from bestFittedExponentsAmazon21yearsPost.rds with GAM estimated bF

* Amazon59years449PostRcp45_distinct.csv

		Simulations using 100 posterior from bestFittedExponentsAmazon21yearsPost.rds with RCP 4.5 GAM estimated bF
