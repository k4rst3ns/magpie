# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: calculate and store new calibration factors
# --------------------------------------------------------

library(magpie4)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
calib_ini<-c("ON","OFF")
vmprod_ini<-c("ON","OFF")

realizations<-c("sticky_feb18","mixed_feb17","fixed_per_ton_mar18")
type<-NULL



for(r in realizations){
  for(ci in calib_ini){
    for(vmi in vmprod_ini){

    type<-if (r=="sticky_feb18") c("free","dynamic") else "_"

    for(t in type){

      if(initialization){

      cfg$input<-if(ci=="ON") cfg$input else if(ci=="OFF") cfg$input[names(cfg$input)!="calibration"] else stop("Not a valid option")
      cfg$results_folder <- "output/:title:"
      cfg$recalibrate <- TRUE
      cfg$title <- paste("calib_run",r,t,"CIn",ci,"vmIn",vmi,sep="_")
      cfg$gms$c_timesteps <- 1
      cfg$output <- c("rds_report")
      cfg$sequential <- TRUE

      cfg$gms$factor_costs     <-   r
      cfg$gms$c38_sticky_mode  <-   t
      cfg$gms$c38_prod_init    <-   vmi

      start_run(cfg,codeCheck=FALSE)
      magpie4::submitCalibration(paste("H12",r,t,"Ini",ci,sep="_"))}
     }
    }
}
