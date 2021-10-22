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

This intensification of fires could reduce the spatial and temporal variation in fire regimes, called pyrodiversity [@Kelly2017], that in turn will generate substantial reductions in biodiversity and ecosystem processes as carbon storage [@Dieleman2020;@Furlaud2021]. But probably the most affected regions will be the ones in which fire has been historically rare or absent as tropical forest [@Barlow2020], besides extensive loss on biodiversity extreme fires could trigger major ecosystems changes as transitions from forest to savannah or shrublands [@Hirota2011; @Fairman2015]. 

Fires in the Amazonas were historically rare due to the ability of old-growth forest to maintain enough moisture to prevent fire spread, even after prolonged drought periods [@Uhl1990].  Human activities like deforestation and land-use change over the past 40 years produced the conditions for fire to become much more frequent and widespread across the basin [@Alencar2011]. Droughts are predicted to increase due to climatic change and these events have the potential to interact with human activities other than deforestation as secondary vegetation slash-and-burn and cyclical ﬁre-based pasture cleaning [@Aragao2018]. Even if deforestation rates have been substantially reduced until 2018 [@Feng2021], the previous activities provide sufficient ignition sources for fire to expand into adjacent forests [@Aragao2018]. This process could increase the importance of fires unrelated to deforestation [@Aragao2014].

Different models of fire for the Amazonas have been developed to predict regime changes under climate change scenarios [@Fonseca2019; @LePage2017]. These models could be process-based of intermediate complexity [@LePage2017] or statistical and generally take into account land-use change, and other human activities plus local weather conditions, but they neglected to explicitly take into account the spatial dynamics of fire spread.

Many fire models are statistically based and take into account mainly  environmental factors [@Turco2018], others take into account more detailed processes [@Thonicke2010] and few take into account spatial dynamical phenomena (but see @Schertzer2014). Spatial dynamics is important because can provide insights into how local interactions give rise to emergent fire patterns [@Pueyo2010] and moreover it may change the stability characteristics of dynamical systems [@Levin1996].
Simple models of fire have been used as an example of self-organized criticality (SOC): where systems can self-organize into a state characterized by a power law in the size-frequency distribution of disturbance events [@Jensen1998], this is the case of the Drossel & Schwabl model @Drossel1992. Albeit simple, some modifications of the Drossell & Schwabl model have been used to predict fire responses to climate change [@Pueyo2007a], and some can reproduce features observed in empirical studies [@Ratz1995] as the power-law distribution of the fire sizes, the size and shape of unburned areas and the relationship between annual burned area and diversity of ecological stages [@Zinck2009]. An analysis of different models showed that changing the scale of grid cells to represent several hectares, and the ‘memory effect’: flammability increases with the time since a site last fire, where the key process for reproducing all three patterns [@Zinck2009; @Zinck2011]. But the exponent of the fire size distribution observed in different ecoregions was still not reproduced by these models. 

These simple models could have critical behaviour characterized by power-law distribution in fire sizes and other observables, this kind of dynamics could be explained in terms of percolation theory [@Stauffer1994] where there is a transition between two states: one where propagation of fires occurs and another where it is very limited. The narrow region where the transition occurs is the critical point, and this is characterized with an order parameter (fire size) that depends on some external control parameter (ignition probability) [@Sole2006]. This kind of models could reproduce extreme events as large 'black swan' fires---which by definition has no historical precedent---as the recent Australia 2019-2020 fires [@Bowman2020]. These kinds of events are very difficult to predict by Earth-system models that do not fully incorporate the dynamic of fuel accumulation and vegetation dynamics [@Sanderson2020]. 

The objective of this work is to predict the fire regimes of the Amazonas region based on climate change scenarios using a simple spatial stochastic fire model. We first analyse the fire dynamics of the last 20 years in the region with MODIS burnt area product and derive an ignition probability. We predict the ignition probability up to the year 2060 based on General Circulation Model scenarios under different greenhouse gas emissions representative pathways. Then using the model forced with the ignition probability we predict and analyze the changes in the fire regimes for the Amazonas. 


## methods 


Our region of study is the Amazonas Basin (Figure S1), including Brasil, that represent 60% of the area, and 8 countries more (Bolivia, Colombia, Ecuador, Guyana, Peru, Suriname, Venezuela, and French Guiana). One of the reasons to choose this region is that is marked as a tipping element of the Earth-system, this means that that is at least subcontinental in scale and can exhibit a tipping point [@Lenton2013;@Staver2011]. 

### Fire data and parameters

We estimate the monthly burned areas from 2001 to the end of 2020 using the NASA Moderate-Resolution Imaging Spectroradiometer (MODIS) burnt area Collection 6 product MCD64A1 [@Giglio2016], which has a 500 m pixel resolution. To download the data we used Google Earth Engine restricted to the region of interest. Each image represents the burned pixels as 1 and the non-burned as 0. Then we calculate the burned clusters using 4 nearest neighbours (Von Neumann neighbourhood) and the Hoshen–Kopelman algorithm [@Hoshen1976]. Each cluster contains contiguous pixels burned within a month and this represents a fire event. After this we can calculate the number and sizes of fire clusters by month. We estimate the probability of ignition $f$ as the number of clusters that growth from zero in that month, it means that if a fire started in the previous month we avoid to count it, then we divided it by the total number of pixels in the region to allow comparisons with the fire model.

We also estimate the distribution of fire sizes, but using an annual period to have a enough number of fire clusters to discriminate between different distributions. We aggregated the monthly images using a simple superposition, so the annual image has a 1 if it has one or more fires during the year, and 0 if it has none. After that we run again the the Hoshen–Kopelman algorithm and obtain the annual fire clusters, and we fitted the following distributions to the fire sizes: power-law, power-law with exponential cut-off, log-normal, and exponential. We used maximum likelihood to decide which distribution fitted best to the data using the Akaike Information Criteria ($AIC$) [@Clauset2009]. Additionally we computed a likelihood ratio test for non-nested models: the Voung's test [@Vuong1989], we only consider it a true power-law when the value of the $AIC$ is minimum and the comparison with the exponential distribution using the Vuong's test is significant with p<0.05, if p>=0.05 we assume that the two distributions cannot be differentiated. 

### Modelling the probability of ignition


We calculated the monthly ignition probability $f$ and then we related it to monthly precipitation ($ppt$), maximum temperature ($maxTemp$) and a seasonal term. We obtained the environmental data from the TerraClimate dataset [@Abatzoglou2018], doing an average over the region. We transform $f$ to logarithms and evaluated an increasingly complex series of generalized additive models (GAMs), assuming a Gaussian distribution family. We use thin plate regression splines as smooth terms, and for interactions between environmental variables we used tensor products, with the method restricted maximum likelihood (REML) to ﬁt to the data [@Pedersen2019]. All these procedures were available in the R package **mgcv** [@Wood2017] and all source code is available at the repository <https://github.com/lsaravia/GlobalFireTippingPoints>.

We selected the best model using  $AIC$ [@Wood2017] and to evaluate the predictive power of the models we break the data set in a training set (with Date < 2018) and testing set (with Date >= 2018) and we calculate the mean absolute percentage error (MAPE) for the three best models selected with $AIC$ (Table S2). The formula of the MAPE is as follows:

$\textrm{MAPE} = \frac{100}{N_{tot}} \sum_{i=1}^{ N_{tot}} {\frac{|n_i^{obs} - n_i^{pred}|}{n_i^{obs}}}$ 


We used the previous GAM model to obtain predictions of the ignition probability up to 2060. We get the data from the NASA Earth Exchange Global Daily Downscaled Climate Projections [@Thrasher2012], which were estimated with General Circulation Models (GCM) runs conducted under the Coupled Model Intercomparison Project Phase 5 [@Taylor2012]. We averaged over the 21 CMIP5 models and over the study region to obtain the monthly values of the needed variables: precipitation and maximum temperature. Then we estimate the probability of ignition up to 2060 using the fitted GAM across two of the four greenhouse gas emissions scenarios known as Representative Concentration Pathways (RCPs), RCP4.5 and RCP8.5 [@Meinshausen2011]. 

<!-- 

We used generalized additive models [@Wood2017] to relate the probability of ignition to monthly precipitation, maximum temperature and a seasonal term. These environmental variables were frequently used in statistical models of fire prediction [@Turco2018], we also selected these variables because they are readily available on the General Circulation Models (GCM) we will use later. We obtained these monthly variables from the TerraClimate dataset [@Abatzoglou2018], and made an spatial average over the study region.

-->


### Fire Model

Conceptually the model represents two processes: forest burning and forest recovery, we are assuming that the forest layer does not represent exactly forest cover but flammable forest, and after a site was burned it does not mean that all the vegetation is dead but that all the fuel is consumed.  

We use a 2-dimensional lattice, each site in the lattice could be in three different states: an empty or burned site, a flammable forest (called forest for short) and, a burning forest. The lattice is updated in parallel, but in random order, according to the following steps: 

1. A burning site becomes an empty site in the following step, the steps represent a day
2. A forest site becomes a burning forest if one or more of its 8 nearest neighbour sites are burning
3. A forest site sent a propagule to an empty site with probability $p$ at a distance drawn from a power-law dispersal kernel with exponent $de$.  
4. A random site can catch fire spontaneously with probability $f$, this probability could change by month reflecting the fire season.


We assumed absorbing boundary conditions and the initial state is a random configuration of forest with density 0.6 (60% of the lattice with forest), this configuration assures that the forest percolates: most forest sites are connected then initially the fire spreads over the whole lattice. Rule 3 represents that an empty site can recover more quickly when is nearby a forest site, but also that some sites can recover far from established forest sites in fact, depending on the kernel exponent, it could be any site in lattice [@Marco2011]. The choice of a power-law dispersal is justified because it was found that forest usually disperses with fat-tailed kernels [@Clark2005; @Seri2012].

This model is very similar to the Drossel-Schwabl forest fire model [@Drossel1992] that exhibits critical behaviour when $\theta = p/f$ tends to $\infty$,   thus it must satisfy the condition that $f << p$, as is generally observed in natural systems. The model involves the separation between three time scales: the fast burning of forest clusters, the slow recover of forest, and the even slower rate of fire ignitions. Then in the critical regime there is a slow accumulation of forest that forms connected clusters, eventually as the ignition probability is very low these clusters connect the whole lattice---here is the link with percolation theory [@Stauffer1994]---and an ignition event produce big fires. After this, the density of the forest becomes very low and the accumulation cycle begins again. This regime is characterized by wide fluctuations in the size of fires and the density of trees, and both of them follow approximately power-law size distributions.

If the ignition probability $f$ is too high fires are frequent, forest sites become disconnected and small fires, with a characteristic size, dominate the system. An example of this regime could be the case of indigenous fire stewardship in Australian landscapes, they maintained flammable forest in a disconnected state by producing frequent small scale fires [@NatureEcoEvo2020]. This regime was disrupted by fire suppression related to European colonization and land-use change [@Hoffman2021], pushing the system towards a critical regime [@Nicoletti2021].  

One of the features not present in the original forest fire model is that forests can have long-distance dispersal, and this could modify the distribution of forest clusters, the distribution of fire sizes and dynamics of the model. When forest dispersal is limited mainly to nearest neighbours, forest recovery produce clusters that tend to coalesce and form uniform clusters with few or no isolated forest sites. When the forest burns these isolated forest sites are the points from where the forest recover (assuming no external colonization) then when these are not present there is an increased probability that the forest becomes extinct. When dispersal is long-distance besides there is an important recovery around established forest sites there is an important number of isolated forest sites, and that produces decreases the probability of forest extinction. All this process is particularly important when $\theta$ is low and fires are smaller but more frequent. In dynamical terms there is a critical extinction value $\theta_{ext}$, when $\theta < \theta_{ext}$ the forest become extinct, but the critical value depends on the dispersal distance governed by $de$.

The second feature not present in the original forest fire model is seasonality, in natural systems, there is a period of the year where the environmental conditions produce an increase in the fire ignition probability, during the rest of the year there is a much lower probability of fires. This forces a periodic accumulation of forest and a short period of intense fires which is called the fire season. Thus the model has a short period of low $\theta_{min}$ and a longer period of high $\theta_{max}$ if both the minimum and maximum $\theta$ are in the critical region, which means that both a relatively big, the model behaviour, in the long run, will be like the critical regime albeit with a more pronounced periodicity. When $\theta_{max}$ is in the critical zone but near the limit, so $\theta_{min}$ could be outside the critical zone, the model dynamics regime could have more extreme fires (i.e. be more similar to the critical regime) than an equivalent non-seasonal model. If both $\theta$ are outside the critical region the dynamics could be close to the critical extinction zone, but in this case, the effect on periodicity will be less pronounced. 

Increasing the length of the fire season as predicted in climate change scenarios [@Pausas2021]  will produce the model to spend more time at a lower $\theta$ decreasing the connectivity of the forest and the size of fires. Moreover, depending on the position of $\theta_{max} - \theta_{min}$ on the parameter space increasing the possibility of critical extinction.  

We made a set of exploratory simulations with a range of parameters compatible with what we found for the Amazon region, to characterize the previously described regimes (Table S3). We used a lattice size of 450x450 sites, the simulations run for 60 years with an initial forest density of 0.3 (different initial conditions give the similar results), and we use the final 40 years to estimate the total annual fire size, the maximum cluster fire size, the distribution of fire sizes, and the total number of fires. To determine the cluster fire sizes and distributions we used the same methods described previously for the MODIS fire data. We ran a factorial combination of dispersal exponent $de$ and $\theta$ and 10 repetitions of each parameter set. First we ran the experiment with $\theta$ fixed, keeping the ignition probability $f$ constant, then we repeated the experiment with seasonality: we simulate a fire season of 3 months each year multiplying $f$  by 10. The dispersal exponent $de=102$ is equivalent to a dispersal to the nearest neighbours, and $de=2.0155$ corresponds to a mean dispersal distance of 66 sites (Table S3).

### Fire Model Fitting

As we already estimated the $f$ parameter from the 20 years of MODIS data, we only need to estimate the dispersal exponent $de$ and the probability $p$ of forest growth, we express this parameter $p$ as $r=1/p$ representing the average number of days for forest to recover. For this estimation we duplicated the extension of the estimated $f$ as if it started in 1980, so we allow 20 years to the model to dissipate transients and then we used the last 20 years to compare with monthly fire data. To explore the parameter space we used latin-hypercube sampling [@Fang2005] with parameter ranges $(4, 2.0101)$ for $de$ and $(90 - 7300) days for $r$, we used 500 samples and 10 repeated simulations of the model for each sample, totalling 5000 simulations, as the model has a long transient period we made simulations with different starting forest density of 0.3 and 0.6. We then selected the 10 best parameter sets using the ones with the minimum MAPE comparing the monthly data with the predictions, we also calculate the correlation. We observed that the peaks in the model are delayed by 2-3 months, the same happens in more realistic process based models [@Thonicke2010], and as we were not interested in predicting exactly the seasonal fire patterns, we fitted again the parameters with MAPE but using the monthly maximum of the year. The second step of our fitting procedure was to take the 10 best fitted parameter sets and calculate the power-law fire distribution, for doing this we run 100 simulations for each of the parameters sets and then calculate the fire cluster distributions using the same methods explained previously.

Finally we run the model with the best fitted parameters and the ignition probability estimated from the MODIS data and with the ignition probability estimated with the GAM model for the period 2000-2020, to check if the data fit with the range of predictions.  

### Model Predictions  

We use the best fitted parameter set and the predictions of the parameter $f$ under the two greenhouse gas emissions scenarios known as Representative Concentration Pathways  RCP4.5 and RCP8.5 to make simulations up to 2060. We start simulations in year 1980 as in the fitting procedure, but instead of using $f$ derived directly from data we used the $f$ obtained from the GAM model, this allows us to compare actual and predicted fires using with the same method to obtain $f$. For this simulations we sample each $f$ for each month assuming the $log(f)$ follows a normal distribution with the average and standard deviation given by the values obtained in the GAM model.  

## Results

The monthly fires follow a strong seasonal pattern with a maximum between September and October (Figure S2). We could characterize the annual fire regime using the total fire size (total burned area) and the maximum fire cluster (the biggest fire event $S_{max}$), the years with highest $S_max$ are also years with high total fire size (Figure 1). We can observe that the years 2007 and 2010 had the two highest $S_{max}$ and they also have a power-law distribution (Table S1, Figures S3-S5). Power-law distributions have two parameters the $x_{min}$ which is the minimum value for which the power-law holds, and the exponent. Only 6 from 20 years exhibit power law distribution (Table S1), some of the years with power-law distribution have a range, which is the $x_{min} - S_{max}$, with the highest values compared with the years without power-laws, but there are years with power-law and small range. These two extremes represent a pattern that we will also observe in the fire model. 

![Annual total fire size vs maximum fire size for the Amazon as a percent of the region area. Estimated with MODIS burned area product](figure/Amazon_Annual_TotSizeVsMaxSize.jpg)


We fitted GAM models for the ignition probability $f$ with single variables, and combinations of two interacting variables, the best model with lower $AIC$ and lower MAPE was the interaction  $maxTemp * month$ (Table S2). For the GAM fitted to the complete dataset we observe that the model do not capture the most extreme years of $f$ (Figure S7), but the model fitted for the first years (< 2018) predict very well the rest of the data (Figure S8).


With the best-fitted GAM and the $maxTemp$ from the NASA Earth Exchange Global Daily Downscaled Climate Projections, we predicted the monthly $f$ starting from 2010 for two greenhouse gas emissions scenarios: RCP4.5 and RCP8.5, in this case most data fall inside de standard error of the model (Figures S9 & S10)

### Fire model exploration 

We simulated the model with a range of the $\theta$ parameter (equal to $p/f$) and we expected that bigger values would produce critical behaviour that consist in large variability of fires between years and extremely large cluster fire sizes that follow a power-law distribution. As expected we obtained a bigger proportion of power-law distributions for the biggest size of $\theta$ (Table S5), and particularly high variability and extremely big fires (Figure 2). For simulations with seasonality we observed the expected decrease on the frequency of power-law distributions, and also less variability and less extreme fires, because in these cases $\theta$ decreases for the fire season. Seasonality have also the unexpected effect of increasing the frequency of power-law distribution for $\theta = 25$ with a bigger exponent than the ones for large $\theta$ (Table S5), this pattern was also observed in the MODIS data. 

In the simulations with lower $\theta$ 25 and 250 and with shorter dispersal distances, the forest density tends to decrease and eventually it reach 0 which marks the absorbing phase transition reported for this kind of models [@Nicoletti2021], thus in these cases the parameter $\theta$ was below the critical point $\theta_{ext}$ (Figure S11). Increasing the dispersal distance produce higher forest density and seasonality have the opposite effect, in the case of high dispersal and low $\theta$ we are again below $\theta_{ext}$. Forest density is the so called active component of the model and for our purposes did not represent actually the forest but the flammable forest. 

![Total annual fire size vs. max fire cluster for the Fire model. **A** & **B** Are simulations with fixed $\theta$, **A** with dispersal exponent $de=102$, mean dispersal distance of 1 (equivalent to nearest neighbours ) and **B** with $de=2.0155$, mean dispersal distance of 66 sites. **C** & **D** Are simulations with a fire season of 90 days where $\theta$ is divided by 10 (the probability of ignition $f$ is multiplied by 10), and the same $de$ as previously. ](figure/FireNL_TotSizeVsMaxSize_dispersal_theta_season.png)


### Fire Model Fitting

We used two methods to fit the model to data, one using the monthly fire extent and another using the monthly maximum of the year, as the model produced delayed fire peaks the first method resulted in very low values for the monthly maxima, which is also reflected in very low values of the correlation (Table S6, Figures S14 & S15). The second fitting method resulted in monthly fire time series more similar to data (Figure S14) with lower MAPE and higher correlation than the first method. So we used the parameters fitted with this last method for predictions. With the ten best parameter sets we calculated the power-law fire distribution and selected one parameter set with a  median exponent closer to the data (Table S7). All these best parameters result in an average $\theta$ between 110 and 90 which is an intermediate range taking into account the parameter range we used for the model exploration. 

The model predictions using best fitted parameters, the ignition probability $f$ calculated from the data and $f$ estimated using the GAM model gave results well into the observed data range. The predicted median maximum fire cluster size is slightly higher and the power-law exponent of the fire size distribution is lower (Figure 3), these results are inter-related because when power-law exponents are lower we expect larger fire events. The predicted total fire size have a very good match with the data, and the predicted number of fires is slightly higher than data (Figure 3). 

![Predictions of the fire model compared with data for the years 2001-2020. We used to simulate the model best fitted parameters and the ignition probability calculated from MODIS burned area product (Simul Data) and the ignition probability from the estimated GAM models (Simul GAM). All the outputs are relative to the total area and black point are the medians.](figure/Amazon_ModelVsData_SimulGAM.png)

### Fire model predictions

We observed that the $\theta$ for the best fitted parameter was in the lowest range if we consider the set of ten best fitted parameters (Table S7), so we decided to add simulations with another parameters from the set but with the highest values of $\theta$. Then we did the simulations with the first row of parameters of the table S7 ($\theta \sim 90$) and the sixth row ($\theta \sim 110$). The simulations by decade gave results that are similar for the two greenhouse gas emissions scenarios and the simulations with $\theta \sim 110$ resulted in higher values of total fire and maximum fire but more accentuated since the 2040s. The range of the predictions is in all cases lower than the range of the observed data.

![Total annual size of fires vs maximum fire size % relative to the area of the region. The data column was estimated using MODIS burned area product. The predictions by decade were estimated with a fitted model using a monthly ignition probability calculated with data from General Circulation Models under two greenhouse gas emissions scenarios known as Representative Concentration Pathways (RCPs), RCP4.5 and RCP8.5. From the best fitted fire models we show two with the minimum and maximum $\theta$ parameter.](figure/Amazon_TotSizeVsMax_year_theta90-110_RCP45-85.png)


## Discussion

Based on spatial forest-fire dynamics, the model fitted to actual data and the predictions up to 2060 suggest that the Amazonas fire dynamics is outside a critical regime and far from an absorbing phase transition. A critical regime would imply far more extreme fires and an absorbing phase transition could trigger a forest-savanna transition, without extreme fires but high frequency fires. The actual and predicted fire regime seems to lie between these extremes, and all the predictions showed an decrease in maximum fire size and extension.

The forest state in the model represent the flammable forest, tropical forest in the Amazonas is not flammable and it there is a very low probability of natural fires [@Fonseca2019]. Fire is produced by human activities [@Barlow2020]. These human-induced fires can invade standing forest and if climate change makes forests hotter and drier it will become more capable of sustaining more extensive fires [@Brando2019]. Then our model assumes the fire conditions related to the actual deforestation and human activities are mostly invariants and predicts the modifications in fire regimes due to climate change scenarios. If the current fire regime had been in the critical region, the predicted changes would have been more important and the risk of collapse increased.  

Different authors suggest that a deforestation of 20%-40% of the Amazonas will produce a rapid transition to non-forest ecosystems [@Lovejoy2018;@Nobre2016 ]. Currently, approximately 20% of the forest since the 1960s was lost,  environmental signals suggest that the system as a whole is oscillating [@Lovejoy2018] and dynamical analysis predicts that it is close to a transition [@Saravia2018a], our model demonstrates that climate change per se will not produce a change in the regime of fires.  On the other hand if the actual tendency of deforestation and land-use change do not slow down and finally stop, these factors will interact and probably produce the collapse of the Amazonian tropical forest towards a savannah with irreversible implications to biodiversity, global climate, and the economy of countries region [@Arruda2019].


<!-- This extension in fire season would produce less large fires but as we approximate the critical extinction zone what happens is that the forest sites experience more frequent fires this could undermine the regeneration capacity of the forest pushing the model more towards the critical extinction, in nature this probably means that the system will be pushed to a drastic change in vegetation type as a transition from forest to savannah -->

<!-- Thus, predicting ‘black swan’ extreme fire events — which, by definition, have no historical precedent, such as the protracted, enormous and severe Australian 2019–2020 fires — seriously challenge the capacity of Earth-seystem-model projections. -->



## References