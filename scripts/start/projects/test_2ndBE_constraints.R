# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: 2nd-generation bioenergy uptake constraints test runs v5
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################

library(magpie4)
library(magclass)

version <- "BE05"

source("scripts/start_functions.R")
source("config/default.cfg")

# ---- Scenario dimensions ---------------------------------------------------

eroiScen <- c(eroiZero = 0,    eroiLow = 0.15, eroiHigh = 0.5)
geScen   <- c(geZero   = 0,    geLow   = 0.05, geHigh  = 0.15)
rotScen  <- c(rotZero  = 1,    rotLow  = 0.30, rotHigh = 0.10)
tauScen  <- c(tauZero  = 1,    tauLow  = 0.75, tauHigh = 0.50)

biodemScen <- c(dem20 = 20, dem50 = 50, dem100 = 100, dem200 = 200,
                dem300 = 300, dem400 = 400, dem500 = 500, dem600 = 600)
tradeScen  <- c(def = "selfsuff_reduced",
                bil = "selfsuff_reduced_bilateral22")
pastScen   <- c(woPS = 0, wiPS = 0.25)

# ---- 2-degree scenario setup (fixed across all runs) --------------------

cfg <- gms::setScenario(cfg, c("SSP2", "NDC", "rcp2p6"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$gms$c56_pollutant_prices <- "R34M410-SSP2-PkBudg1000"
cfg$gms$c60_2ndgen_biodem <- "emulator"
cfg$gms$c60_biodem_level <- 0
cfg$output <- c("rds_report")

# ---- Constraint combinations (11 patterns) ------------------------------

combos <- list(
  c("eroiZero", "geZero", "rotZero", "tauZero"),
  c("eroiLow",  "geZero", "rotZero", "tauZero"),
  c("eroiHigh", "geZero", "rotZero", "tauZero"),
  c("eroiZero", "geLow",  "rotZero", "tauZero"),
  c("eroiZero", "geHigh", "rotZero", "tauZero"),
  c("eroiZero", "geZero", "rotLow",  "tauZero"),
  c("eroiZero", "geZero", "rotHigh", "tauZero"),
  c("eroiZero", "geZero", "rotZero", "tauLow"),
  c("eroiZero", "geZero", "rotZero", "tauHigh"),
  c("eroiLow",  "geLow",  "rotLow",  "tauLow"),
  c("eroiHigh", "geHigh", "rotHigh", "tauHigh")
)

# ---- Format helper ------------------------------------------------------

fmt <- function(v) gsub("\\.", "p", sprintf("%g", v))

# ---- Main loop ----------------------------------------------------------

firstRun <- TRUE

for (t in names(tradeScen)) {

  cfg$gms$trade <- tradeScen[t]

  for (p in names(pastScen)) {

    cfg$gms$s14_yld_past_switch <- pastScen[p]

    for (b in names(biodemScen)) {

      cfg$gms$s60_biodem_scaler <- biodemScen[b]

      for (i in seq_along(combos)) {

        eroi <- combos[[i]][1]
        ge   <- combos[[i]][2]
        rot  <- combos[[i]][3]
        tau  <- combos[[i]][4]

        cfg$gms$s14_eroi_yield_penalty_max <- eroiScen[eroi]
        cfg$gms$s60_begr_ge_discount       <- geScen[ge]
        cfg$gms$s30_kbe_rotation_max_shr   <- rotScen[rot]
        cfg$gms$s14_be_tau_share           <- tauScen[tau]

        cfg$title <- paste(
          version, t, p,
          paste0("dem", fmt(biodemScen[b])),
          paste0("eroi", fmt(eroiScen[eroi])),
          paste0("ge",   fmt(geScen[ge])),
          paste0("rot",  fmt(rotScen[rot])),
          paste0("tau",  fmt(tauScen[tau])),
          sep = "_"
        )

        start_run(cfg, codeCheck = firstRun)
        firstRun <- FALSE
      }
    }
  }
}
