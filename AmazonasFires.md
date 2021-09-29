# Amazonas fire regimes under climate change scenaries

Leonardo A. Saravia ^1^ ^4^, Ben Bond-Lamberty ^2^, Samir Suweis ^3^

1. Instituto de Ciencias, Universidad Nacional de General Sarmiento, J.M. Gutierrez 1159 (1613), Los Polvorines, Buenos Aires, Argentina.

2. Pacific Northwest National Laboratory, Joint Global Change Research Institute at the University
of Maryland–College Park, 5825 University Research Court #3500, College Park, MD 20740, USA 

3. Laboratory of Interdisciplinary Physics, Department of Physics and Astronomy ``G. Galilei'', University of Padova, Padova, Italy

4. Corresponding author e-mail lsaravia@campus.ungs.edu.ar, ORCID https://orcid.org/0000-0002-7911-4398


\newpage


## Abstract 




## Introduction

Very few regions in the terrestrial biosphere are unaffected by fire often caused directly or indirectly by human activities [@Bowman2020], fire has different characteristics, including spatial patterns, severity, burn frequency, seasonality, and extension that produces contrasting ecological consequences [@Steel2021].
In recent years have seen an increase in fire intensity and extension in different regions [@Pivello2021;@McWethy2019 ] <!-- this ref is only about USA -->, partially attributable to the fact we are experiencing a biosphere with a 1C above historical records [@Masson-Delmotte2021].    

This intensification of fires could reduce the spatial and temporal variation in fire regimes, called pyrodiversity [@Kelly2017], that in turn will generate substantial reductions in biodiversity and ecosystem processes as carbon storage [@Dieleman2020;@Furlaud2021]. But probably the most affected regions will be the ones in which fire has been historically rare or absent as tropical forest [@Barlow2020], besides extensive loss on biodiversite extreme fires could trigger major ecosystems changes as transitions from forest to savanah or shrublands [@Hirota2011; @Fairman2015]. 

Environmental factors play a major role in the generation of fires and many predictions are statistically based, others take into account more detailed processes [@Thonicke2010] and few take into account spatial dynamical phenomena (but see @Schertzer2014). Spatial dynamics it is important because can provide insights into how local interacions give rise to emergent fire patterns [@Pueyo2010] and moreover it may change the stability characteristics of dynamical systems [@Levin1996].
Simple models of fire have been used as an example of ‘self-organized criticality’ (SOC): where systems can self-organize into a state characterized by a power law in the size frequency distribution of disturbance events [@Jensen1998], this is the case of the Drossel & Schwabl model @Drossel1992. Albeit simple, some modifications of the Drossell & Schwabl model have been used to predict fire responses to climate change [@Pueyo2007a], and some can reproduce features observed in empirical studies [@Ratz1995] as the power law distribution of the fire sizes, the size and shape of unburned areas and the relationship between annual burned area and diversity of ecological stages [@Zinck2009]. A unification of different models showed that changing the scale of grid cells to represent several hectares, and the ‘memory effect’: flammability increases with the time since a site last fire, where the key process for reproducing all three patterns [@Zinck2009; @Zinck2011]. But the exponent of the fire size distribution observed in different ecoregions was still not reproduced by these models. 

* Fire size distributions in nature are not always power-laws but have important variations between years [ Nicoletti2021 Preprint ] 

* Complex systems approach and the use of relatively simple models coupling dynamics with forcing environmental variables.


<--! Thus, predicting ‘black swan’ extreme fire events — which, by definition, have no historical precedent, such as the protracted, enormous and severe Australian 2019–2020 fires — seriously challenge the capacity of Earth-system-model projections. -->

In this work we analyze the fire dynamics of the last 20 year in the Amazonas, based on this we predict the ignition probability up to 2060 and using a simple model with the minimal components to reproduce the fire and vegetation dynamics we foresee the changes in fire regimes that it could produce. 


In this work we develop a simple model with the minimal components to reproduce the observed seasonal fire patterns and the power-law exponent of fire sizes, forced by environmental variables trough the probability of ignition. We use the model to predict for the Amazonas basin, the annual total and the maximal fire extension up to 2060 based on General Circulation Model scenarios under different greenhouse gas emissions.


## methods 


Our region of study is the Amazonas Basin (Figure 1), including Brasil, that represent 60% of the area, and 8 countries more (Bolivia, Colombia, Ecuador, Guyana, Peru, Suriname, Venezuela, and French Guiana). One of the reasons to choose this region is that is marked as a tipping element of the Earth-system, this means that that is at least subcontinental in scale and can exhibit a tipping point [@Lenton2013;@Staver2011]. 

![Region of study: the Amazonas Basin](figure/AmazonasRegion.png)

### Fire data and parameters

We estimate the monthly burned areas from 2001 to the end of 2020 using the NASA Moderate-Resolution Imaging Spectroradiometer (MODIS) burnt area Collection 6 product MCD64A1 @Giglio2016, which has a 500 m pixel resolution. To download the data we used Google Earth Engine restricted to the region of interest. Each image represents the burned pixels as 1 and the non-burned as 0. Then we calculate the burned clusters using 4 nearest neighbours (Von Neumann neighbourhood) and the Hoshen–Kopelman algorithm [@Hoshen1976], each cluster represent a fire event and this allows us to calculate the number and sizes of fire clusters by month. We calculate the probabilitiy of ignition as the number of clusters that growth from cero in that month, it means that if a fire started in the previous month we avoid to count it, the we divided it by the total number of pixels in the region.

To estimate the distribution of fire sizes we used an annual period. We agregated the monthly images using a simple superposition, so the anual image has a 1 if it has one or more fires during the year, and 0 if it has none. After that we run again the the Hoshen–Kopelman algorithm and obtain the annual fire clusters, and we fitted several distributions to the fire sizes ( power-law, power-law with exponential cut-off, log-normal, and exponential ), we used maximum likelihood to decide which distribution fited best to the data [@Clauset2009]. 

### Modelling the probability of ignition

We fitted a series of GAM models to relate the probability of ignition to monthly precipitation, maximum temperature and a seasonal term. These environmental variables were frequently used in statistical models of fire prediction [@Turco2018], we also selected these variables because they are readily available on the General Circulation Models (GCM) we will use later. We obtanied these monthly variables from the TerraClimate dataset [@Abatzoglou2018], and made an spatial average over the study region.

We fitted models with single variables and a combination of two interacting variables, and also precipitation from the previous month  (Table S1), using to select the best model the Akaike criterion (AIC). To evaluate the predictive power of the models we break the data set in a training set (with Date < 2018) and testing set (with Date >= 2018) and we calculate the mean absolute percentage error (MAPE) for the three best models previously selected (Figure S2). 


To obtain predictions of the ignition probabily up to 2060, we use the NASA Earth Exchange Global Daily Downscaled Climate Projections [@Thrasher2012] obtained from General Circulation Models (GCM) runs conducted under the Coupled Model Intercomparison Project Phase 5 [@Taylor2012]. We average over the 21 CMIP5 models and over the study area to obtain the monthly values of the variables (precipitation and maximum temperature). Then we estimate the probability of ignition up to 2060 using the fitted GAM across two of the four greenhouse gas emissions scenarios known as Representative Concentration Pathways (RCPs), RCP4.5 and RCP8.5 [@Meinshausen2011]. 


### Model

Conceptually the model represents two processes: forest burning and forest recovery,  we are assuming that the forest layer does not represent exactly forest cover but flammable forest, and after a site was burned it does not mean that all the vegetation is dead but that all the fuel is consumed.  

We use a 2 dimensional lattice, each site in the lattice could be in three different states: an empty or burned site, a flamable forest (called forest for short) and, a burning forest. The lattice is updated in paralell, but in random order, according to following steps: 

1. A burning site becomes an empty site in the following step, the steps represent a day
2. A forest site becomes a burning forest if one or more of its 8 nearest neighbor sites are burning
3. A forest site sents a propagule to an empty site with probability $p$ at a distance drawn from a power-law dispersal kernel with exponent %de%.  
4. A random site can catch fire spontaneously with probability $f$, this probability could change by month reflecting the fire season.

Absorving boundary conditions are assumed and the initial state is a random configuration of forest sites with density 0.6 (60% of the lattice with forest), this configuration assures that the forest percolates: most forest are connected then an initially the fire spreads over the whole lattice. The rule 3 basically represents that and emtpy site can recover more quicly when is nearby a forest site, but also that some sites can recover far from established forest sites in fact depending on the exponent it could be any site in lattice [@Marco2011]. This choice it is based on the assumption than forest can disperse with fat-tailed kernels [@Clark2005; @Seri2012].

This model is very similar to the Drossel-Schwabl forest fire model [@Drossel1992; @Clar1994] that exhibits critical behavior when $p \to 0$ and $f/p \to 0$, and it must satisfy the condition that $f << p$.  If the ignition probability $f$ is too high fires are frequent, flamable forest sites are disconected 





* We fitted a series of GAM model to relate the probability of ignition to monthly precipitation, maximum temperature and a seasonal term. These environmental variables are used in statistical models of fire prediction [@Turco2018], we also selected these variables because they are readily available on the General Circulation Models (GCM). We use an spatial average of these variables over the study region obtained from the TerraClimate dataset [@Abatzoglou2018]. The best model included the interaction between a seasonal term and maximal temperature. 

* We obtained the monthly spatial averages of the previous variables from General Circulation Models (GCM) runs conducted under the Coupled Model Intercomparison Project Phase 5 [@Taylor2012]. Then we estimate the probability of ignition up to 2060 using the fitted GAM across two of the four greenhouse gas emissions scenarios known as Representative Concentration Pathways (RCPs), RCP4.5 and RCP8.5 [@Meinshausen2011]. 

<--! We predicted the ignition probability up to 2060 based in the Coupled Model Intercomparison Project Phase 5 (CMIP5, see @Taylor2012) and across two of the four greenhouse gas emissions scenarios known as Representative Concentration Pathways (RCPs, see @Meinshausen2011), RCP 4.5 and RCP 8.5. -->


