# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")

cfg$input <- c("magpie4.1_default_apr19.tgz", "additional_data_rev3.68.tgz",
               "LPJmL5-IPSL_CM5A_LR-rcp2p6_rev40_c200_690d3718e151be1b450b394c1064b1c5.tgz",
               "rev4.21_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev4.21_690d3718e151be1b450b394c1064b1c5_validation.tgz")

cfg$recalibrate <- TRUE

cfg$title    <- "lpjml5_lai_calib"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$recalibrate <- FALSE

cfg<-lucode::setScenario(cfg,"cc")
cfg$title    <- "lpjml5_lai_calib_cc"
start_run(cfg=cfg,codeCheck=TRUE)
