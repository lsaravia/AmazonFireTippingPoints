---
title: "Supplementary Information"
subtitle: "Modelling Amazon fire regimes under climate change scenarios"    
output: 
urlcolor: blue
---
# Supplementary Information

## Estimation of increments in the probability of ignition after the fitted period due to deforestation 

We make the assumption that the fitted parameters result from an average of two distinct types of vegetation: the first type represents vegetation that regrows rapidly after deforestation, characterized by swift recovery and growth, leading to a higher parameter $p$. On the other hand, the second type represents the original forest, which exhibits slow recovery, resulting in a lower $p$. Additionally, Following deforestation, the regrown vegetation in these areas tends to be more flammable than the original forest due to increased dryness [@Cardil2020]. Human-disturbed regions often exhibit higher susceptibility to fires compared to undisturbed forests [@Aragao2018;@Cochrane2001]. This leads to a higher value for $f$.  By fitting the model with both types of vegetation, we can assume that the average $\theta = p/f$ remains constant. This assumption allows us to calculate the variations in both $p$ and $f$.

Following [@Lovejoy2018] estimation let's assume that 20% of the amazon forest is deforested and that a quarter of this area, a global 5% burns annually. This is a very conservative assumption, if we would assume a greater proportion the effect would also be greater. Thus the estimated probability of burned forest growth ($p_{\text{estimated}}$) is calculated as the weighted mean of the deforested vegetation and the original forest. 

$p_{\text{estimated}} = 0.05 \times p_{\text{deforested}} + 0.95 \times p_{\text{original}}$

As we know $p_{\text{estimated}}$ with a mean value of $1/5835.70$ and we can assume that the vegetation that growths post-deforestation resembles an annual grassland, we can set $p_{\text{deforested}} = 1/365$.   
Consequently, 

$p_{\text{original}} = \frac{p_{\text{estimated}} - 0.05 \times p_{\text{deforested}}}{0.95} \approx  2.8 e-05$

please check the file "AmazonasModelFireParameted.Rmd" for the source code of the calculations.

Then we estimated a mean deforestation of 0.3% annually, from Hansen remote sensing product [@Hansen2013], so after the fitted period each year we have 0.003 increment in the proportion of forest that burns and recover annually, fixing $p_{\text{original}}$ we can estimate the variation in $p_{\text{estimated}}$ due to deforestation.

Given the assumption that $\theta = p/f$ remains constant, we can estimate the growth in $f$ attributed to deforestation. For an annual deforestation rate of 0.03%, the resulting mean increase in $f$ 1.036 per year, while $\text{Forest growth} = 1/p$ ---which is the parameter we used in the model--- has a mean decrease of 0.97 per year.
The resulting $f$ can be observed in the figure S19 for RCP 4.5 and figure S20 for RCP 8.5. 

### References 

<div id="refs"></div>


\newpage

## Amazonas monthly fires and fire size distribution

### Study Region

![Region of study: the Amazon biome](figure/AmazonasRegion.png)

### Total monthly fire size

![Total monthly fire size for the Amazon biome as a percent of the region area. Estimated with MODIS burned area product](figure/Amazon_TotSize_Month.jpg)

\newpage

### Best fitted fire size distribution

| date  | type  | 1st par.   | 2nd par.   | $x_{min}$ | AICc       | range  | Vuong p-value |
| ----: | :---- | ---------: | ---------: | ----:     | ---------: | -----: | -----------:  |
| 2001  | ln    | -1.236398  | 2.1531997  | 54        | 6950.870   | 4916   | NA            |
| 2002  | pexp  | 2.217215   | 0.0002646  | 90        | 8629.256   | 7128   | NA            |
| 2003  | pexp  | 2.169919   | 0.0005622  | 44        | 14556.177  | 4625   | NA            |
| 2004  | pexp  | 2.142637   | 0.0001151  | 66        | 13023.416  | 11254  | NA            |
| 2005  | ln    | -9.180169  | 3.5026064  | 70        | 13842.223  | 13234  | NA            |
| 2006  | pexp  | 2.041499   | 0.0002795  | 29        | 19285.119  | 3826   | NA            |
| 2007  | pl    | 2.176596   | NA         | 54        | 15042.315  | 47132  | 0.0002225     |
| 2008  | pexp  | 2.139883   | 0.0002042  | 48        | 10688.426  | 6508   | NA            |
| 2009  | pl    | 2.400407   | NA         | 45        | 8154.537   | 3117   | 0.0000001     |
| 2010  | pl    | 1.997016   | NA         | 41        | 19977.859  | 75967  | 0.0011222     |
| 2011  | pexp  | 1.954160   | 0.0001630  | 27        | 14112.897  | 10626  | NA            |
| 2012  | pexp  | 1.981832   | 0.0003285  | 25        | 17126.664  | 3515   | NA            |
| 2013  | pl    | 2.323158   | NA         | 49        | 6013.017   | 5440   | 0.0001411     |
| 2014  | ln    | -2.007573  | 2.3653178  | 30        | 12775.172  | 7516   | NA            |
| 2015  | pexp  | 2.262959   | 0.0001455  | 74        | 7857.954   | 5306   | NA            |
| 2016  | pexp  | 2.111907   | 0.0001705  | 59        | 10315.595  | 5032   | NA            |
| 2017  | pexp  | 2.035952   | 0.0000956  | 36        | 17060.737  | 10852  | NA            |
| 2018  | pl    | 2.459423   | NA         | 60        | 5837.460   | 3596   | 0.0000069     |
| 2019  | pexp  | 2.155401   | 0.0000982  | 56        | 11285.548  | 6798   | NA            |
| 2020  | pl    | 2.251879   | NA         | 86        | 8554.237   | 17718  | 0.0000654     |
| 2021  | pexp  | 2.179439   | 0.0001369  | 63        | 7183.948   | 7311   | NA            |

Table: Best fitted fire size distribution according to the minimum AICc; where ln=lognormal, pexp=power law with exponential cut-off, pl=power-law, and exp=exponential; 1st par is the first parameter of the distribution (the exponent for power-law) and 2nd par the second parameter; $x_{min}$ is the minimum cluster size estimated for the power-law distribution (in number of pixels); range is the max cluster size minus $x_{min}$. The power-law distributions are also compared with the exponential distribution using the Vuong's test. 	

### Inverse cumulative distribution of fire clusters 2003 - 2008

![Inverse cumulative distribution of fire clusters sizes and fitted distributions for the years 2003 - 2008. Only the year 2007 corresponds to a power-law with a large range value](figure/Amazon_PatchDistr_2003-2008.png)\ 

### Inverse cumulative distribution of fire clusters 2009 - 2014

![Inverse cumulative distribution of fire clusters sizes and fitted distributions for the years 2009 - 2014. The year 2010 corresponds to a power-law with large range, and the years 2009 and 2013 are power-laws with a smaller range](figure/Amazon_PatchDistr_2009-2014.png)\ 

### Inverse cumulative distribution of fire clusters 2015 - 2020

![Inverse cumulative distribution of fire clusters sizes and fitted distributions for the years 2015 - 2020. The year 2020 corresponds to a power-law with large range, and the year 2018 is a power-law with a smaller range](figure/Amazon_PatchDistr_2015-2020.png)\ 

\newpage

## Generalized Additive Models of ignition probability 


| Model                   | df         | AIC       | deltaAIC    | Mean MAE  | Mean RMSE |
| :-------                | ---------: | --------: | ----------: | --------: | --------: |
| Gaussian                |            |           |             |           |           |
|                         |            |           |             |           |           |
| $T^{max}_m * m$         | 17.901944  | 379.5824  | 0.000000    | 3.14e-05  | 5.15e-05  |
| $T^{max}_{m-1} * m$     | 16.977377  | 386.8289  | 7.246554    | 3.20e-05  | 5.24e-05  |
| $T^{max}_m * ppt_{m-1}$ | 9.609532   | 440.4861  | 60.903732   | 3.62e-05  | 5.89e-05  |
|                         |            |           |             |           |           |
| Gamma                   |            |           |             |           |           |
|                         |            |           |             |           |           |
| $T^{max}_m * m$         | 18.174422  | -4602.520 | 0.00000     | 3.46e-05  | 5.61e-05  |
| $T^{max}_{m-1} * m$     | 17.951004  | -4577.101 | 25.41951    | 3.63e-05  | 5.84e-05  |
| $T^{max}_m * ppt_{m-1}$ | 13.878660  | -4498.440 | 104.08041   | 4.13e-05  | 6.58e-05  |
|                         |            |           |             |           |           |

Table: Generalized additive models (GAMs) using a Gaussian and Gamma distributions. Terms and comparisons using the Akaike criterion, and the mean absolute error (MAE) of predictions of the ignition probability $f$ leaving out different portions of data as explained in main text. Where we have the following monthly variables: $T^{max}_{m}$ is the maximum temperature for the actual month, $ppt_{m}$ monthly accumulated precipitation of the actual month, $ppt_{m-1}$ same as $ppt_{m}$ from the previous month, and $m$ is a seasonal term representing the actual month. To see the complete set of tried models please check the source code 'AmazonasModelFireParameters.Rmd'

### Model check for the best GAM model

![Model check for the best GAM model of ignition probability $bF \sim T^{max}_m * m$ ](figure/Amazon_bF_GAMcheck_tmmx_month.jpg)\ 

### Comparison of predicted $f$ vs MODIS data $f$ 

![Comparison of the predictions of the probability of ignition by the best GAM model $f \sim T^{max}_m * m$ (black line), 95% confidence interval (grey band) and $f$ data (dots) for the whole period 2001-2021](figure/Amazon_bF_prediction.jpg)\ 

![Predictions of the probability of ignition by the best GAM model $f \sim T^{max}_m * m$ using as training data the years < 2018, 95% confidence interval (grey band) and $f$ data (dots)](figure/Amazon_bF_prediction2018-2021.jpg)\ 

### Time series of $f$ used in simulations of the fire model

![Complete time series of the monthly ignition probability $f$ used in simulations up to 2060, with 95% confidence intervals (grey band). The values before 2021 are based on actual data, while those after 2021 are predicted by the best GAM model using General Circulation Model (GCM) runs from the Coupled Model Intercomparison Project Phase 5 (CMIP5) for the RCP 4.5 and RCP 8.5 greenhouse gas emissions scenarios.](figure/Amazon_bF_RCP_monthly.png)\ 

![Complete time series of the monthly ignition probability $f$ used in simulations up to 2060, with 95% confidence intervals (grey band), predicted by the best GAM model using General Circulation Model (GCM) runs from the Coupled Model Intercomparison Project Phase 5 (CMIP5) for the RCP 4.5 greenhouse gas emissions scenario. Retrospective model runs were used for the period before 2006.](figure/Amazon_bF_RCP_GCM_monthly.png)\ 


### Time series of $f$ used in simulations of the fire model including deforestation

![Complete time series predictions of the probability of ignition $f$ up to 2060 in black, with increased $f$ due to deforestation after 2021 in green,  95% confidence interval (grey band), before 2021 using the actual data, and after using General Circulation Models (GCM) runs conducted under the Coupled Model Intercomparison Project Phase 5 (CMIP5) for the greenhouse gas emissions scenario RCP4.5](figure/Amazon_bF_RCP4.5_Deforested.png)


![Complete time series predictions of the probability of ignition $f$ up to 2060 in black, with increased $f$ due to deforestation after 2021 in green,  95% confidence interval (grey band), before 2021 using the actual data, and after using General Circulation Models (GCM) runs conducted under the Coupled Model Intercomparison Project Phase 5 (CMIP5) for the greenhouse gas emissions scenario RCP8.5](figure/Amazon_bF_RCP8.5_Deforested.png)


<!-- Names of the CMIP5 models:  'ACCESS1-0', 'bcc-csm1-1', 'BNU-ESM', 'CanESM2', 'CCSM4', 'CESM1-BGC', 'CNRM-CM5', 'CSIRO-Mk3-6-0', 'GFDL-CM3', 'GFDL-ESM2G', 'GFDL-ESM2M', 'inmcm4', 'IPSL-CM5A-LR', 'IPSL-CM5A-MR', 'MIROC-ESM', 'MIROC-ESM-CHEM', 'MIROC5', 'MPI-ESM-LR', 'MPI-ESM-MR', 'MRI-CGCM3', 'NorESM1-M'. -->

\newpage


## Forest fire Model exploration 

### Forest fire Model exploration parameters

| $de$      | $f$        | $\theta$   |
| --------: | ---------: | ---------: |
| 102       | 2e-07      | 2500       |
| 2.0155    | 2e-06      | 250        |
|           | 2e-05      | 25         |
|           |            |            |

Table: We ran an in-silico experiment using a factorial combination of dispersal exponent $de$ and $\theta$ and 10 repetitions of each parameter set. First we ran the experiment with $\theta$ fixed, keeping the ignition probability $f$ constant, then we repeated the experiment with seasonality: we simulate a fire season of 3 months each year multiplying $f$  by 10. The dispersal exponent $de=101$ is equivalent to a dispersal to the nearest neighbours, and $de=2.0155$ corresponds to a mean dispersal distance of 66 sites.

### Forest fire Model exploration: Fire cluster size distributions 

| Dispersal distance         | $\theta$ | Seasonality | Distr. type | n    | range    | mean fire cluster | exponent | freq  |
| -------------------------: | -----:   | :--------   | :----       | ---: | -------: | ----------:       | ----:    | ----: |
| 1                          | 25       | fixed       | exp         | 8    | 25.62    | 1.64              | 0.00     | 0.02  |
| 1                          | 25       | fixed       | ln          | 317  | 24.12    | 1.18              | 0.00     | 0.92  |
| 1                          | 25       | fixed       | pexp        | 2    | 41.50    | 1.66              | 0.00     | 0.01  |
| 1                          | 25       | fixed       | pl          | 16   | 22.19    | 1.33              | 5.27     | 0.05  |
| 1                          | 25       | seasonal    | exp         | 38   | 2.16     | 1.05              | 0.00     | 0.12  |
| 1                          | 25       | seasonal    | ln          | 97   | 7.62     | 1.06              | 0.00     | 0.31  |
| 1                          | 25       | seasonal    | pexp        | 62   | 3.03     | 1.05              | 0.00     | 0.20  |
| 1                          | 25       | seasonal    | pl          | 111  | 7.02     | 1.06              | 4.80     | 0.36  |
| 1                          | 250      | fixed       | exp         | 145  | 108.66   | 7.19              | 0.00     | 0.36  |
| 1                          | 250      | fixed       | ln          | 60   | 128.02   | 5.09              | 0.00     | 0.15  |
| 1                          | 250      | fixed       | pexp        | 33   | 206.39   | 9.30              | 0.00     | 0.08  |
| 1                          | 250      | fixed       | pl          | 162  | 173.04   | 7.50              | 2.61     | 0.41  |
| 1                          | 250      | seasonal    | exp         | 86   | 57.09    | 3.01              | 0.00     | 0.22  |
| 1                          | 250      | seasonal    | ln          | 230  | 58.43    | 1.82              | 0.00     | 0.58  |
| 1                          | 250      | seasonal    | pexp        | 17   | 98.53    | 3.75              | 0.00     | 0.04  |
| 1                          | 250      | seasonal    | pl          | 67   | 77.57    | 3.01              | 3.04     | 0.17  |
| 1                          | 2500     | fixed       | exp         | 32   | 348.44   | 69.84             | 0.00     | 0.10  |
| 1                          | 2500     | fixed       | ln          | 1    | 509.00   | 39.74             | 0.00     | 0.00  |
| 1                          | 2500     | fixed       | pexp        | 7    | 601.00   | 95.54             | 0.00     | 0.02  |
| 1                          | 2500     | fixed       | pl          | 274  | 496.92   | 57.95             | 1.66     | 0.87  |
| 1                          | 2500     | seasonal    | exp         | 121  | 206.40   | 21.09             | 0.00     | 0.31  |
| 1                          | 2500     | seasonal    | ln          | 88   | 202.06   | 12.47             | 0.00     | 0.22  |
| 1                          | 2500     | seasonal    | pexp        | 11   | 531.45   | 32.41             | 0.00     | 0.03  |
| 1                          | 2500     | seasonal    | pl          | 176  | 352.80   | 22.23             | 2.04     | 0.44  |
| 66                         | 25       | fixed       | ln          | 175  | 62.31    | 3.02              | 0.00     | 0.44  |
| 66                         | 25       | fixed       | pexp        | 223  | 54.73    | 3.02              | 0.00     | 0.56  |
| 66                         | 25       | fixed       | pl          | 2    | 73.00    | 3.13              | 3.21     | 0.00  |
| 66                         | 25       | seasonal    | ln          | 245  | 13.20    | 1.17              | 0.00     | 0.61  |
| 66                         | 25       | seasonal    | pl          | 155  | 10.47    | 1.09              | 4.24     | 0.39  |
| 66                         | 250      | fixed       | ln          | 15   | 700.53   | 25.09             | 0.00     | 0.04  |
| 66                         | 250      | fixed       | pexp        | 367  | 575.78   | 31.16             | 0.00     | 0.92  |
| 66                         | 250      | fixed       | pl          | 18   | 702.17   | 32.13             | 2.25     | 0.04  |
| 66                         | 250      | seasonal    | ln          | 3    | 197.33   | 7.88              | 0.00     | 0.01  |
| 66                         | 250      | seasonal    | pexp        | 391  | 204.34   | 10.19             | 0.00     | 0.98  |
| 66                         | 250      | seasonal    | pl          | 6    | 192.00   | 9.71              | 2.99     | 0.01  |
| 66                         | 2500     | fixed       | exp         | 6    | 491.67   | 178.34            | 0.00     | 0.02  |
| 66                         | 2500     | fixed       | pexp        | 62   | 2488.13  | 304.06            | 0.00     | 0.16  |
| 66                         | 2500     | fixed       | pl          | 323  | 2373.03  | 230.37            | 1.42     | 0.83  |
| 66                         | 2500     | seasonal    | exp         | 2    | 484.00   | 95.45             | 0.00     | 0.00  |
| 66                         | 2500     | seasonal    | ln          | 4    | 1606.75  | 97.42             | 0.00     | 0.01  |
| 66                         | 2500     | seasonal    | pexp        | 227  | 1355.47  | 100.56            | 0.00     | 0.57  |
| 66                         | 2500     | seasonal    | pl          | 167  | 1389.70  | 86.98             | 1.51     | 0.42  |

Table: Fire cluster size distributions of the fire model with different parameters, and with or without seasonality.  The best fitted fire size distribution was selecting according to the minimum AICc; where ln=lognormal, pexp=power-law with exponential cut-off, pl=power-law, and exp=exponential; *n* is the number of cases and *freq* is the frequency of a particular distribution for the combination of parameters ; *range* is the max cluster size minus $x_{min}$ (in number of pixels).

\newpage

### Forest fire Model exploration: power-law fire distribution

| Dispersal distance         | Seasonality | $\theta$ | n    | iqr   | range    | exponent | freq  |
| -------------------------: | :--------   | -----:   | ---: | ----: | -------: | ----:    | ----: |
| 1                          | fixed       | 25       | 1    | 0.00  | 42.00    | 3.36     | 0.06  |
| 1                          | fixed       | 250      | 3    | 0.33  | 203.00   | 2.30     | 0.02  |
| 1                          | fixed       | 2500     | 154  | 0.26  | 337.08   | 1.63     | 0.56  |
| 1                          | seasonal    | 25       | 36   | 0.12  | 11.00    | 4.60     | 0.32  |
| 1                          | seasonal    | 2500     | 7    | 0.52  | 687.00   | 2.09     | 0.04  |
| 66                         | fixed       | 250      | 2    | 0.06  | 780.00   | 1.68     | 0.11  |
| 66                         | fixed       | 2500     | 141  | 0.15  | 1135.05  | 1.43     | 0.44  |
| 66                         | seasonal    | 25       | 155  | 0.21  | 10.47    | 4.24     | 1.00  |
| 66                         | seasonal    | 250      | 1    | 0.00  | 312.00   | 2.44     | 0.17  |
| 66                         | seasonal    | 2500     | 99   | 0.10  | 1109.79  | 1.48     | 0.59  |

Table: Frequency of Fire cluster size distribution of the fire model with true power-law (Vuong's test p-value < 0.05) for different parameters, and with or without seasonality.  Where *n* is the number of cases and *freq* is the frequency of a particular distribution for the combination of parameters ; *iqr* is the interquartil range (a measure of variability) and exponent is the median exponent.

### Forest fire Model exploration: density of the forest state

![Density of Forest obtained of Fire model simulations, measured at the last day of the year. The parameter $\theta$ was kept constant for **A** & **B** and dispersal exponent was $de=102$ (equivalent to nearest neighbours) and $de=2.0155$ respectively. **C** & **D**  are simulations with fire season where $\theta$ was divided by 10 during 3 months, which is the equivalent of multiplying the ignition probability $f$ by 10, with the same values for the dispersal exponent($de=102$ and $2.0155$)](figure/FireNL_ForestPercent_dispersal_theta_season.png)

### Forest fire Model exploration: spatial patterns

![Spatial pattern of the forest fire model simulations with constant $\theta$. This shows the spatial state of the model after 40 years where, green colour is the forest state, brown is the burned state, and red are the active fires. **A** & **B** correspond to $\theta = 2500$ and dispersal exponent $de=102$ (equivalent to nearest neighbours) and $de=2.0155$. **C** & **D** Are simulations with $\theta=25$ and the same values for the dispersal exponent($de=102$ and $2.0155$).  ](figure/FireNL_450_theta25-2500_de102-20155_noseason.png)


![Spatial pattern of the forest fire model simulations with fire season where $\theta$ was divided by 10 during 3 months, which is the equivalent of multiplying the ignition probability $f$ by 10. This shows the spatial state of the model after 40 years where, green colour is the forest state, brown is the burned state, and red are the active fires. **A** & **B** correspond to $\theta = 2500$ and dispersal exponent $de=102$ (equivalent to nearest neighbours) and $de=2.0155$. **C** & **D** Are simulations with $\theta=25$ and the same values for the dispersal exponent($de=102$ and $2.0155$).](figure/FireNL_450_theta25-2500_de102-20155_season90.png)

\newpage


## Forest fire model fitting 

### Summary of first ABC model selection

| Name          | Initial forest density  | Dispersal distance         | Forest growth $(1/p)$  |
| :------------ | ----------------------: | -------------------------: | -------------: |
| 2.5 % Perc.   | 0.0763                  | 81.7156                    | 4807.227       |
| Mean          | 0.2714                  | 121.0560                   | 5887.786       |
| Median        | 0.2739                  | 122.5313                   | 5842.389       |
| 97.5 % Perc.  | 0.4910                  | 151.4867                   | 6996.803       |


Table: Summary of the first ABC posterior parameter distribution. This uses the annual maximum monthly fire size to select the 0.05% of the best parameters.

### MODIS estimated fires vs simulations

![Monthly total MODIS estimated fire size (black line) and 95% percentiles of simulations (shade) of monthly fire time series using the fitted parameters (See table S6)](figure/Amazon_maxyear_PI95_450.png)\ 

![Ten simulations of monthly fire time series using one set of the fitted parameters of the fire model (See table S6), the black line is the MODIS data. The parameters used are Initial forest density = 0.2, Dispersal distance = 83.41, Forest growth =  5004.71](figure/Amazon_maxyear_fitted_450.png)\ 

![Total annual fires, predicted vs data using the first ABC posterior parameters](figure/Amazon_maxyear_dataVsPredicted_450.png)\ 

### Final ABC model selection

| Name          | Initial forest density  | Dispersal distance         | Forest_growth $(1/p)$ | Fire Size Power Law Exponent |
| :------------ | ----------------------: | -------------------------: | -------------:        | ---------------------------: |
| 2.5 % Perc.   | 0.0192                  | 76.0916                    | 4781.407              | 1.73                         |
| Mean          | 0.2706                  | 119.5919                   | 5835.700              | 2.83                         |
| Median        | 0.2759                  | 121.9571                   | 5809.553              | 2.73                         |
| 97.5 % Perc.  | 0.5944                  | 149.8876                   | 6840.369              | 4.94                         |

Table: Summary of the second ABC posterior parameter distribution. We selected the model parameters with the median power law exponent $\alpha$ of the fire size distribution  closer to the median of the data (2.29). The summary of the power law exponent of fire size patch distribution is showed in the last column.


![Power-law exponents versus parameters after the second ABC compared with the median power-law exponent from MODIS burned area product (red dashed line)](figure/Amazon_2ndABC_post_params.png)\ 


\newpage

## Forest Fire model predictions

### Flammable Forest state of the model for RCP 4.5 and 8.5

![Flammable Forest state of the model vs time using the ignition probability calculated with data from General Circulation Models under two greenhouse gas emissions scenarios known as Representative Concentration Pathways (RCPs), RCP4.5 and RCP8.5. Here we show the median and the 95% percentile based on the fitted parameter distribution.](figure/Amazon_ForestPercent_theta61_RCP45-85.png)\ 


### Annual fire size vs maximum for RCP 8.5

![Total annual size of fires vs maximum monthly fire size % relative to the area of the region, data, predictions and predictions including deforestation. The data column was estimated using the MODIS burned area product. The predictions by decade were estimated with a fitted model using a monthly ignition probability calculated with data from General Circulation Models under two greenhouse gas emissions scenarios known as Representative Concentration Pathways (RCPs), here only RCP8.5. For the years 2001-2021 the ignition probability was estimated from actual data.](figure/Amazon_TotSizeVsMax_year_theta61_RCP85_Def.png)\ 


### Fire model prediccions for $f$ estimated with TerraClimate vs $f$ estimated with CGM RCP 4.5

![Time series of fire model predictions without deforestation, compared with observed data. Ignition probability was derived from GAM models based on Terra Climate data before 2022 (upper) and General Circulation Models under Representative Concentration Pathways (RCP) 4.5 plus retrospective simulations before year 2006 (lower panel). After 2021, both panels use GCM models to estimate ignition probability. The vertical dashed line marks the division between periods before and after 2021. Data points represent actual observations, while the solid line indicates the median of the simulations, with 95% confidence interval bands. All outputs are presented relative to the total area.](figure/Amazon_TotSize_year_theta61_RCP45-NoTerra.png)
