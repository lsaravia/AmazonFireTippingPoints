#
# Validation of using max_total_patch for parameter estimation with ABC

require(abc)
require(tidyverse)
# 
# We test the method using one simulation at random as a target value
#
msim <- readRDS("Simulations/Amazon20yearsTot_lhs.rds") ## Simulated up to 2022-01-01 


# type == "ifd_0207" are simulations with initial_forest_density as parameter
#
set.seed(4544)
comp <- msim %>% mutate(year=year(Date)) %>% filter(year<2022,type=="ifd_0207") %>% group_by( type,world_width, siminputrow, random_seed,Initial_forest_density,forest_dispersal_distance, Forest_growth,year) %>% summarize( max_total_patch=max(burned_by_month))
cc <- comp %>% ungroup() %>% filter(random_seed==sample(unique(comp$random_seed),1),siminputrow==sample(unique(comp$siminputrow),1)) 
cc %>% distinct(Initial_forest_density,forest_dispersal_distance, Forest_growth)
# seed=1243   0.45                      21.0         6308.
# seed=124233 0.56                      64.3         7105.
# seed=4243   0.63                       8.9         2688.
# seed=4243   0.55                      91.0         2919.
# seed=4544   0.46                      92.3          948.
cc <- cc %>% dplyr::select(max_total_patch) %>% deframe()


comp <- comp %>% ungroup() %>% pivot_wider(names_from=year,values_from = max_total_patch)
names(comp)
resabc <- abc(target = cc, param=dplyr::select(comp, Initial_forest_density,forest_dispersal_distance, Forest_growth),
              sumstat = dplyr::select(comp, "2001":"2021"), tol = 0.05, method = "rejection" )

summary(resabc)

resabc$unadj.values %>% as_tibble() %>% count(forest_dispersal_distance,Forest_growth)

res2 <- abc(target = cc, param=dplyr::select(comp, Initial_forest_density,forest_dispersal_distance, Forest_growth),
            sumstat = dplyr::select(comp, "2001":"2021"), tol = 0.05, method = "loclinear" )
summary(res2)

res2$adj.values
plot(res2, param=dplyr::select(comp, Initial_forest_density,forest_dispersal_distance, Forest_growth))

#
# The conclusion is that "loclinear" method estimate better the parameters, dispersal distance is always more difficult to estimate when is short
# while  the "rejection" is a bit worse
#




