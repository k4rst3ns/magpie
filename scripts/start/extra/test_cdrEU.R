# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: agri-CDR runs for EU and global
# --------------------------------------------------------

library(magpie4)
library(magclass)

version <- "EUCDR-15abs"

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

EU_countries <- c("ALA", "AUT", "BEL", "BGR", "CYP", "CZE", "DEU", "DNK", "ESP", 
                  "EST", "FIN", "FRA", "FRO", "GBR", "GGY", "GIB", "GRC", "HRV", 
                  "HUN", "IMN", "IRL", "ITA", "JEY", "LTU", "LUX", "LVA", "MLT", 
                  "NLD", "POL", "PRT", "ROU", "SVK", "SVN", "SWE")

cdrRegions <- list(glo = all_iso_countries, eu = EU_countries)     

### agroforestry settings
cfg$gms$s29_treecover_scenario_start <- 2025   # def = 2025
cfg$gms$s29_treecover_scenario_target <- 2050   # def = 2050
cfg$gms$s29_fader_functional_form <- 1   # linear
cfg$gms$s29_treecover_keep <- 1          # keep them
cfg$gms$s29_treecover_plantation <- 1    # plantations
cfg$gms$s29_treecover_reference_year <- 2025   # fixed reference year for absolute target ### NEW SETTING

### soil carbon management
cfg$gms$s59_scm_scenario_start  <- 2025   # def = 2025
cfg$gms$s59_scm_scenario_target <- 2050   # def = 2050
cfg$gms$s59_scm_reference_year  <- 2025   # fixed reference year for absolute target ### NEW SETTING
cfg$gms$s59_scm_max_share_per_cell <- 1   # max SCM share per cell ### NEW SETTING

### biochar settings
cfg$gms$c63_biochar_simulation_mode <- "mag"
cfg$gms$c63_biochar_prod <- "stylized"
cfg$gms$s63_bcScen_stylized_startyear <- 2025
cfg$gms$s63_bcScen_stylized_targetyear <- 2050
cfg$gms$s63_bc_yield_response_max <- 0 

miti      <- c("npi", "rcp2p6")
agfScen   <- c(agfZero = 0, agfHigh = 0.03, agfTwic = 0.06) # 3%/6% cropland share treecover
scmScen   <- c(scmZero = 0, scmHigh = 0.3,  scmTwic = 0.6)  # 30%/60% cropland SOCM share
bcScen    <- c(bcZero = 0,  bcHigh = 550,   bcTwic = 1100)  # 550/1100 PJ biochar prod
regionSet <- c("h12")
cdrSet    <- c("eu", "glo")

.title <- function(version = NULL, miti = NULL, agf = NULL, scm = NULL, bc = NULL, cdr = NULL){
  return(paste(version, miti, agf, scm, bc, cdr, sep = "_"))
}

for(scen in miti){
  for (cdrReg in c("eu", "glo")){     
    
    if(scen == "npi") {

      # NPi - BAU
      cfg <- gms::setScenario(cfg, c("SSP2", "NPI", "rcp2p6"))

    } else if (scen == "rcp2p6") {

      # 2° - MAU
      cfg <- gms::setScenario(cfg, c("SSP2", "NDC", "rcp2p6"))
      cfg$gms$c56_mute_ghgprices_until <- "y2030"
      cfg$gms$c56_pollutant_prices <- paste0("R34M410-SSP2-PkBudg1000")
      cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-SSP2-PkBudg1000")

    } else {stop("wrong miti setup")}
 
      .startRun <- function(agf, scm, bc) {
      cfg$gms$policy_countries29   <- cdrRegions[[cdrReg]]
      cfg$gms$s29_treecover_target <- agfScen[agf]

      cfg$gms$policy_countries59  <- cdrRegions[[cdrReg]]
      cfg$gms$s59_scm_target      <- scmScen[scm]

      cfg$gms$scen_countries63    <- cdrRegions[[cdrReg]]
      cfg$gms$s63_bcScen_stylized_target <- bcScen[bc]

      cfg$title <- .title(version, scen, agf, scm, bc, cdrReg)
      start_run(cfg, codeCheck = FALSE)
    } 

    #ZeroZeroZero
    .startRun("agfZero", "scmZero", "bcZero")
    #ZeroZeroHigh      
    .startRun("agfZero", "scmZero", "bcHigh")
    #ZeroHighZero
    .startRun("agfZero", "scmHigh", "bcZero")
    #HighLowLow
    .startRun("agfHigh", "scmZero", "bcZero")
    #HighHighHigh
    .startRun("agfHigh", "scmHigh", "bcHigh")
    #TwicTwicTwic
    .startRun("agfTwic", "scmTwic", "bcTwic")
    #ZeroZeroTwic
    .startRun("agfZero", "scmZero", "bcTwic")
    #ZeroTwicZero
    .startRun("agfZero", "scmTwic", "bcZero")
    #TwicZeroZero
    .startRun("agfTwic", "scmZero", "bcZero")
      
  }
}
