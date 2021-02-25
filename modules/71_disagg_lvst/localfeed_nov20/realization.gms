*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @description The localfeed_nov20 is transported related.

*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/71_disagg_lvst/localfeed_nov20/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/71_disagg_lvst/localfeed_nov20/declarations.gms"
$Ifi "%phase%" == "input" $include "./modules/71_disagg_lvst/localfeed_nov20/input.gms"
$Ifi "%phase%" == "equations" $include "./modules/71_disagg_lvst/localfeed_nov20/equations.gms"
$Ifi "%phase%" == "presolve" $include "./modules/71_disagg_lvst/localfeed_nov20/presolve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/71_disagg_lvst/localfeed_nov20/postsolve.gms"
*######################## R SECTION END (PHASES) ###############################
