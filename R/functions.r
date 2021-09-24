ms_to_date <- function(ms, t0="1970-01-01", timezone="UTC") {
  ## @ms: a numeric vector of milliseconds (big integers of 13 digits)
  ## @t0: a string of the format "yyyy-mm-dd", specifying the date that
  ##      corresponds to 0 millisecond
  ## @timezone: a string specifying a timezone that can be recognized by R
  ## return: a POSIXct vector representing calendar dates and times        
  sec = ms / 1000
  as.POSIXct(sec, origin=t0, tz=timezone)
}


#' Calculate patch growth/shrink from a list of GeoTiff files generated from
#' Google Earth Engine with MODIS monthly burned area 
#'
#' @param fire_bricks list of GeoTiff files 
#' @param data_path   path of the files
#' @param region_name  name of the region for data.frame
#'
#' @return A data.frame with patch growth/shrink 
#' @export
#'
#' @examples
patch_growth_from_GEE_files <- function(file_list,data_path,region_name)
{
  p_df <- lapply( seq_along(file_list), function(i){
    
    br <- brick(paste0(data_path,"/",file_list[i]))
    if( i > 1){
      ii <- i-1
      br0 <- brick(paste0(data_path,"/",file_list[ii]))
      ll <- max(nbands(br0))
      df0 <- patch_growth_dynamics(br0[[ll]],br[[1]])
      df <- future_lapply(2:(nbands(br)), function(x){
        message(paste(names(br)[x]))
        patch_growth_dynamics(br[[x-1]],br[[x]])
      }, future.seed = TRUE)
      df <- bind_rows(df0,df) %>% mutate(region= region_name)  %>% dplyr::select(region, date, everything())
      
    } else {
      df <- future_lapply(2:(nbands(br)), function(x){
        message(paste(names(br)[x]))
        patch_growth_dynamics(br[[x-1]],br[[x]])
      }, future.seed = TRUE)
      df <- bind_rows(df) %>% mutate(region= region_name)  %>% dplyr::select(region, date, everything())
      
    }
    message(paste(file_list[i],  "-", nrow(df) ))
    
    return(df)
  })
  patch_growth <- bind_rows(p_df)  
}

#' calculate growth/shrink patch dynamics between two binary images
#' 
#' As the patches can merge and fragment, when a patch is fragmented in several pieces the rate is calculated 
#' considering the biggest fragment, when patches merge the rate is calculated from the biggest one also.
#'
#' @param img0 image at time 0
#' @param img1 image at time 1 
#'
#' @return
#' @export
#'
#' @examples
patch_growth_dynamics <- function( img0, img1, img1_date=NA)
{
  #
  if(inherits(img1,"Matrix")) {
    brName <- img1_date
  } else {
    brName <- str_sub( str_replace_all(names(img1), "\\.", "-"), 2)
  }
  
  ## Convert to TRUE/FALSE matrix
  #
  br0 <- as.matrix(img0)
  if( !is.logical(br0) )
    br0 <- br0>0
  br1 <- as.matrix(img1)
  if( !is.logical(br1) )
    br1 <- br1>0
  if(sum(br1)==0 | sum(br0)==0 ) {
    return(tibble())
  }
  
  lab <- spatialwarnings::label(br0)
  la1 <- spatialwarnings::label(br1)
  lab[is.na(lab)] <- 0
  la1[is.na(la1)] <- 0
  
  tuples <- tibble(l0 = c(t(lab)), l1 = c(t(la1))) %>%
    distinct %>% filter( l0!=0 | l1!=0)
  
  psize0 <- tibble(size = attributes(lab)$psd, no=1:(length(attributes(lab)$psd)))
  psize1 <- tibble(size = attributes(la1)$psd, no=1:(length(attributes(la1)$psd)))
  
  #
  # Hay que tomar cada parche y ver con 
  #
  
  dff <- lapply(seq_len(nrow(tuples)), function(i){
    
    p0 <- tuples$l0[i]
    p1 <- tuples$l1[i]
    
    if( p0 !=0 )
        s0 <- psize0$size[p0]
    else
        s0 <- 0
    if(p1 != 0 )
        s1 <- psize1$size[p1]
    else
        s1 <- 0
    if(s0>s1) {
      df <- tibble( type="s",patch0=p0,patch1= p1,size0=s0,size1=s1)
    } else if( s0 < s1) {
      df <- tibble( type="g",patch0=p0,patch1= p1,size0=s0,size1=s1)
    }

  })
  gr <- bind_rows(dff)
  # 
  # Si un parche se divide en muchos tomo la transicion al mayor de los que quedan
  # Si un parche se une a partir de muchos tomo la transicion desde el mayor 
  #
  gr1 <- gr %>% filter(size0>size1)%>% group_by(patch0) %>% slice(which.max(size1)) 
  gr2 <- gr %>% filter(size0<size1)%>% group_by(patch1) %>% slice(which.max(size0))  %>% bind_rows(gr1) %>% mutate(delta= size1-size0) %>% mutate(date=brName) 
  #
  # Caso de parches que desaparecierion
  #
}

#' Evaluate patch distribution in a raster brick and vectors of patch sizes
#'
#' @param br raster with distribution data >0 is TRUE/ or vector of patch sizes
#' @param returnEWS if TRUE returns the early warnings, FALSE returns the patch distribution   
#' @param returnOBJ if TRUE returns the early warnings, FALSE returns the patch distribution   
#'
#' @return a data frame with results
#' @export
#'
#' @examples
evaluate_patch_distr <- function(br,returnEWS=TRUE,returnOBJ=FALSE,xmin=1){
  
  source("R/powerlaw/discpowerexp.R")
  source("R/powerlaw/discexp.R")
  source("R/powerlaw/zeta.R")
  source("R/powerlaw/powerexp.R")
  source("R/powerlaw/exp.R")
  source("R/powerlaw/pareto.R")
  
  require(ggplot2)
  require(poweRlaw)
  
  if( !class(br) %in% c("RasterLayer",'ngCMatrix', 'numeric') )
    stop("Paramter br has to be a RasteLayer or ngCMatrix or numeric")
  
  # Extract Date from name of the band
  #
  if(class(br) %in% c("ngCMatrix", "numeric")) {
    brName <- NA   
  } else {
    brName <- str_sub( str_replace_all(names(br), "\\.", "-"), 2)
  }
  
  #
  # If raster o matrix convert to TRUE/FALSE matrix and get the patch distribution
  # 
  if( !class(br)=="numeric") {
    brTF <- as.matrix(br)
    if( !is.logical(brTF) )
        brTF <- brTF>0
  
    patch_distr <- patchsizes(brTF)
  } else {
    patch_distr <- br
  }
  if( length(unique(patch_distr))<4 ){
    return(tibble(date=NA,size=NA))
  }
    
  m_pl = displ$new(patch_distr)
  est = estimate_xmin(m_pl)
  m_pl$setXmin(est)
  dd <- plot(m_pl) 
  ll <- lines(m_pl, col = 2)
  m_ln <- dislnorm$new(patch_distr)
  #est = estimate_xmin(m_ln)
  m_ln$setXmin(est$xmin)
  pars <- estimate_pars(m_ln)
  m_ln$setPars(pars)
  pp <- lines(m_ln)

  m_exp <- disexp$new(patch_distr)
  m_exp$setXmin(est$xmin)
  pars <- estimate_pars(m_exp)
  m_exp$setPars(pars)
  ee <- lines(m_exp)
  
  m_pexp <- discpowerexp.fit(patch_distr,est$xmin)
  pe <- data.frame(x=dd$x,y=ppowerexp(dd$x,est$xmin,m_pexp$exponent,m_pexp$rate,lower.tail=F))
  pe$y <- pe$y*  dd$y[which(dd$x==est$xmin)]
  gp <- ggplot( dd, aes(x,y) ) + geom_point() + theme_bw() + scale_x_log10() + scale_y_log10() + 
    geom_line(data=ll,aes(x,y, color="Pl.")) + 
    geom_line(data=ee,aes(x,y, color="Exp.")) + ylab("Frequency (P>=x)") + xlab( "Patch size") +
    geom_line(data=pe,aes(x,y, color="P.Exp.")) + 
    geom_line(data=pp,aes(x,y, color="Ln.")) + coord_cartesian(ylim=range(dd$y)) + scale_color_viridis_d(name="")

  if(returnOBJ)
    patch_df <- gp
  else {
    if( returnEWS ){
      
      df1 <-tibble(date=brName, type="pl", expo=m_pl$pars[1],rate=m_pl$pars[2],xmin=m_pl$xmin,AICc = calc_AICc(m_pl), range=max(patch_distr)-xmin )
      df2 <-tibble(date=brName, type="exp", expo=m_exp$pars[1],rate=m_exp$pars[2],xmin=m_exp$xmin,AICc = calc_AICc(m_exp)) 
      df3 <- tibble(date=brName, type="ln", expo=m_ln$pars[1],rate=m_ln$pars[2],xmin=m_ln$xmin,AICc = calc_AICc(m_ln))
      df4 <- tibble(date=brName, type="pexp", expo=m_pexp$exponent,rate=m_pexp$rate,xmin=est$xmin,AICc = calc_AICc(m_pexp))
      patch_df <- bind_rows(df1,df2,df3,df4)
      #patch_distr <- data.frame("patchdistr_sews(brTF)
    } else {
      #patch_distr <- patchsizes(brTF)
      patch_df <- tibble(size=patch_distr) %>% mutate(date=brName) 
    }
  }
  return(patch_df)
}

# Calculate the AICc from a poweRlaw distribution object
#
calc_AICc <- function( d_obj){
  if( class(d_obj)=="list") {
    LL <- d_obj$loglike
    n <- d_obj$samples.over.threshold
    k <- 2
  } else {
    LL <- dist_ll(d_obj)
    n <- get_ntail(d_obj)
    k <- d_obj$no_pars
  }
  AICc <- (2*k-2*LL)+2*k*(k+1)/(n-k-1)
}

#' Convert raster bricks to a sparse matrix with date given by the name of the band 
#'
#' @param fire_bricks file names of the data
#' @param region_name name of the region 
#' @param data_path   path for the data
#'
#' @return a sparse matrix with TRUE if the pixel Burned and date calculated with band name 
#' @export
#'
#' @examples
convert_to_sparse <- function(fire_bricks,region_name,data_path){
  
  require(Matrix)
  p_df <- lapply( seq_along(fire_bricks), function(ii){
    
    br <- brick(paste0(data_path,"/",fire_bricks[ii]))
    df <- lapply(seq_len(nbands(br)), function(x){   # future_lapply
      brName <- stringr::str_sub( stringr::str_replace_all(names(br[[x]]), "\\.", "-"), 2)
      mm <- as.matrix(br[[x]]>0)
      message(paste(x,"-", brName ,"Suma de fuegos", sum(mm)))
      sm <- as(mm,"sparseMatrix")
      
      summ <- as_tibble(summary(sm)) 
      names(summ) <- c("i","j","data")
      summ <- summ %>% mutate(t=x,date=brName) %>% dplyr::select(t,i,j,data,date)
    })
    #yy <- str_sub(names(br)[1],2,5)
    df <- do.call(rbind,df) %>% mutate(region=region_name)
  })
  p_df <- do.call(rbind,p_df)
  
}


#' Convert raster bricks to a sparse matrix with date given by the field 'BurnDate' 
#' plus the base year given by the name of the band 
#'
#' @param fire_bricks file names of the data
#' @param region_name name of the region 
#' @param data_path   path for the data
#'
#' @return a sparse matrix with the number of days of the year when the pixel burnt, and date corrected with that number
#' @export
#'
#' @examples
convert_to_sparse_days <- function(fire_bricks,region_name,data_path){
  require(lubridate)
  require(Matrix)
  p_df <- lapply( seq_along(fire_bricks), function(ii){
    
    br <- brick(paste0(data_path,"/",fire_bricks[ii]))
    df <- future_lapply(seq_len(nbands(br)), function(x){   # future_lapply
      brName <- stringr::str_sub( stringr::str_replace_all(names(br[[x]]), "\\.", "-"), 2)
      mm <- as.matrix(br[[x]])
      message(paste(x,"-", brName ,"Suma de fuegos", sum(mm)))
      sm <- as(mm,"sparseMatrix")
      brDate <- ymd(brName)
      flDate <- floor_date(brDate, "year")
      summ <- as_tibble(summary(sm)) 
      names(summ) <- c("i","j","data")
      summ <- summ %>% mutate(t=x,date=flDate+data-1) %>% dplyr::select(t,i,j,data,date)
    })
    #yy <- str_sub(names(br)[1],2,5)
    df <- do.call(rbind,df) %>% mutate(region=region_name)
  })
  p_df <- do.call(rbind,p_df)
  
  mind <- min(p_df$date)
  
  p_df$t <- time_length( interval(mind, p_df$date), "day") + 1
  return(p_df)  
}


#' Calculate the value of NDVI from a the patches of a MODIS burned area Fire  
#' 
#' We extract the fire patches then we calculate the spatial median of NDVI for them. 
#' We also calculate the value of NDVI for the pixels without fire as a patch with number 0 inside the area defined by r_mask  
#'
#' @param ndvi raster with NDVI
#' @param fire raster with Burned Area
#' @param mask raster with the actual region of study we defined 
#'
#' @return a dataframe with fields: no=number of patch, size=size of the patch, mean_ndvi= the median NDVI value, 
#'        date=date of the fire raster file. 
#' @export
#'
#' @examples
calc_ndvi_previous_fire <- function(ndvi,fire,r_mask){
  if( !class(ndvi) %in% c("RasterLayer",'ngCMatrix') )
    stop("ndvi has to be a RasteLayer or ngCMatrix")
  if( !class(fire) %in% c("RasterLayer",'ngCMatrix') )
    stop("fire has to be a RasteLayer or ngCMatrix")
  if( !class(r_mask) %in% c("RasterLayer",'ngCMatrix') )
    stop("r_mask has to be a RasteLayer or ngCMatrix")
  # Date of the fire image
  #
  brName <- str_sub( str_replace_all(names(fire), "\\.", "-"), 2)
  
  ## Convert to TRUE/FALSE matrix
  #
  br0 <- as.matrix(ndvi)
  br1 <- as.matrix(fire)
  if( !is.logical(br1) )
    br1 <- br1>0
  if(sum(br1)==0  ) {
    return(tibble())
  }
  r_m <- as.matrix(r_mask)
  
  la1 <- spatialwarnings::label(br1)
  la1[is.na(la1)] <- 0
  psize1 <- tibble(size = attributes(la1)$psd, no=1:(length(attributes(la1)$psd)))
  
  mndvi <- lapply(psize1$no, function(x){ 
    xx <- which(la1==x, arr.ind=TRUE)
    tibble(mean_ndvi=median(br0[xx]))
    })
  psize1 <- bind_cols(psize1,bind_rows(mndvi)) %>% mutate(date=brName) 

  nofire <- median(br0[la1==0 & r_m==1 ])
  
  psize1 <- bind_rows(psize1,tibble(size=0,no=0,mean_ndvi= nofire, date=brName)) 
  
}


#' Calculate the value of NDVI from a the patches of a MODIS burned area Fire  
#' 
#' We extract the fire patches then we calculate the spatial median of NDVI for them. 
#' We also calculate the value of NDVI for the pixels without fire as a patch with number 0 inside the area defined by r_mask  
#'
#' @param ndvi raster with NDVI
#' @param fire raster with Burned Area
#' @param mask raster with the actual region of study we defined 
#'
#' @return a dataframe with fields: no=number of patch, size=size of the patch, mean_ndvi= the median NDVI value, 
#'        date=date of the fire raster file. 
#' @export
#'
#' @examples
calc_patches_of_fuel <- function(ndvi,threshold){
  if( !class(ndvi) %in% c("RasterLayer",'ngCMatrix') )
    stop("ndvi has to be a RasteLayer or ngCMatrix")
  
  # Date of the image
  #
  brName <- str_sub( str_replace_all(names(ndvi), "\\.", "-"), 2)
  
  br0 <- as.matrix(ndvi)
  if( !is.logical(br0) )
    br0 <- br0>threshold
  if(sum(br0)==0  ) {
    return(tibble())
  } 
  lab <- spatialwarnings::label(br0)
  lab[is.na(lab)] <- 0

  psize0 <- tibble(size = attributes(lab)$psd, no=1:(length(attributes(lab)$psd)))
  
}


calc_fuel_patch_growth <- function(f_nof,ndvi_bricks,region_name){

  first_date <- min(f_nof$date) 
  last_date <- date(max(f_nof$date)) %m+% period("1 month")
  p_df <- lapply( seq_along(ndvi_bricks), function(i){
    
    br <- brick(paste0(data_path,"/", ndvi_bricks[i]))

    ndvi_dates <- date(str_sub( str_replace_all(names(br), "\\.", "-"), 2))

    if( i > 1){
      ii <- i-1
      br0 <- brick(paste0(data_path,"/",ndvi_bricks[ii]))
      ll <- max(nbands(br0))
      #
      # Transform ndvi to binary using f_nof
      brll <- threshold_ndvi(br0[[ll]],f_nof)
      br11 <-  threshold_ndvi(br[[1]],f_nof)
      df0 <- patch_growth_dynamics(brll,br11,ndvi_dates[1])
      
      fin <- max(which(ndvi_dates < last_date)) 
      df <- future_lapply(2:fin, function(x){
        # Transform ndvi to binary using f_nof
        brx1 <- threshold_ndvi(br[[x-1]],f_nof)
        brx <-  threshold_ndvi(br[[x]],f_nof)
        message(paste(names(br)[x]))
        patch_growth_dynamics(brx1,brx,ndvi_dates[x])
      })
      df <- bind_rows(df0,df) %>% mutate(region= region_name)  %>% dplyr::select(region, date, everything())
      
    } else {
      ini <- min(which(ndvi_dates > first_date)) + 1
      df <- future_lapply(ini:(nbands(br)), function(x){
        # Transform ndvi to binary using f_nof
        brx1 <- threshold_ndvi(br[[x-1]],f_nof)
        brx <-  threshold_ndvi(br[[x]],f_nof)
        message(paste(names(br)[x]))
        patch_growth_dynamics(brx1,brx,ndvi_dates[ini+x-1])
      })
      df <- bind_rows(df) %>% mutate(region= region_name)  %>% dplyr::select(region, date, everything())
      
    }
    message(paste(ndvi_bricks[i],  "-", nrow(df) ))
    
    return(df)
  })
  ndvi_patch_growth <- bind_rows(p_df)
  
}



threshold_ndvi <- function(ndvi,f_nof){
  brdate <- str_sub( str_replace_all(names(ndvi), "\\.", "-"), 2)
  brdate <- paste0(str_sub( brdate,1,7), "-01") 
  rr <-  filter(f_nof, date>=brdate) %>% slice_min(date)
  ndvi <- as.matrix(ndvi)   
  if( rr$fire_ndvi>rr$nofire_ndvi){
    ndvi <- ndvi>rr$fire_ndvi
  } else {
    ndvi <- ndvi<rr$fire_ndvi
    
  }
}


#' Read Netlogo simualtions and clean field names 
#'
#' @param fname name of the csv file with NetLogo simulations
#' @param skip if the simulation is done with Behavior Space tool it has to skip the 6 first lines
#'
#' @return a data.frame 
#' @export
#'
#' @examples
read_netlogo_simul <- function(fname,skip=6){
  require(readr)
  mdl <- read_csv(fname,skip=skip)
  
  nam <- names(mdl)
  nam <- gsub("-","_",nam)
  nam <- gsub("[][]","",nam)
  nam <- gsub(" ","_",nam)
  names(mdl) <- nam
  return(mdl)
}

#
# 
#
#' Calculate error from predicted values
#' 
#' It takes two datframes and assummes they have a column named Date
#'
#' @param x dataframe with simulations
#' @param y dataframe with data
#'
#' @return
#' @export
#'
#' @examples
pred_err <- function(x,y) {
  da <- inner_join(x,y, by=c("Date" = "Date") )
  da <- da %>% mutate(year=year(Date)) %>% group_by(year) %>% summarise(burned_by_month=max(burned_by_month),total_patch=max(total_patch))
  data.frame(rmse=sqrt(sum((da$burned_by_month - da$total_patch)^2)/nrow(da)),mabe=sum(abs(da$burned_by_month - da$total_patch))/nrow(da),corr=cor(da$burned_by_month, da$total_patch))
}



#' Evaluate patch distribution from netlogo list of patch sizes output "[]"
#'
#' @param br string with a netlogo list with [] and separated by blanks
#'
#' @return a data frame with results
#' @export
#'
#' @examples
netlogo_evaluate_patch_distr <- function(br) {
  pp <-  str_remove_all(br, "[\\[\\]]") %>% str_split(" ") %>% unlist() %>% as.numeric() 
  message(br)
  if( length(unique(pp))>2) {
    evaluate_patch_distr( pp ) %>% mutate(max_patch=max(pp),tot_patch=sum(pp),num_patch=length(pp))
  } else {
    tibble(date=NA,  type=NA, expo=NA,rate=NA,  xmin=NA,  AICc=NA, range=NA)
  }
}



#' Coarse graining using majority rule 
#' 
#' We assume the matrix is 0 and 1 
#' If subsize^2 is even when the value is equal to subsize^2 / 2 
#' we chose the value at random 
#'
#' @param mat numeric matrix with 0 and 1s
#' @param subsize coarse grain factor e.g. if 2 divide the size by 2
#'
#' @return a matriz `ncol(mat) / 2` by `nrow(mat) / 2`
#' @export
#'
#' @examples
coarse_grain_mr <- function(mat, subsize=2) {
  
  # Integer division (round down to nearest integer). We convert to (int) 
  # as mat.n_rows may be a uword.
  nr <- trunc(nrow(mat) / subsize)
  nc <- trunc(ncol(mat) / subsize)
  
  reduced_matrix <- matrix(0,nrow=nr, ncol=nc)
  mrule <-  floor(subsize * subsize / 2 )
  even  <- ((subsize * subsize) %% 2) == 0 
  # Fill in values of the submatrix
  for ( j in seq_len(nc) ) {
    for (  i in seq_len(nr) ) {
      
      # Compute mean of the corresponding cells in the original matrix
      sum <- 0.0;
      for ( l in seq.int(((j-1)*subsize)+1,(j*subsize))) {
        for ( k in seq.int(((i-1)*subsize)+1,(i*subsize)) ) {
          sum <- sum + mat[k,l]
        }
      }
      if( sum > mrule )
        reduced_matrix[i,j] <-  1
      else if( even && sum==mrule){
        rr <-  runif(1)
        if(rr>0.5)
          reduced_matrix[i,j] <-  1
        else
          reduced_matrix[i,j] <-  0
        #Rcout << "Even: " << reduced_matrix(i,j) << "\n" ;
      } else {
        reduced_matrix[i,j] <-  0
      }
    }
  }
  
  return( reduced_matrix )
}
