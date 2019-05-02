
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

cfg$title   <- "BAU_dynamic_som_irr_nocc"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"

cfg$title   <- "SSP2-26-SPA2_dynamic_som_irr_soilon"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
cfg$gms$c56_emis_policy <- "soilon" 		# def = ssp
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "SSP2-26-SPA2_dynamic_som_irr_soiloff"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
cfg$gms$c56_emis_policy <- "soiloff" 		# def = ssp
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "SSP2-26-SPA2_dynamic_som_irr_ssp"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c56_emis_policy <- "ssp" 		# def = ssp
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "SSP2-26-SPA2_dynamic_som_irr_all"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
cfg$gms$c56_emis_policy <- "all" 		# def = ssp
start_run(cfg=cfg,codeCheck=TRUE)
