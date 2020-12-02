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

gdx <- path(outputdir,"fulldata.gdx")
production(gdx,file=paste0(outputdir,"LivestockProductionMap.nc"),level="grid",products="kli",dir=outputdir)
