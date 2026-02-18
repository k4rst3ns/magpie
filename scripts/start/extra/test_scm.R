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

cdrRegions <- list(glo = all_iso_countries, eu = EU_countries)

### General settings
cfg <- gms::setScenario(cfg, c("SSP2", "NPI", "rcp2p6"))

### SCM settings
cfg$gms$s59_scm_scenario_start  <- 2025   # def = 2025
cfg$gms$s59_scm_scenario_target <- 2050   # def = 2050            

# Define test scenarios
# Note: Both realizations now have the same features, feb26 is kept for comparison
scmRealization <- c("cellpool_jan23", "cellpool_feb26")
scmTarget      <- c(scmZero = 0, scmLow = 0.15, scmHigh = 0.30)  # 0%, 15%, 30% cropland SCM share
scmRefYear     <- c(dynamic = -1, ref2020 = 2020, ref2025 = 2025)  # -1=dynamic, or fixed year
cdrRegion      <- c("eu", "glo")

.title <- function(version = NULL, realization = NULL, target = NULL, refYear = NULL, region = NULL){
  return(paste(version, realization, target, refYear, region, sep = "_"))
}

for (realization in scmRealization) {
  cfg$gms$som <- realization
  
  for (cdrReg in cdrRegion) {
    cfg$gms$policy_countries59 <- cdrRegions[[cdrReg]]
    
    for (targetName in names(scmTarget)) {
      targetValue <- scmTarget[targetName]
      cfg$gms$s59_scm_target <- targetValue
      
      for (refYearName in names(scmRefYear)) {
        refYearValue <- scmRefYear[refYearName]
        
        # Skip fixed reference year tests when SCM target is zero (no point)
        if (targetValue == 0 && refYearValue > 0) {
          next
        }
        
        # Set reference year
        cfg$gms$c59_scm_reference_year <- refYearValue
        
        cfg$title <- .title(version, realization, targetName, refYearName, cdrReg)
        start_run(cfg, codeCheck = FALSE)
      }
    }
  }
}
