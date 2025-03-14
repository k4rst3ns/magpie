*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*****************************
*** SOC initialisation    ***
*****************************

i59_subsoilc_density(t_all, j) = 
  fm_carbon_density(t_all, j, "secdforest", "soilc") - f59_topsoilc_density(t_all, j);
  

pcm_carbon_stock(j, land, "soilc", stockType) = 
 fm_carbon_density("y1995", j, land, "soilc") * pm_land_start(j, land);

vm_carbon_stock.l(j, land, "soilc", stockType) =
  pcm_carbon_stock(j, land, "soilc", stockType);

p59_land_before(j,land) = pm_land_start(j,land);

*****************************
*** parameter dummies     ***
*****************************

i59_cinput_multiplier_residue(i,sPools59,kcr) = 
  sum(kcr2$(sameas(kcr,kcr2)), 
    sum(kcr_tillage59(kcr2,tillage59), 
      f59_cinput_multiplier_residue(i,sPools59,kcr,tillage59)));

