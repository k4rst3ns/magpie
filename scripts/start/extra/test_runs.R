# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------
# description: test run for new (MAgPIE4.4) version
# ------------------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")
source("scripts/start/extra/lpjml_addon.R")

# * (fixed_per_ton_mar18): factor costs fixed per ton
# * (mixed_feb17):         reimplementation of MAgPIE 3.0 default
# * (sticky_feb18)         factor costs including investments in capital
cfg$gms$factor_costs    <- "mixed_feb17"        # default = mixed_feb17
cfg$gms$c38_sticky_mode <- "dynamic"            # options = free, dynamic

yld_past_switch <- c(p0=0, p0p15=0.15, p0p25=0.25, p0p4=0.4)
limit_calib     <- c(puRel=0, limit=1)
init_irrig      <- c("LUH2v2", "Siebert")

for (p in 1:length(yld_past_switch)) {
  for (c in 1:length(limit_calib)) {
    for (i in 1:length(init_irrig)) {
      
      cfg$gms$s14_yld_past_switch <- yld_past_switch[p]
      cfg$gms$s14_limit_calib     <- limit_calib[c]      
      cfg$gms$c41_initial_irrigation_area  <- init_irrig[i]
      cfg$title <- paste0("TRKK01_","mixed",
                          "_ps-", names(yld_past_switch[p]),
                          "_lc-", names(limit_calib[c]), 
                          "_ii-", init_irrig[i])
      #print(cfg$title)
      start_run(cfg=cfg)
    }
  }
}

