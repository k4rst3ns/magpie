*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


parameters
 pm_land_start(j,land)         Land initialization area (mio. ha)
 pcm_land(j,land)              Land area in previous time step (mio. ha)
;

variables
 vm_landdiff    Aggregated difference in land between current and previous time step (mio. ha)
;

positive variables
 vm_land(j,land)                  Land area of the different land types (mio. ha)
 vm_landexpansion(j,land)         Land expansion (mio. ha)
 v10_landreduction(j,land)        Land reduction (mio. ha)
 vm_croplandreduction(j,land)    dummy
 vm_croplandexpansion(j,land)   dummy
 vm_cost_land_transition(j)		  Costs for lu transitions (mio. USD05MER per yr)
;

equations
 q10_land(j)                    Land conversion constraint (mio. ha)
 q10_landexpansion(j,land)      Land expansion constraint (mio. ha)
 q10_landreduction(j,land)      Land reduction constraint (mio. ha)
 q10_croplandreduction(j,land)  dummy
 q10_croplandreduction2(j,land) dummy ..
 q10_croplandexpansion(j,land)  dummy
 q10_croplandexpansion2(j,land) dummy
 q10_landdiff                   Land difference constraint (mio. ha)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_landdiff(t,type)                    Aggregated difference in land between current and previous time step (mio. ha)
 ov_land(t,j,land,type)                 Land area of the different land types (mio. ha)
 ov_landexpansion(t,j,land,type)        Land expansion (mio. ha)
 ov10_landreduction(t,j,land,type)      Land reduction (mio. ha)
 ov_croplandreduction(t,j,land,type)    dummy
 ov_croplandexpansion(t,j,land,type)    dummy
 ov_cost_land_transition(t,j,type)      Costs for lu transitions (mio. USD05MER per yr)
 oq10_land(t,j,type)                    Land conversion constraint (mio. ha)
 oq10_landexpansion(t,j,land,type)      Land expansion constraint (mio. ha)
 oq10_landreduction(t,j,land,type)      Land reduction constraint (mio. ha)
 oq10_croplandreduction(t,j,land,type)  dummy
 oq10_croplandreduction2(t,j,land,type) dummy ..
 oq10_croplandexpansion(t,j,land,type)  dummy
 oq10_croplandexpansion2(t,j,land,type) dummy
 oq10_landdiff(t,type)                  Land difference constraint (mio. ha)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
