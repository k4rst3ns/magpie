# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: Test different SCM configurations
# position: 99
# --------------------------------------------------------

library(magpie4)
library(magclass)

version <- "SCMtest-01"

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

EU_countries <- c("ALA", "AUT", "BEL", "BGR", "CYP", "CZE", "DEU", "DNK", "ESP", 
                  "EST", "FIN", "FRA", "FRO", "GBR", "GGY", "GIB", "GRC", "HRV", 
                  "HUN", "IMN", "IRL", "ITA", "JEY", "LTU", "LUX", "LVA", "MLT", 
                  "NLD", "POL", "PRT", "ROU", "SVK", "SVN", "SWE")

### SCM settings
cfg$gms$s59_scm_scenario_start  <- 2025   # def = 2025
cfg$gms$s59_scm_scenario_target <- 2050   # def = 2050            
cfg$gms$policy_countries59      <- EU_countries

# Mitigation scenarios
mitiScenarios <- c("npi", "rcp2p6")

.title <- function(version = NULL, miti = NULL, scmConfig = NULL){
  return(paste(version, miti, scmConfig, sep = "_"))
}

for (scen in mitiScenarios) {
  
  if (scen == "npi") {
    # NPi - BAU
    cfg <- gms::setScenario(cfg, c("SSP2", "NPI", "rcp2p6"))
    
  } else if (scen == "rcp2p6") {
    # 2° - MAU
    cfg <- gms::setScenario(cfg, c("SSP2", "NDC", "rcp2p6"))
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-SSP2-PkBudg1000")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-SSP2-PkBudg1000")
    
  } else {
    stop("wrong miti setup")
  }
  
  # Run 1: No SCM with old cellpool_jan23
  cfg$gms$som <- "cellpool_jan23"
  cfg$gms$s59_scm_target <- 0
  cfg$title <- .title(version, scen, "jan23_noSCM")
  start_run(cfg, codeCheck = FALSE)
  
  # Run 2: No SCM with new cellpool_feb26
  cfg$gms$som <- "cellpool_feb26"
  cfg$gms$s59_scm_target <- 0
  cfg$gms$s59_scm_reference_year <- -1
  cfg$title <- .title(version, scen, "feb26_noSCM")
  start_run(cfg, codeCheck = FALSE)
  
  # Run 3: cellpool_jan23 with 0.3 share
  cfg$gms$som <- "cellpool_jan23"
  cfg$gms$s59_scm_target <- 0.3
  cfg$title <- .title(version, scen, "jan23_scm30pct")
  start_run(cfg, codeCheck = FALSE)
  
  # Run 4: cellpool_feb26 with fixed reference year 2025 and 0.3 share
  cfg$gms$som <- "cellpool_feb26"
  cfg$gms$s59_scm_target <- 0.3
  cfg$gms$s59_scm_reference_year <- 2025
  cfg$title <- .title(version, scen, "feb26_scm30pct_ref2025")
  start_run(cfg, codeCheck = FALSE)
  
  # Run 5: cellpool_feb26 with dynamic (-1) and 0.3 share
  cfg$gms$som <- "cellpool_feb26"
  cfg$gms$s59_scm_target <- 0.3
  cfg$gms$s59_scm_reference_year <- -1
  cfg$title <- .title(version, scen, "feb26_scm30pct_dynamic")
  start_run(cfg, codeCheck = FALSE)
}

