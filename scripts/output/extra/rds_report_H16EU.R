# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: extract report aggregated to H16EU regions in rds and mif format from run
# comparison script: FALSE
# position: 4
# ---------------------------------------------------------------


library(magclass)
library(magpie4)
library(lucode2)
library(quitte)
library(gms)
library(piamInterfaces)
library(piamutils)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if (!exists("source_include")) {
  outputdir <- "/p/projects/landuse/users/miodrag/projects/tests/flexreg/output/H12_setup1_2016-11-23_12.38.56/"
  readArgs("outputdir")
}

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
gdx <- file.path(outputdir, "fulldata.gdx")
rds <- paste0(outputdir, "/report_H16EU.rds")
mif <- paste0(outputdir, "/report_H16EU.mif")
# mapping file aggregating H16 MAgPIE regions to H16EU reporting regions;
# expected in the working directory from which the script is executed
h16eu_mapping <- "regionmappingH16EUAgg_report.csv"
###############################################################################


report <- getReport(gdx, scenario = cfg$title, level = h16eu_mapping)
if (!all(grepl(" \\(([^\\()]*)\\)($|\\.)", getNames(report, fulldim = TRUE)$variable))) {
  warning("Variables should be in the format 'name (unit)' (the space between name and unit is important), ",
          "but the following are not:\n",
          paste(grep(" \\(([^\\()]*)\\)($|\\.)", getNames(report, fulldim = TRUE)$variable,
                     invert = TRUE, value = TRUE), collapse = "\n"))
}

for (mapping in c("AR6", "NAVIGATE", "SHAPE", "AR6_MAgPIE")) {
  missingVariables <- sort(setdiff(unique(deletePlus(getMappingVariables(mapping, "M"))),
                                   unique(deletePlus(getNames(report, dim = "variable")))))
  if (length(missingVariables) > 0) {
    warning("# The following ", length(missingVariables), " variables are expected in the piamInterfaces package ",
            "for mapping ", mapping, ", but cannot be found in the MAgPIE report.\n",
            "Please either fix in magpie4 or adjust the mapping in piamInterfaces.\n- ",
            paste(missingVariables, collapse = ",\n- "), "\n")
  }
}

write.report(report, file = mif)

qu <- as.quitte(report)
# as.quitte converts "World" into "GLO". But we want to keep "World" and therefore undo these changes
qu <- droplevels(qu)
levels(qu$region)[levels(qu$region) == "GLO"] <- "World"
qu$region <- factor(qu$region, levels = sort(levels(qu$region)))

if (all(is.na(qu$value))) {
  stop("No values in reporting!")
}

saveRDS(qu, file = rds, version = 2)
