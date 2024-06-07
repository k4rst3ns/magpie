# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test SOC und residues
# ----------------------------------------------------------


######################################
#### Script to start a MAgPIE run ####
######################################

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")


cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$gms$c56_pollutant_prices <- paste0("R21M42-SSP2-NPi")
cfg$gms$c60_2ndgen_biodem    <- paste0("R21M42-SSP2-NPi")

cfg$gms$som <- "threepool_may23" 
cfg$title <- "SSP2-REF-threepool"
start_run(cfg, codeCheck = FALSE)

cfg <- setScenario(cfg,c("SSP2","NDC"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$gms$c56_pollutant_prices <- paste0("R21M42-SSP2-PkBudg900")
cfg$gms$c60_2ndgen_biodem    <- paste0("R21M42-SSP2-PkBudg900")

cfg$gms$som <- "threepool_may23" 
cfg$title <- "SSP2-PkBudg900-threepool"
start_run(cfg, codeCheck = FALSE)

cfg$s60_scale_res2ndgenBE <- 0
cfg$gms$som <- "threepool_may23"
cfg$title <- "SSP2-PkBudg900-threepool_0x2ndRes"
start_run(cfg, codeCheck = FALSE)

cfg$s60_scale_res2ndgenBE <- 2
cfg$gms$som <- "threepool_may23"
cfg$title <- "SSP2-PkBudg900-threepool_2x2ndRe"
start_run(cfg, codeCheck = FALSE)

cfg$s60_scale_res2ndgenBE <- 5
cfg$gms$som <- "threepool_may23"
cfg$title <- "SSP2-PkBudg900-threepool_5x2ndRe"
start_run(cfg, codeCheck = FALSE)
