# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Creates livestock production maps as nc files
# comparison script: FALSE
# ---------------------------------------------------------------

library(lucode2)
library(magpie4)
library(mrcommons)

gdx <- path(outputdir,"fulldata.gdx")
MagProduction  <- production(gdx,level="grid",products="kli",dir=outputdir)

load(path(outputdir,"config.Rdata"))

rev   <- cfg$input[setdiff(grep("magpie",cfg$input),grep("cellular",cfg$input))]
cache <- gsub("(.+?)(\\_.*)","\\1", rev)
setConfig(cachefolder = paste0("/p/projects/rd3mod/inputdata/cache/",cache), force = TRUE)


histProduction <- collapseNames(calcOutput("LivestockGridded", aggregate = FALSE)[,,"dm"])

doubleYears <- intersect(getYears(histProduction,as.integer=TRUE),getYears(MagProduction,as.integer=TRUE))
beforeMag   <- setdiff(getYears(histProduction,as.integer=TRUE),getYears(MagProduction,as.integer=TRUE))

getCells(MagProduction) <- getCells(histProduction)

out  <- mbind(         histProduction[,beforeMag,],
              setYears(histProduction[,doubleYears,], doubleYears-1),
                        MagProduction)

write.magpie(out, path(outputdir,"LivestockProductionMap.nc"))

