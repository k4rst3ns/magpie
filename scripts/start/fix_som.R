
# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")

### Runs without CC

cfg$title   <- "BAU_static_som_nocc"
cfg$gms$som <- "static_jan19"
cfg$gms$c59_static_spatial_level <-  "cluster"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "BAU_dynamic_som_irr_nocc"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "BAU_dynamic_som_nocc"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario <- "off"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"

cfg$title   <- "SSP2-26-SPA2_static_som_nocc"
cfg$gms$som <- "static_jan19"
cfg$gms$c59_static_spatial_level <-  "cluster"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "SSP2-26-SPA2_dynamic_som_irr_nocc"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "SSP2-26-SPA2_dynamic_som_nocc"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario <- "off"
start_run(cfg=cfg,codeCheck=TRUE)

### Runs with CC

#CC
cfg$gms$c14_yields_scenario   <- "cc"
cfg$gms$c42_watdem_scenario   <- "cc"
cfg$gms$c43_watavail_scenario <- "cc"
cfg$gms$c52_carbon_scenario   <- "cc"
cfg$gms$c59_som_scenario      <- "cc" 

cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"

cfg$title   <- "BAU_static_som_cc"
cfg$gms$som <- "static_jan19"
cfg$gms$c59_static_spatial_level <-  "cluster"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "BAU_dynamic_som_irr_nocc"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "BAU_dynamic_som_cc"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario <- "off"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"

cfg$title   <- "SSP2-26-SPA2_static_som_cc"
cfg$gms$som <- "static_jan19"
cfg$gms$c59_static_spatial_level <-  "cluster"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "SSP2-26-SPA2_dynamic_som_irr_cc"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "SSP2-26-SPA2_dynamic_som_cc"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario <- "off"
start_run(cfg=cfg,codeCheck=TRUE)

