# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: test runs for EUR using h12 setup
# --------------------------------------------------------

library(magpie4)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
dev <- "EURtestsH12"
rev <- "01"

cfg$title <- paste(dev, rev, "defaultNPi2025", sep = "-")
start_run(cfg)

cfg$title <- paste(dev, rev, "NDC", sep = "-")
cfg       <- setScenario(cfg, "NDC")
start_run(cfg)

cfg$title <- paste(dev, rev, "PkBu1000", sep = "-")
cfg       <- setScenario(cfg, "NDC")
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$gms$c56_pollutant_prices <- "R34M410-SSP2-PkBudg1000"
cfg$gms$c60_2ndgen_biodem    <- "R34M410-SSP2-PkBudg1000"
start_run(cfg)

~                                                                                                                                                                                                                  
~                                                
