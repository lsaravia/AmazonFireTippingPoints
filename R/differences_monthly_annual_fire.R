# Check differences between anual data and monthly data, due to pixels burned twice in the same year. 
#
fname <- paste0("Data/patch_sparse_BurnedArea_", region_name, ".rds" )
patch_sparse <- readRDS(fname)

patch_size_pfname <- paste0("Data/patch_sizes_p_BurnedArea_", region_name, ".rds" )
patch_sizes_p <- readRDS(patch_size_pfname)
patch_sizes_p <- patch_sizes_p %>% group_by(date) %>% summarise(tot_patch=sum(size)) %>% rename(year=date)

patch_size_name <- paste0("Data/patch_size_BurnedArea_",region_name, ".rds")
if(file.exists(patch_size_name)) {
  patch_size <- readRDS(patch_size_name)
}

total_forest <- 31364191 # total mumber of pixels with forest

mdat <- patch_size %>% mutate(Date=ymd(date),year=year(Date)) %>% group_by(year) %>% 
  summarize(total_patch=sum(size)) 
patch_sizes_p %>% inner_join(mdat ) %>% mutate(dif_burned2 = total_patch - tot_patch)
# 3254 + 2982 = 6236
# 
# A tibble: 22 × 2
# year total_patch
# <dbl>       <int>
# 1  2000        6236
# 2  2001      191587
# 3  2002      405715
# 4  2003      337402
# 5  2004      491830
# 6  2005      544475
# 7  2006      324490

patch_sparse %>% mutate(year=year(date)) %>% group_by(year) %>% summarize(total_patch=n()) 
# year total_patch
# <dbl>       <int>
#   1  2000        6236
# 2  2001      191587
# 3  2002      405715
# 4  2003      337402
# 5  2004      491830
# 6  2005      544475
# 7  2006      324490