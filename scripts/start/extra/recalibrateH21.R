# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: calculate and store new land conversion cost calibration factors for default setup (time consuming; up to 40 model runs with 5 time steps)
# --------------------------------------------------------

library(magpie4)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
cfg$input['regional']    <- "rev4.130EUtest_2b1450bc_magpie.tgz"
cfg$input['validation']  <- "rev4.130EUtest_2b1450bc_e5902f5f_validation.tgz"
cfg$input['calibration'] <- "calibration_H21_FAO_30Jul25.tgz"
cfg$input['cellular']    <- "rev4.130EUtest_2b1450bc_f4a4836c_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1_clusterweight-42ca0ffb.tgz"

cfg$results_folder <- "output/:title:"
cfg$recalibrate <- FALSE
cfg$recalibrate_landconversion_cost <- TRUE
cfg$title <- "calib_run_H16"
cfg$output <- c("rds_report")
cfg$force_replace <- TRUE
cfg$qos <- "priority"
start_run(cfg,codeCheck=FALSE)
magpie4::submitCalibration("H21_EUtest")
