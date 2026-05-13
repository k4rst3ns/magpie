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

# Version 1.0, Kristine Karstens

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

addScen <- function(x, scen) addDim(x, dim = 3.1, dimName = "scenario", item = scen)

expandYears <- function(x, years) {
  if (all(years %in% getYears(x))) return(x[, years, ])
  template <- new.magpie(cells_and_regions = getCells(x), years = years, names = getNames(x))
  template[, getYears(x), ] <- x
  return(template)
}

# Apply a full->short name mapping by fixed-string substitution on magpie names
applyScenMap <- function(x, mapping) {
  nms <- getNames(x)
  for (full in names(mapping)) nms <- gsub(full, mapping[full], nms, fixed = TRUE)
  getNames(x) <- nms
  x
}

supply    <- NULL
cropRes   <- NULL
woodRes   <- NULL
biogas    <- NULL
scenarios <- NULL
missing   <- NULL

for (i in seq_along(outputdir)) {
  gdx <- file.path(outputdir[i], "fulldata.gdx")
  if (!file.exists(gdx)) {
    missing <- c(missing, outputdir[i])
    next
  }

  cfg  <- gms::loadConfig(file.path(outputdir[i], "config.yml"))
  scen <- cfg$title
  cat("Processing", scen, "...\n")
  scenarios <- c(scenarios, scen)

  # ---- Output 1: Supply (wood fuel + manure fuel) --------------------------------
  woodFuel   <- reportWoodFuel(gdx)
  manureFuel <- reportManureFuel(gdx)
  allYears   <- sort(unique(c(getYears(woodFuel), getYears(manureFuel))))
  supply <- mbind(supply,
    addScen(expandYears(woodFuel,   allYears), scen),
    addScen(expandYears(manureFuel, allYears), scen)
  )

  # ---- Output 2: Potential crop residues (4 parameter specs) --------------------
  specResults <- lapply(names(.cropResSpecs), function(specName) {
    params <- .cropResSpecs[[specName]]
    res <- reportCropResidues2ndBE(gdx,
                                   collectionFraction      = params["collectionFraction"],
                                   minDensityForExtraction = params["minDensityForExtraction"])
    res <- addDim(res, dim = 3.1, dimName = "spec", item = specName)
    addScen(res, scen)
  })
  allYearsCR <- sort(unique(unlist(lapply(specResults, getYears))))
  cropRes <- mbind(cropRes, mbind(lapply(specResults, expandYears, years = allYearsCR)))

  # ---- Output 3: Potential wood processing residues -----------------------------
  woodRes <- mbind(woodRes, addScen(reportProcessingWoodResidues(gdx), scen))

  # ---- Output 4: Biogas feedstock potential -------------------------------------
  biogas <- mbind(biogas, addScen(reportBiogasFeedstock(gdx), scen))

  cat("✓", scen, "complete\n\n")
}

if (!is.null(missing)) {
  warning(paste0("Runs with missing fulldata.gdx:", missing))
}

# ---- Shorten scenario names to the differing part only -------------------------
shortScens <- mip::shorten_legend(scenarios, identical_only = TRUE, sep = c(" ", "-", "|", "_"))
scenMap    <- setNames(shortScens, scenarios)

cat("\nScenario name mapping:\n")
for (i in seq_along(scenarios)) cat(" ", scenarios[i], "->", shortScens[i], "\n")

supply  <- applyScenMap(supply,  scenMap)
cropRes <- applyScenMap(cropRes, scenMap)
woodRes <- applyScenMap(woodRes, scenMap)
biogas  <- applyScenMap(biogas,  scenMap)

# ---- Write collected outputs ---------------------------------------------------
.writeOut <- function(x, filename) {
  if (is.null(x)) {
    warning("No data for: ", filename)
    return(invisible(NULL))
  }
  write.report(x, file.path("output", filename), model = "MAgPIE")
}

cat("\n====== Writing outputs ======\n")
.writeOut(supply,  "biomass_supply.mif")
.writeOut(cropRes, "biomass_potential_cropres.mif")
.writeOut(woodRes, "biomass_potential_woodres.mif")
.writeOut(biogas,  "biomass_potential_biogas.mif")

cat("\n====== Biomass Extraction Complete ======\n")
