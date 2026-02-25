# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: test runs for EUR using h16 setup
# --------------------------------------------------------

library(magpie4)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
dev <- "EURtestsH16"
rev <- "01"

cfg$input['regional']    <- "rev4.127DCBilatTest2_36f73207_magpie.tgz"
cfg$input['validation']  <- "rev4.127DCBilatTest2_36f73207_92e02314_validation.tgz"
cfg$input['calibration'] <- "calibration_H16_FAO_20Jun25.tgz"
cfg$input['cellular']    <- "rev4.127DCBilatTest2_36f73207_582d657c_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1_clusterweight-ba4466a8.tgz"

cfg$output[[match("rds_report", cfg$output)]] <- "extra/rds_report_eu_h16"

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
