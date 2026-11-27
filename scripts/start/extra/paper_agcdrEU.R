# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: agri-CDR runs for EU and global
# (treecover + SCM + biochar, adapted to single-realization
#  jan23 with s59_scm_mode and 63_biochar exo_oct26)
# --------------------------------------------------------

library(magpie4)
library(magclass)

version <- "EUCDR-23"

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

### input data: rev4.138+new4p139, two families (h12 and FSEC)
inputSets <- c(H12 = "h12", FSEC = "FSEC")
# LPJmL ssp245 run (all mitigation scenarios here are SSP2-based)
cellularSsp245 <- function(fam) {
  paste0("rev4.138+new4p139_", fam,
         "_1b5c3817_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1.tgz")
}

### REMIND version for pollutant prices and 2nd generation bioenergy demand
# *** TO DECIDE: which REMIND generation to use ***
remindVersion <- "R34M410"
if (remindVersion == "R34M410") {
  prices <- c(npi = "R34M410-SSP2-NPi2025",
              deg2 = "R34M410-SSP2-PkBudg1000",
              deg15 = "R34M410-SSP2-PkBudg650")
} else if (remindVersion == "R36M414") {
  prices <- c(npi = "R36M414-SSP2-NPi2025",
              deg2 = "R36M414-SSP2-PkBudg1000",
              deg15 = "R36M414-SSP2-PkBudg750")
} else {stop("unknown remindVersion")}

EU_countries <- c("ALA", "AUT", "BEL", "BGR", "CYP", "CZE", "DEU", "DNK", "ESP",
                  "EST", "FIN", "FRA", "FRO", "GBR", "GGY", "GIB", "GRC", "HRV",
                  "HUN", "IMN", "IRL", "ITA", "JEY", "LTU", "LUX", "LVA", "MLT",
                  "NLD", "POL", "PRT", "ROU", "SVK", "SVN", "SWE")

EU_countries_noUK <- setdiff(EU_countries, "GBR")

### agroforestry settings
cfg$gms$som                     <- "cellpool_jan23"

cfg$gms$s29_treecover_scenario_start <- 2025   # def = 2025
cfg$gms$s29_treecover_scenario_target <- 2050   # def = 2050
cfg$gms$s29_fader_functional_form <- 1   # linear
cfg$gms$s29_treecover_keep <- 1          # keep them
cfg$gms$s29_treecover_plantation <- 1    # plantations
cfg$gms$s29_treecover_mode <- 1                  # absolute area target
cfg$gms$s29_treecover_reference_year <- 2025     # fixed reference year

### soil carbon management
cfg$gms$s59_scm_scenario_start  <- 2025   # def = 2025
cfg$gms$s59_scm_scenario_target <- 2050   # def = 2050
cfg$gms$s59_scm_mode               <- 1   # absolute area target with endogenous allocation
cfg$gms$s59_scm_reference_year  <- 2025   # fixed reference year
cfg$gms$s59_scm_max_share_per_cell <- 1   # max SCM share per cell

### biochar settings
cfg$gms$biochar                      <- "exo_oct26"
cfg$gms$c63_biochar_mode             <- "mag-exo"
cfg$gms$s63_bc_yield_response_max    <- 0   # no yield response
cfg$gms$c63_biochar_prod             <- "stylized"
cfg$gms$s63_bcScen_stylized_startyear <- 2025
cfg$gms$s63_bcScen_stylized_targetyear <- 2050
cfg$gms$s63_bcScen_stylized_functional_form <- 1

miti      <- c("npi", "2deg", "1p5deg")
agfScen   <- c(agfZero = 0, agfLow = 0.015, agfHigh = 0.03, agfTwic = 0.06) # 1.5%/3%/6% cropland share treecover
scmScen   <- c(scmZero = 0, scmLow= 0.15,   scmHigh = 0.3,  scmTwic = 0.6)  # 15%/30%/60% cropland SOCM share
bcScen    <- c(bcZero = 0,  bcLow = 325,    bcHigh = 650,   bcTwic = 1300)  # 325/650/1100 PJ biochar prod
cdrSet    <- c("eu")
tradeScen <- c(bilateral = "selfsuff_reduced_bilateral22")

# for bilateral trade cropping pattern differ a lot, so residues for 2nd BE drive demand for crops
# for now switch them off!
cfg$gms$c60_res_2ndgenBE_dem <- "off"
# residues diverted to biochar fully replaced by dedicated crops -> bioenergy stays as before
cfg$gms$s60_res_substitution_factor <- 1

mitiPrice <- c(npi = "npi", "2deg" = "deg2", "1p5deg" = "deg15")

.title <- function(version = NULL, inp = NULL, miti = NULL, agf = NULL, scm = NULL, bc = NULL, trd = NULL){
  return(paste(version, inp, miti, agf, scm, bc, trd, sep = "_"))
}

for (inp in names(inputSets)){

  fam <- inputSets[[inp]]
  # FSEC regionalisation excludes the UK from EUR, H12 includes it
  cdrRegions <- list(glo = all_iso_countries,
                     eu = if (inp == "FSEC") EU_countries_noUK else EU_countries)
  cfg$input["regional"]   <- paste0("rev4.138+new4p139_", fam, "_magpie.tgz")
  cfg$input["cellular"]   <- cellularSsp245(fam)
  cfg$input["validation"] <- paste0("rev4.138+new4p139_", fam, "_92e02314_validation.tgz")

  for(scen in miti){
    for (cdrReg in cdrSet){
      for (trd in names(tradeScen)){

        # mitigation scenario: SSP2-based, prices from selected REMIND version
        if (scen == "npi") {
          cfg <- gms::setScenario(cfg, c("SSP2", "NPI", "rcp2p6"))
        } else if (scen %in% c("2deg", "1p5deg")) {
          cfg <- gms::setScenario(cfg, c("SSP2", "NDC", "rcp2p6"))
        } else {stop("wrong miti setup")}
        cfg$gms$c56_mute_ghgprices_until <- "y2030"
        cfg$gms$c56_pollutant_prices <- prices[mitiPrice[scen]]
        cfg$gms$c60_2ndgen_biodem    <- prices[mitiPrice[scen]]

        .startRun <- function(agf, scm, bc) {
          cfg$gms$trade              <- tradeScen[trd]
          cfg$gms$policy_countries29 <- cdrRegions[[cdrReg]]
          cfg$gms$s29_treecover_target <- agfScen[agf]

          cfg$gms$policy_countries59  <- cdrRegions[[cdrReg]]
          cfg$gms$s59_scm_target      <- scmScen[scm]

          cfg$gms$scen_countries63    <- cdrRegions[[cdrReg]]
          cfg$gms$s63_bcScen_stylized_target <- bcScen[bc]

          cfg$title <- .title(version, inp, scen, agf, scm, bc, trd)
          start_run(cfg, codeCheck = FALSE)
        }

        #ZeroZeroZero
        .startRun("agfZero", "scmZero", "bcZero")
        #ZeroZeroLow
        .startRun("agfZero", "scmZero", "bcLow")
        #ZeroLowZero
        .startRun("agfZero", "scmLow", "bcZero")
        #LowZeroZero
        .startRun("agfLow", "scmZero", "bcZero")
        #LowLowLow
        .startRun("agfLow", "scmLow", "bcLow")
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
  }
}
