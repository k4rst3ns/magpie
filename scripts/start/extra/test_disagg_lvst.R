# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# ----------------------------------------------------------
# description: Start a set of runs with different disagg livestock realizations
# ----------------------------------------------------------

library(gms)
library(magclass)
library(gdx)
library(magpie4)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

cfg$recalibrate <- TRUE

cfg$title             <- "localfeed_transport0_pasture5"
cfg$gms$disagg_lvst   <- "localfeed_nov20"
cfg$gms$s71_transport <- 0
cfg$gms$s40_pasture_transport_costs <- 5
start_run(cfg)

cfg$title             <- "localfeed_transport0_pasture0"
cfg$gms$disagg_lvst   <- "localfeed_nov20"
cfg$gms$s71_transport <- 0
cfg$gms$s40_pasture_transport_costs <- 0
start_run(cfg)

cfg$title             <- "localfeed_transport1_pasture5"
cfg$gms$disagg_lvst   <- "localfeed_nov20"
cfg$gms$s71_transport <- 1
cfg$gms$s40_pasture_transport_costs <- 5
start_run(cfg)

cfg$title             <- "localfeed_transport2_pasture5"
cfg$gms$disagg_lvst   <- "localfeed_nov20"
cfg$gms$s71_transport <- 2
cfg$gms$s40_pasture_transport_costs <- 5
start_run(cfg)

cfg$title             <- "localfeed_transport3_pasture5"
cfg$gms$disagg_lvst   <- "localfeed_nov20"
cfg$gms$s71_transport <- 3
cfg$gms$s40_pasture_transport_costs <- 5
start_run(cfg)

cfg$title             <- "foragebased_pasture0"
cfg$gms$disagg_lvst   <- "foragebased_aug18"
cfg$gms$s40_pasture_transport_costs <- 0
start_run(cfg)
