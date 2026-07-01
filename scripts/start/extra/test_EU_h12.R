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
rev <- "04"

cfg$input['regional']    <- "rev4.130EUtest_h12_magpie.tgz"
cfg$input['validation']  <- "rev4.130EUtest_h12_92e02314_validation.tgz"
cfg$input['calibration'] <- "calibration_H12_12Mar26.tgz"
cfg$input['cellular']    <- "rev4.130EUtest_h12_1b5c3817_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1.tgz"
cfg$input['additional']  <- "additional_data_rev4.67.tgz" #NPI/NDC fix for EUN

############ old selfsuff_reduced trade ##########

trade <- "oldTrade"

cfg$title <- paste(dev, rev, "defaultNPi2025", trade, sep = "-")
start_run(cfg)

cfg$title <- paste(dev, rev, "NDC", trade, sep = "-")
cfg       <- gms::setScenario(cfg, "NDC")
start_run(cfg)

cfg$title <- paste(dev, rev, "PkBu1000", trade, sep = "-")
cfg       <- gms::setScenario(cfg, "NDC")
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$gms$c56_pollutant_prices <- "R34M410-SSP2-PkBudg1000"
cfg$gms$c60_2ndgen_biodem    <- "R34M410-SSP2-PkBudg1000"
start_run(cfg)

############ bilateral trade ##########

trade <- "bilateral"
source("config/default.cfg")
cfg$input['regional']    <- "rev4.130EUtest_h12_magpie.tgz"
cfg$input['validation']  <- "rev4.130EUtest_h12_92e02314_validation.tgz"
cfg$input['calibration'] <- "calibration_H12_12Mar26.tgz"
cfg$input['cellular']    <- "rev4.130EUtest_h12_1b5c3817_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1.tgz"
cfg$input['additional']  <- "additional_data_rev4.64.tgz" #NPI/NDC fix for EUN
cfg$gms$trade <- "selfsuff_reduced_bilateral22"

cfg$title <- paste(dev, rev, "defaultNPi2025", trade, sep = "-")
start_run(cfg)

cfg$title <- paste(dev, rev, "NDC", trade, sep = "-")
cfg       <- gms::setScenario(cfg, "NDC")
start_run(cfg)

cfg$title <- paste(dev, rev, "PkBu1000", trade, sep = "-")
cfg       <- gms::setScenario(cfg, "NDC")
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$gms$c56_pollutant_prices <- "R34M410-SSP2-PkBudg1000"
cfg$gms$c60_2ndgen_biodem    <- "R34M410-SSP2-PkBudg1000"
start_run(cfg)

