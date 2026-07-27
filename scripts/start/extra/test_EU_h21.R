# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: scenario runs for EUR using h21 setup
#              varying trade realizations, REMIND data versions,
#              and mitigation scenarios
# --------------------------------------------------------

library(magpie4)
library(magclass)

source("scripts/start_functions.R")
source("config/default.cfg")

dev <- "EURtestsH21"
rev <- "06"

cfg$input['regional']    <- "rev4.133EUtest_H21EU_magpie.tgz"
cfg$input['validation']  <- "rev4.133EUtest_H21EU_e5902f5f_validation.tgz"
cfg$input['calibration'] <- "calibration_H21EUtest_26Jul26.tgz"
cfg$input['cellular']    <- "rev4.133EUtest_H21EU_f4a4836c_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1_clusterweight-42ca0ffb.tgz"

cfg$output[[match("rds_report", cfg$output)]] <- "extra/rds_report_eu_h21"
cfg$results_folder <- "output/:title:"
cfg$force_replace  <- TRUE

remind <- c(old = "R34M410", new = "R36M414")
trade  <- c(oldTrade = "selfsuff_reduced", bilateral = "selfsuff_reduced_bilateral22")
miti   <- c("npi", "2deg", "1p5deg")

remindData <- list(
  R34M410 = c(npi = "NPi2025", `2deg` = "PkBudg1000", `1p5deg` = "PkBudg650"),
  R36M414 = c(npi = "NPi2025", `2deg` = "PkBudg1000", `1p5deg` = "PkBudg750")
)

for (remindVer in names(remind)) {
  for (trd in names(trade)) {
    for (scen in miti) {

      cfg$gms$trade <- trade[trd]

      if (scen == "npi") {
        # rcp excluded: setScenario would overwrite cfg$input['cellular'] with h12 default
        cfg <- gms::setScenario(cfg, c("SSP2", "NPI"))
      } else {
        # rcp excluded: setScenario would overwrite cfg$input['cellular'] with h12 default
        cfg <- gms::setScenario(cfg, c("SSP2", "NDC"))
      }

      cfg$gms$c56_mute_ghgprices_until     <- "y2030"
      cfg$gms$c56_pollutant_prices <- paste0(remind[remindVer], "-SSP2-", remindData[[remindVer]][scen])
      cfg$gms$c60_2ndgen_biodem    <- paste0(remind[remindVer], "-SSP2-", remindData[[remindVer]][scen])
      cfg$gms$c60_biodem_baseline  <- paste0(remind[remindVer], "-SSP2-NPi2025")

      if (trd == "bilateral") {
        cfg$gms$c60_res_2ndgenBE_dem <- "off"
      }

      cfg$title <- paste(dev, rev, scen, trd, remindVer, sep = "-")
      start_run(cfg, codeCheck = FALSE)
    }
  }
}
