# Supplementary Information

## Amazonas monthly fires and fire size distribution

![Region of study: the Amazon Basin](figure/AmazonasRegion.png)

![Total monthly fire size for the Amazon basin as a percent of the region area. Estimated with MODIS burned area product](figure/Amazon_TotSize_Month.jpg)

\newpage

| date  | type  | 1st par.   | 2nd par.   | $x_{min}$ | AICc       | range  | Vuong p-value |
| ----: | :---- | ---------: | ---------: | ----:     | ---------: | -----: | -----------:  |
| 2001  | ln    | -1.236398  | 2.1531997  | 54        | 6950.870   | 4916   | 0.0029987     |
| 2002  | pexp  | 2.217215   | 0.0002646  | 90        | 8629.256   | 7128   | 0.0000675     |
| 2003  | pexp  | 2.169919   | 0.0005622  | 44        | 14556.177  | 4625   | 0.0000009     |
| 2004  | pexp  | 2.142637   | 0.0001151  | 66        | 13023.416  | 11254  | 0.0000000     |
| 2005  | ln    | -9.180169  | 3.5026064  | 70        | 13842.223  | 13234  | 0.0000000     |
| 2006  | pexp  | 2.041499   | 0.0002795  | 29        | 19285.119  | 3826   | 0.0000000     |
| 2007  | pl    | 2.176596   | NA         | 54        | 15042.315  | 47132  | 0.0002225     |
| 2008  | pexp  | 2.139883   | 0.0002042  | 48        | 10688.426  | 6508   | 0.0000000     |
| 2009  | pl    | 2.400407   | NA         | 45        | 8154.537   | 3117   | 0.0000001     |
| 2010  | pl    | 1.997016   | NA         | 41        | 19977.859  | 75967  | 0.0011222     |
| 2011  | pexp  | 1.954160   | 0.0001630  | 27        | 14112.897  | 10626  | 0.0000000     |
| 2012  | pexp  | 1.981832   | 0.0003285  | 25        | 17126.664  | 3515   | 0.0000000     |
| 2013  | pl    | 2.323158   | NA         | 49        | 6013.017   | 5440   | 0.0001411     |
| 2014  | ln    | -2.007573  | 2.3653178  | 30        | 12775.172  | 7516   | 0.0000675     |
| 2015  | pexp  | 2.262959   | 0.0001455  | 74        | 7857.954   | 5306   | 0.0000031     |
| 2016  | pexp  | 2.111907   | 0.0001705  | 59        | 10315.595  | 5032   | 0.0000000     |
| 2017  | pexp  | 2.035952   | 0.0000956  | 36        | 17060.737  | 10852  | 0.0000000     |
| 2018  | pl    | 2.459423   | NA         | 60        | 5837.460   | 3596   | 0.0000069     |
| 2019  | pexp  | 2.155401   | 0.0000982  | 56        | 11285.548  | 6798   | 0.0000000     |
| 2020  | pl    | 2.251879   | NA         | 86        | 8554.237   | 17718  | 0.0000654     |
| 2021  | pexp  | 2.179439   | 0.0001369  | 63        | 7183.948   | 7311   | 0.0000021     |

Table: Best fitted fire size distribution according to the minimum AICc; where ln=lognormal, pexp=power law with exponential cut-off, pl=power-law, and exp=exponential; 1st par is the first parameter of the distribution (the exponent for power-law) and 2nd par the second parameter; $x_{min}$ is the minimum cluster size estimated for the power-law distribution (in number of pixels); range is the max cluster size minus $x_{min}$. The power-law distributions are also compared with the exponential distribution using the Vuong's test. 	

![Inverse cumulative distribution of fire clusters sizes and fitted distributions for the years 2003 - 2008. Only the year 2007 corresponds to a power-law with a large range value](figure/Amazon_PatchDistr_2003-2008.png)

![Inverse cumulative distribution of fire clusters sizes and fitted distributions for the years 2009 - 2014. The year 2010 corresponds to a power-law with large range, and the years 2009 and 2013 are power-laws with a smaller range](figure/Amazon_PatchDistr_2009-2014.png)

![Inverse cumulative distribution of fire clusters sizes and fitted distributions for the years 2015 - 2020. The year 2020 corresponds to a power-law with large range, and the year 2018 is a power-law with a smaller range](figure/Amazon_PatchDistr_2015-2020.png)

\newpage

## Generalized Additive Models of ignition probability 


| Model             | df         | AIC       | Delta AIC | MAPE  |
| :------           | ---------: | --------: | --------: | ----: |
| $T_{max} * m$     | 22.096028  | 373.8128  | 0.000     | 54.5  |
| $T_{max} * ppt-1$ | 9.878829   | 424.2198  | 50.407    | 56.8  |
| $T_{max} * ppt$   | 12.341762  | 460.4303  | 86.617    | 57.0  |
| $ppt -1$          | 5.797506   | 461.9405  | 88.127    |       |
| $T_{max}$         | 7.642891   | 468.5340  | 94.721    |       |
| $ppt$             | 5.639345   | 550.8326  | 177.019   |       |

Table: Generalized additive models (GAMs) terms and comparison using the Akaike criterion, and the mean absolute percentage error (MAPE) of predictions. Where we have the following monthly variables: $T_{max}$ is the maximum temperature, $ppt$ accumulated precipitation, $ppt-1$ same as ppt from the previous month, and $m$ is a seasonal term representing the actual month.

![Model check for the best GAM model of ignition probability $bF \sim T_{max} + m$ ](figure/Amazon_bF_GAMcheck_tmmx_month.jpg)


![Comparison of the predictions of the probability of ignition by the best GAM model $f \sim T_{max} * m$ (black line) with $f$ data (dots) for the whole period 2001-2021](figure/Amazon_bF_prediction.jpg)

![Predictions of the probability of ignition by the best GAM model $f \sim T_{max} * m$ using as training data the years < 2018](figure/Amazon_bF_prediction2018-2021.jpg)

![Predictions of the probability of ignition $f$ up to 2060 using General Circulation Models (GCM) runs conducted under the Coupled Model Intercomparison Project Phase 5 (CMIP5) for the greenhouse gas emissions scenario RCP4.5](figure/Amazon_bF_RCP4.5.png)

![Predictions of the probability of ignition $f$ up to 2060 using General Circulation Models (GCM) runs conducted under the Coupled Model Intercomparison Project Phase 5 (CMIP5) for the greenhouse gas emissions scenario RCP8.5](figure/Amazon_bF_RCP8.5.png)

<!-- Names of the CMIP5 models:  'ACCESS1-0', 'bcc-csm1-1', 'BNU-ESM', 'CanESM2', 'CCSM4', 'CESM1-BGC', 'CNRM-CM5', 'CSIRO-Mk3-6-0', 'GFDL-CM3', 'GFDL-ESM2G', 'GFDL-ESM2M', 'inmcm4', 'IPSL-CM5A-LR', 'IPSL-CM5A-MR', 'MIROC-ESM', 'MIROC-ESM-CHEM', 'MIROC5', 'MPI-ESM-LR', 'MPI-ESM-MR', 'MRI-CGCM3', 'NorESM1-M'. -->

\newpage


### Forest fire Model exploration 

| $de$      | $f$        | $\theta$   |
| --------: | ---------: | ---------: |
| 102       | 2e-07      | 2500       |
| 2.0155    | 2e-06      | 250        |
|           | 2e-05      | 25         |
|           |            |            |

Table: We ran an in-silico experiment using a factorial combination of dispersal exponent $de$ and $\theta$ and 10 repetitions of each parameter set. First we ran the experiment with $\theta$ fixed, keeping the ignition probability $f$ constant, then we repeated the experiment with seasonality: we simulate a fire season of 3 months each year multiplying $f$  by 10. The dispersal exponent $de=101$ is equivalent to a dispersal to the nearest neighbours, and $de=2.0155$ corresponds to a mean dispersal distance of 66 sites.



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


![Density of Forest obtained of Fire model simulations, measured at the last day of the year. The parameter $\theta$ was kept constant for **A** & **B** and dispersal exponent was $de=102$ (equivalent to nearest neighbours) and $de=2.0155$ respectively. **C** & **D**  are simulations with fire season where $\theta$ was divided by 10 during 3 months, which is the equivalent of multiplying the ignition probability $f$ by 10, with the same values for the dispersal exponent($de=102$ and $2.0155$)](figure/FireNL_ForestPercent_dispersal_theta_season.png)

![Spatial pattern of the forest fire model simulations with constant $\theta$. This shows the spatial state of the model after 40 years where, green colour is the forest state, brown is the burned state, and red are the active fires. **A** & **B** correspond to $\theta = 2500$ and dispersal exponent $de=102$ (equivalent to nearest neighbours) and $de=2.0155$. **C** & **D** Are simulations with $\theta=25$ and the same values for the dispersal exponent($de=102$ and $2.0155$).  ](figure/FireNL_450_theta25-2500_de102-20155_noseason.png)


![Spatial pattern of the forest fire model simulations with fire season where $\theta$ was divided by 10 during 3 months, which is the equivalent of multiplying the ignition probability $f$ by 10. This shows the spatial state of the model after 40 years where, green colour is the forest state, brown is the burned state, and red are the active fires. **A** & **B** correspond to $\theta = 2500$ and dispersal exponent $de=102$ (equivalent to nearest neighbours) and $de=2.0155$. **C** & **D** Are simulations with $\theta=25$ and the same values for the dispersal exponent($de=102$ and $2.0155$).](figure/FireNL_450_theta25-2500_de102-20155_season90.png)

\newpage


### Forest fire model fitting 




| fit method | Initial forest density  | Dispersal distance         | Forest growth $1/p$ | MAPE      | correlation |
| :-------   | ----------------------: | -------------------------: | -------------:      | --------: | ----------: |
| maxyear    | 0.3                     | 32.72                      | 6536.88             | 44.27120  | 0.6031193   |
| maxyear    | 0.3                     | 13.71                      | 5756.42             | 44.99850  | 0.5576882   |
| maxyear    | 0.3                     | 48.60                      | 6282.53             | 45.06912  | 0.5139903   |
| maxyear    | 0.3                     | 65.07                      | 6426.67             | 45.91759  | 0.5257451   |
| maxyear    | 0.3                     | 19.91                      | 7003.88             | 46.24743  | 0.6396228   |
| maxyear    | 0.3                     | 31.23                      | 5739.33             | 46.47136  | 0.5180568   |
| maxyear    | 0.3                     | 36.89                      | 6967.00             | 47.07761  | 0.5938925   |
| maxyear    | 0.3                     | 99.32                      | 6930.36             | 47.26686  | 0.5600610   |
| maxyear    | 0.3                     | 24.26                      | 6977.69             | 47.32994  | 0.6063205   |
| maxyear    | 0.3                     | 76.08                      | 7156.03             | 47.40817  | 0.6105106   |
| monthly    | 0.6                     | 57.94                      | 4446.46             | 82.44552  | -0.0042925  |
| monthly    | 0.6                     | 48.92                      | 5395.68             | 82.54614  | 0.0120322   |
| monthly    | 0.6                     | 92.54                      | 5299.42             | 82.64424  | -0.0116897  |
| monthly    | 0.6                     | 59.31                      | 4503.38             | 82.64629  | 0.0073827   |
| monthly    | 0.6                     | 58.66                      | 4683.73             | 82.73700  | -0.0029672  |
| monthly    | 0.6                     | 37.29                      | 4747.29             | 82.74801  | -0.0098299  |
| monthly    | 0.6                     | 99.80                      | 4882.64             | 82.84778  | -0.0089749  |
| monthly    | 0.6                     | 63.01                      | 5692.99             | 82.96181  | -0.0119154  |
| monthly    | 0.6                     | 36.43                      | 5213.85             | 82.99431  | 0.0019312   |
| monthly    | 0.6                     | 14.43                      | 6065.37             | 83.02749  | 0.0249054   |

Table: Ten best fitting parameters per each initial forest density (0.3 and 0.6) and two methods 1) "monthly": compares the monthly burned data against the model, 2) "maxyear": compares only the maximum of the year against the maximum of the model. To select the best parameters we use the mean percent absolute error (MAPE).

![Time series of best fitted parameters against data for the fire model, with method "maxyear", notice that this method select an initial forest density 0.3](figure/Amazon_maxyear_fitted_450.png)

![Time series of best fitted parameters against data for the fire model, with method "monthly", notice that this method select an initial forest density 0.6](figure/Amazon_monthly_fitted_450.png)

![Total annual fires, predicted vs data using the best fitted parameters with the method "maxyear"](figure/Amazon_maxyear_dataVsPredicted_450.png)


| Dispersal distance ($\alpha_{dis}$) | Forest growth $1/p$ | minimum $\alpha$ | maximum $\alpha$ | median $\alpha$ | distance | Average $\theta$ | MAPE      |
| ----------------:                   | --------:           | -------:         | -------:         | -------:        | -------: | ---------:       | --------: |
| 19.91 (2.0529)                      | 7003.88             | 1.6384           | 3.5871           | 1.7863          | 0.5037   | 90.5569          | 46.24743  |
| 13.71 (2.0787)                      | 5756.42             | 1.6631           | 2.4942           | 1.7852          | 0.5048   | 110.1812         | 44.99850  |
| 32.72 (2.0315)                      | 6536.88             | 1.6637           | 2.1172           | 1.7619          | 0.5281   | 97.0263          | 44.27120  |
| 48.60 (2.0210)                      | 6282.53             | 1.6889           | 2.1173           | 1.7603          | 0.5297   | 100.9545         | 45.06912  |
| 65.07 (2.0156)                      | 6426.67             | 1.6693           | 1.9915           | 1.7587          | 0.5313   | 98.6902          | 45.91759  |
| 31.23 (2.0331)                      | 5739.33             | 1.6586           | 2.0872           | 1.7534          | 0.5366   | 110.5093         | 46.47136  |
| 36.89 (2.0279)                      | 6967.00             | 1.6751           | 3.0893           | 1.7432          | 0.5468   | 91.0362          | 47.07761  |
| 24.26 (2.0430)                      | 6977.69             | 1.7090           | 1.8901           | 1.7419          | 0.5481   | 90.8968          | 47.32994  |
| 99.32 (2.0102)                      | 6930.36             | 1.6560           | 2.2340           | 1.7412          | 0.5488   | 91.5175          | 47.26686  |
| 76.08 (2.0133)                      | 7156.03             | 1.6593           | 1.8955           | 1.7403          | 0.5497   | 88.6315          | 47.40817  |
|                                     |                     |                  |                  |                 |          |                  |           |

Table: The ten best fitting parameters using an initial forest density of 0.3 and the "maxyear" method, which compares only the monthly maximum of the year against the model. We selected the model with the median power law exponent $\alpha$ of the fire size distribution (column median exponent) closer to the median of the data (2.29), the  distance is $|\alpha_{data} - \alpha_{model} |$ . The best model with dispersal distance 19.91 has a power law exponent for dispersal $\alpha_{dis}$ of 2.0529.


![Predictions of the Forest state of the model vs time using the ignition probability calculated from MODIS burned area product (Simul Data) and the ignition probability from the estimated GAM models (Simul GAM) and two of the best fitted parameter sets with average $\theta = 90$ and $110$](figure/Amazon_ForestPercent_SimulDataGam.png)


\newpage

### Fire model predictions


![Maximum annual fire size predictions of the model compared with data. We used to simulate the model the ignition probability calculated with data from General Circulation Models under two greenhouse gas emissions scenarios known as Representative Concentration Pathways (RCPs), RCP4.5 and RCP8.5, and two of the best fitted parameter sets with average $\theta = 90$ and $110$. For the years 2001-2020 the ignition probability was estimated from actual data. ](figure/Amazon_Max_Size_theta90-110_RCP4.5-8.5.png)

![Total annual fire extension predictions of the model compared with data. We used to simulate the model the ignition probability calculated with data from General Circulation Models under two greenhouse gas emissions scenarios known as Representative Concentration Pathways (RCPs), RCP4.5 and RCP8.5, and two of the best fitted parameter sets with average $\theta = 90$ and $110$. For the years 2001-2020 the ignition probability was estimated from actual data.](figure/Amazon_Tot_Size_theta90-110_RCP4.5-8.5.png)

![Number of fires predictions of the model compared with data. We used to simulate the model the ignition probability calculated with data from General Circulation Models under two greenhouse gas emissions scenarios known as Representative Concentration Pathways (RCPs), RCP4.5 and RCP8.5, and two of the best fitted parameter sets with average $\theta = 90$ and $110$. For the years 2001-2020 the ignition probability was estimated from actual data. ](figure/Amazon_Num_Fires_theta90-110_RCP4.5-8.5.png)

![Power law exponent of the annual fire size distributions of the model compared with data. We used to simulate the model the ignition probability calculated with data from General Circulation Models under two greenhouse gas emissions scenarios known as Representative Concentration Pathways (RCPs), RCP4.5 and RCP8.5, and two of the best fitted parameter sets with average $\theta = 90$ and $110$. For the years 2001-2020 the ignition probability was estimated from actual data.](figure/Amazon_PatchExponent_theta90-110_RCP4.5-8.5.png)


![Predictions of the Forest state of the model vs time using the ignition probability calculated with data from General Circulation Models under two greenhouse gas emissions scenarios known as Representative Concentration Pathways (RCPs), RCP4.5 and RCP8.5. Here we show tow of the best fitted fire models with the minimum and maximum $\theta = 90$ and $110$.](figure/Amazon_ForestPercent_theta90-110_RCP45-85.png)



