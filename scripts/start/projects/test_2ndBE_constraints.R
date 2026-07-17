# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: 2nd-generation bioenergy uptake constraints test runs
#              (Nestbeschmutzer paper: EROI / grass quality / food-vs-fuel
#              rotation cap / technology change dampening)
# ----------------------------------------------------------

# NOTE: The four new switches below were implemented alongside this script.
# Switch names and domains (verified against this checkout):
#   1_eroi_farming/eroi_detail.md          -> s14_eroi_yield_penalty_max
#   2_grass_quality_issues/grass_quality_detail.md -> s60_begr_ge_discount
#   3_food_vs_fuel/food_vs_fuel_detail.md  -> s30_kbe_rotation_max_shr
#   4_yield_overestimation/yield_overestimation_detail.md -> s14_be_tau_share

library(magpie4)
library(magclass)

version <- "2ndBE-01_H12"

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

# ---- Scenario dimensions (4 levels each: Zero + Low/Med/High) --------------
# A/B: 0 = no effect, higher = more effect
# C/D: 1 = unchanged, lower = more effect (kept this direction deliberately,
#      see scenarios/scenario_detail.md for rationale)

eroiScen <- c(eroiZero = 0, eroiLow = 0.15, eroiMed = 0.3,  eroiHigh = 0.5)   # s14_eroi_yield_penalty_max
geScen   <- c(geZero   = 0, geLow   = 0.10, geMed   = 0.20, geHigh   = 0.50) # s60_begr_ge_discount
rotScen  <- c(rotZero  = 1, rotLow  = 0.10, rotMed  = 0.05, rotHigh  = 0.01)  # s30_kbe_rotation_max_shr
tauScen  <- c(tauZero  = 1, tauLow  = 0.75, tauMed  = 0.5,  tauHigh  = 0.25) # s14_be_tau_share

miti <- c("npi", "2deg", "1p5deg")

.title <- function(version, miti, eroi, ge, rot, tau) {
  return(paste(version, miti, eroi, ge, rot, tau, sep = "_"))
}

for (scen in miti) {

  if (scen == "npi") {
    cfg <- gms::setScenario(cfg, c("SSP2", "NPI", "rcp4p5"))
  } else if (scen == "2deg") {
    cfg <- gms::setScenario(cfg, c("SSP2", "NDC", "rcp2p6"))
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
    cfg$gms$c56_pollutant_prices <- "R34M410-SSP2-PkBudg1000"
    cfg$gms$c60_2ndgen_biodem    <- "R34M410-SSP2-PkBudg1000"
  } else if (scen == "1p5deg") {
    cfg <- gms::setScenario(cfg, c("SSP2", "NDC", "rcp2p6"))
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
    # PkBudg750 does not exist in Module 60's scenario set (verified against
    # modules/60_bioenergy/1st2ndgen_priced_feb24/sets.gms) - PkBudg650 is the
    # closest available carbon-budget option for a 1.5C-consistent case.
    cfg$gms$c56_pollutant_prices <- "R34M410-SSP2-PkBudg650"
    cfg$gms$c60_2ndgen_biodem    <- "R34M410-SSP2-PkBudg650"
  } else {stop("wrong miti setup")}

  .startRun <- function(eroi, ge, rot, tau, check = FALSE) {
    eroiVal <- eroiScen[eroi][[1]]
    geVal   <- geScen[ge][[1]]
    rotVal  <- rotScen[rot][[1]]
    tauVal  <- tauScen[tau][[1]]

    cfg$gms$s14_eroi_yield_penalty_max <- eroiVal
    cfg$gms$s60_begr_ge_discount       <- geVal
    cfg$gms$s30_kbe_rotation_max_shr   <- rotVal
    cfg$gms$s14_be_tau_share           <- tauVal

    fmt <- function(v) gsub("\\.", "p", sprintf("%g", v))

    cfg$title <- .title(version, scen, paste0("eroi", fmt(eroiVal)), paste0("ge", fmt(geVal)), paste0("rot", fmt(rotVal)), paste0("tau", fmt(tauVal)))
    start_run(cfg, codeCheck = check)
  }

  # REF - also serves as the compile check (codeCheck=TRUE) since all four
  # new equations/sets exist in the model regardless of switch value
  .startRun("eroiZero", "geZero", "rotZero", "tauZero", check = TRUE)

  # single-on sweeps (vary one dimension across Low/Med/High, others at Zero)
  for (lvl in c("Low", "Med", "High")) {
    .startRun(paste0("eroi", lvl), "geZero",           "rotZero",          "tauZero")
    .startRun("eroiZero",          paste0("ge", lvl),   "rotZero",          "tauZero")
    .startRun("eroiZero",          "geZero",            paste0("rot", lvl), "tauZero")
    .startRun("eroiZero",          "geZero",            "rotZero",          paste0("tau", lvl))
  }

  # ALL combined, at High
  .startRun("eroiHigh", "geHigh", "rotHigh", "tauHigh")

}
