# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Extract biomass supply and potential data from multiple MAgPIE runs
# comparison script: TRUE
# ---------------------------------------------------------------

# Version 1.1, Kristine Karstens

library(lucode2)
library(magclass)
library(magpie4)
library(gms)

options(error = function() traceback(2))

############################# BASIC CONFIGURATION #############################
if (!exists("source_include")) {
  outputdir <- file.path("output/", list.dirs("output/", full.names = FALSE, recursive = FALSE))
  lucode2::readArgs("outputdir")
}
###############################################################################

cat("\n====== Biomass for REMIND - MAgPIE Data Extraction ======\n")

# Parameter specs for 2nd gen BE crop residues
# (collectionFraction, minDensityForExtraction)
.cropResSpecs <- list(
  cf0p3_md0 = c(collectionFraction = 0.3, minDensityForExtraction = 0),
  cf0p3_md2 = c(collectionFraction = 0.3, minDensityForExtraction = 2),
  cf0p3_md4 = c(collectionFraction = 0.3, minDensityForExtraction = 4),
  cf0p1_md4 = c(collectionFraction = 0.1, minDensityForExtraction = 4)
)

addScen <- function(x, scen) {
  addDim(x, dim = 3.1, dimName = "scenario", item = scen)
}

expandYears <- function(x, years) {
  if (all(years %in% getYears(x))) return(x[, years, ])
  template <- new.magpie(cells_and_regions = getCells(x), years = years, names = getNames(x))
  template[, getYears(x), ] <- x
  return(template)
}

.writeOut <- function(x, filename) {
  if (is.null(x)) { warning("No data for: ", filename); return(invisible(NULL)) }
  write.csv(as.data.frame(x, rev = 3), 
            file.path("output", paste0(filename, ".csv")),
            row.names = FALSE)
}

# Loop over all scenarios, apply extractFn(gdx, shortScen) for each, combine
# all results, and write to filename in one go.
collectOutput <- function(validDirs, scenarios, scenMap, extractFn, filename) {
  results <- NULL
  for (i in seq_along(validDirs)) {
    shortScen <- scenMap[[scenarios[i]]]
    cat(" ", shortScen, "...\n")
    results <- mbind(results, extractFn(file.path(validDirs[i], "fulldata.gdx"), shortScen))
  }
  .writeOut(results, filename)
}

# ---- Per-output extract functions --------------------------------------------

extractSupply <- function(gdx, shortScen) {
  woodFuel   <- reportWoodFuel(gdx)
  manureFuel <- reportManureFuel(gdx)
  allYears   <- sort(unique(c(getYears(woodFuel), getYears(manureFuel))))
  mbind(
    addScen(expandYears(woodFuel,   allYears), shortScen),
    addScen(expandYears(manureFuel, allYears), shortScen)
  )
}

extractCropRes <- function(gdx, shortScen) {
  specResults <- lapply(names(.cropResSpecs), function(specName) {
    params <- .cropResSpecs[[specName]]
    res <- reportCropResidues2ndBE(gdx,
                                   collectionFraction      = params["collectionFraction"],
                                   minDensityForExtraction = params["minDensityForExtraction"])
    res <- addDim(res, dim = 3.1, dimName = "spec", item = specName)
    addScen(res, shortScen)
  })
  allYears <- sort(unique(unlist(lapply(specResults, getYears))))
  mbind(lapply(specResults, expandYears, years = allYears))
}

extractWoodRes <- function(gdx, shortScen) {
  addScen(reportProcessingWoodResidues(gdx), shortScen)
}

extractBiogas <- function(gdx, shortScen) {
  addScen(reportBiogasFeedstock(gdx), shortScen)
}

# ---- Pass 1: scan configs to collect scenario names --------------------------
scenarios <- character(0)
validDirs <- character(0)
missing   <- character(0)

for (dir in outputdir) {
  gdx <- file.path(dir, "fulldata.gdx")
  if (!file.exists(gdx)) { missing <- c(missing, dir); next }
  cfg       <- gms::loadConfig(file.path(dir, "config.yml"))
  scenarios <- c(scenarios, cfg$title)
  validDirs <- c(validDirs, dir)
}

if (length(missing) > 0) warning("Runs with missing fulldata.gdx: ", paste(missing, collapse = ", "))

# ---- Compute shortened scenario names ----------------------------------------
shortScens <- mip::shorten_legend(scenarios, identical_only = TRUE, sep = c(" ", "-", "|", "_"))
scenMap    <- setNames(shortScens, scenarios)

cat("\nScenario name mapping:\n")
for (i in seq_along(scenarios)) cat(" ", scenarios[i], "->", shortScens[i], "\n")

# ---- Pass 2: extract each output across all scenarios ------------------------
cat("\n-- Supply (wood fuel + manure fuel) --\n")
collectOutput(validDirs, scenarios, scenMap, extractSupply, "biomass_supply")

cat("\n-- Potential crop residues --\n")
collectOutput(validDirs, scenarios, scenMap, extractCropRes, "biomass_potential_cropres")

cat("\n-- Potential wood processing residues --\n")
collectOutput(validDirs, scenarios, scenMap, extractWoodRes, "biomass_potential_woodres")

cat("\n-- Biogas feedstock potential --\n")
collectOutput(validDirs, scenarios, scenMap, extractBiogas, "biomass_potential_biogas")

cat("\n====== Biomass Extraction Complete ======\n")
