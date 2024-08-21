# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------
# description: start run with default.cfg settings and different SOC for cropland
# position: 1
# ------------------------------------------------

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
cfg$title <- "default+newCropSOC_totalPNV"
cfg$input <- c(regional    = "rev4.111+newCropSOC_totalPNV_h12_magpie.tgz",
               cellular    = "WARNINGS1_rev4.111+newCropSOC_totalPNV_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
               validation  = "WARNINGS3_rev4.111+newCropSOC_totalPNV_h12_validation.tgz",
               additional  = "additional_data_rev4.51.tgz",
               calibration = "calibration_H12_26Mar24.tgz")
start_run(cfg)

source("config/default.cfg")
cfg$title <- "default+newCropSOC_PotForest"
cfg$input <- c(regional    = "rev4.111+newCropSOC_PotForest_h12_magpie.tgz",
               cellular    = "WARNINGS1_rev4.111+newCropSOC_PotForest_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
               validation  = "WARNINGS3_rev4.111+newCropSOC_PotForest_h12_validation.tgz",
               additional  = "additional_data_rev4.51.tgz",
               calibration = "calibration_H12_26Mar24.tgz")
start_run(cfg)

