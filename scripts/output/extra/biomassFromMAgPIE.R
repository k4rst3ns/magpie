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

addScen <- function(x, scen) add_dimension(x, dim = 3.1, add = "scenario", nm = scen)

expandYears <- function(x, years) {
  if (all(years %in% getYears(x))) return(x[, years, ])
  template <- new.magpie(cells_and_regions = getCells(x), years = years, names = getNames(x))
  template[, getYears(x), ] <- x
  return(template)
}

# Apply a full->short name mapping by fixed-string substitution on magpie names
applyScenMap <- function(lst, mapping) {
  lapply(lst, function(x) {
    nms <- getNames(x)
    for (full in names(mapping)) nms <- gsub(full, mapping[full], nms, fixed = TRUE)
    getNames(x) <- nms
    x
  })
}

supplyList  <- list()
cropResList <- list()
woodResList <- list()
biogasList  <- list()
missing     <- NULL

for (i in seq_along(outputdir)) {
  gdx <- file.path(outputdir[i], "fulldata.gdx")
  if (!file.exists(gdx)) {
    warning("GDX not found: ", gdx)
    missing <- c(missing, outputdir[i])
    next
  }

  cfg  <- gms::loadConfig(file.path(outputdir[i], "config.yml"))
  scen <- cfg$title
  cat("Processing", scen, "...\n")

  # ---- Output 1: Supply (wood fuel + manure fuel) --------------------------------
  woodFuel   <- reportWoodFuel(gdx)
  manureFuel <- reportManureFuel(gdx)
  allYears   <- sort(unique(c(getYears(woodFuel), getYears(manureFuel))))
  supplyList[[scen]] <- mbind(
    addScen(expandYears(woodFuel,   allYears), scen),
    addScen(expandYears(manureFuel, allYears), scen)
  )

  # ---- Output 2: Potential crop residues (4 parameter specs) --------------------
  specResults <- lapply(names(.cropResSpecs), function(specName) {
    params <- .cropResSpecs[[specName]]
    res <- reportCropResidues2ndBE(gdx,
                                    collectionFraction      = params["collectionFraction"],
                                    minDensityForExtraction = params["minDensityForExtraction"])
    res <- add_dimension(res, dim = 3.1, add = "spec", nm = specName)
    addScen(res, scen)
  })
  allYearsCR <- sort(unique(unlist(lapply(specResults, getYears))))
  cropResList[[scen]] <- mbind(lapply(specResults, expandYears, years = allYearsCR))

  # ---- Output 3: Potential wood processing residues -----------------------------
  woodRes <- reportProcessingWoodResidues(gdx)
  woodResList[[scen]] <- addScen(woodRes, scen)

  # ---- Output 4: Biogas feedstock potential -------------------------------------
  biogas <- reportBiogasFeedstock(gdx)
  biogasList[[scen]] <- addScen(biogas, scen)

  cat("\u2713", scen, "complete\n\n")
}

if (!is.null(missing)) {
  cat("\nRuns with missing fulldata.gdx:\n")
  print(missing)
}

# ---- Shorten scenario names to the differing part only -------------------------
allScens  <- names(supplyList)   # same set across all lists
shortScens <- mip::shorten_legend(allScens, identical_only = TRUE, sep = c(" ", "-", "|", "_"))
scenMap    <- setNames(shortScens, allScens)

cat("\nScenario name mapping:\n")
for (i in seq_along(allScens)) cat(" ", allScens[i], "->", shortScens[i], "\n")

supplyList  <- applyScenMap(supplyList,  scenMap)
cropResList <- applyScenMap(cropResList, scenMap)
woodResList <- applyScenMap(woodResList, scenMap)
biogasList  <- applyScenMap(biogasList,  scenMap)

# ---- Write collected outputs ---------------------------------------------------
.writeOut <- function(lst, filename) {
  if (length(lst) == 0) { warning("No data for: ", filename); return(invisible(NULL)) }
  out <- do.call(mbind, lst)
  write.report(out, file.path("output", filename), model = "MAgPIE")
  cat("Written: output/", filename, "\n", sep = "")
  return(invisible(out))
}

cat("\n====== Writing outputs ======\n")
.writeOut(supplyList,  "biomass_supply.mif")
.writeOut(cropResList, "biomass_potential_cropres.mif")
.writeOut(woodResList, "biomass_potential_woodres.mif")
.writeOut(biogasList,  "biomass_potential_biogas.mif")

cat("\n====== Biomass Extraction Complete ======\n")
