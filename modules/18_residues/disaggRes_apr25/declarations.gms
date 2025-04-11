*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


positive variables
 v18_prod_res(j,kres)                       Cellular production of residues (mio. tDM)
 vm_res_biomass_ag(i,kcr,w,dm_cnr)      Production of aboveground residues in each region (mio. tDM)
 vm_res_biomass_bg(i,kcr,w,dm_cnr)          Production of belowground residues in each region (mio. tDM)
 vm_res_ag_burn(i,kcr,w,dm_cnr)         Residues burned on fields in respective attribute units DM GJ Nr P K WM C (mio. tX)
 vm_res_recycling(i,kcr,w,dm_cnr)       Residues recycled to croplands in respective nutrients Nr P K units (mio. tX)
 vm_cost_prod_kres(i,kres)                  Production costs of harvesting crop residues (mio. USD17MER per yr)
 v18_res_ag_removal_clust(j,kcr,w,dm_cnr)   Removal of crop residues in respective attribute units DM GJ Nr P K WM C (mio. tX)
 v18_res_ag_recycling_clust(j,kcr,w,dm_cnr) Recylcing of crop residues to soils in respective attribute units DM GJ Nr P K WM C (mio. tX)
;

variables
 v18_res_biomass_ag_clust(j,kcr,w,dm_cnr)   Production of aboveground residues in each cluster (mio. tDM)
 v18_res_biomass_bg_clust(j,kcr,w,dm_cnr)   Production of belowground residues in each cluster (mio. tDM)
 v18_res_ag_burn_clust(j,kcr,w,dm_cnr)      Residues burned on fields in respective attribute units DM GJ Nr P K WM C in each cluster (mio. tX)
 v18_res_recycling_clust(j,kcr,w,dm_cnr)    Residues recycled to croplands in respective nutrients Nr P K units in each cluster (mio. tX)
;

equations
 q18_prod_res_ag_clust(j,kcr,w,dm_cnr)        Production constraint of aboveground residues (mio. tDM)
 q18_sumreg_res_biomass_ag(i,kcr,w,dm_cnr)    Regional above-ground residue biomass (mio. tX per yr)
 q18_prod_res_bg_clust(j,kcr,w,dm_cnr)            Production constraint of belowground residues (mio. tDM)
 q18_sumreg_res_biomass_bg(i,kcr,w,dm_cnr)        Regional below-ground residue biomass (mio. tX per yr)
 q18_res_field_balance_clust(j,kcr,w,dm_cnr)  Calculation of the residues amount recycled to soils (mio. tDM)
 q18_res_field_burn_clust(j,kcr,w,dm_cnr)     Fixing of the residues amount burned in a cluster in respective attribute units DM GJ Nr P K WM C (mio. tX)
 q18_sumreg_res_biomass_burn(i,kcr,w,dm_cnr)  Regional burned residue biomass (mio. tX per yr)
 q18_translate(j,kres,dm_cnr)           Transformation of the multiple crop residues into supply balance crop redisues in respective attribute units DM GJ Nr P K WM C (mio. tX) 
 q18_prod_res_cell(i,kres)                  Allows for distribution of residues to cellular level (mio. tDM)
 q18_res_recycling_cnr_clust(j,kcr,w,c_nr)        Nutrient recycling of carbon and reaactive nitrogen (mio. tX)
 q18_res_recycling_pk_clust(j,kcr,w,pk18)         Nutrient recycling of phosphorus and potash (mio. tX) 
 q18_sumreg_res_recycling(i,kcr,w,cnpk18)     Regional recycled residue biomass (mio. tX per yr)
 q18_cost_prod_res(i,kres)                  Production costs of harvesting crop residues (mio. USD17MER)
;

parameters
 i18_res_use_burn(t_all,dev18,kcr)          Share of residues burned on field (1)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov18_prod_res(t,j,kres,type)                            Cellular production of residues (mio. tDM)
 ov_res_biomass_ag(t,i,kcr,w,dm_cnr,type)            Production of aboveground residues in each region (mio. tDM)
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,type)                Production of belowground residues in each region (mio. tDM)
 ov_res_ag_burn(t,i,kcr,w,dm_cnr,type)               Residues burned on fields in respective attribute units DM GJ Nr P K WM C (mio. tX)
 ov_res_recycling(t,i,kcr,w,dm_cnr,type)             Residues recycled to croplands in respective nutrients Nr P K units (mio. tX)
 ov_cost_prod_kres(t,i,kres,type)                        Production costs of harvesting crop residues (mio. USD17MER per yr)
 ov18_res_ag_removal_clust(t,j,kcr,w,dm_cnr,type)    Removal of crop residues in respective attribute units DM GJ Nr P K WM C (mio. tX)
 ov18_res_ag_recycling_clust(t,j,kcr,w,dm_cnr,type)  Recylcing of crop residues to soils in respective attribute units DM GJ Nr P K WM C (mio. tX)
 ov18_res_recycling_clust(t,j,kcr,w,dm_cnr,type)     Residues recycled to croplands in respective nutrients Nr P K units in each cluster (mio. tX)
 ov18_res_biomass_ag_clust(t,j,kcr,w,dm_cnr,type)    Production of aboveground residues in each cluster (mio. tDM)
 ov18_res_biomass_bg_clust(t,j,kcr,w,dm_cnr,type)    Production of belowground residues in each cluster (mio. tDM)
 ov18_res_ag_burn_clust(t,j,kcr,w,dm_cnr,type)       Residues burned on fields in respective attribute units DM GJ Nr P K WM C in each cluster (mio. tX)
 oq18_prod_res_ag_clust(t,j,kcr,w,dm_cnr,type)       Production constraint of aboveground residues (mio. tDM)
 oq18_sumreg_res_biomass_ag(t,i,kcr,w,dm_cnr,type)   Regional above-ground residue biomass (mio. tX per yr)
 oq18_prod_res_bg_clust(t,j,kcr,w,dm_cnr,type)           Production constraint of belowground residues (mio. tDM)
 oq18_sumreg_res_biomass_bg(t,i,kcr,w,dm_cnr,type)       Regional below-ground residue biomass (mio. tX per yr)
 oq18_res_field_balance_clust(t,j,kcr,w,dm_cnr,type) Calculation of the residues amount recycled to soils (mio. tDM)
 oq18_res_field_burn_clust(t,j,kcr,w,dm_cnr,type)    Fixing of the residues amount burned in a cluster in respective attribute units DM GJ Nr P K WM C (mio. tX)
 oq18_sumreg_res_biomass_burn(t,i,kcr,w,dm_cnr,type) Regional burned residue biomass (mio. tX per yr)
 oq18_translate(t,j,kres,dm_cnr,type)                Transformation of the multiple crop residues into supply balance crop redisues in respective attribute units DM GJ Nr P K WM C (mio. tX)
 oq18_prod_res_cell(t,i,kres,type)                       Allows for distribution of residues to cellular level (mio. tDM)
 oq18_res_recycling_cnr_clust(t,j,kcr,w,c_nr,type)       Nutrient recycling of carbon and reaactive nitrogen (mio. tX)
 oq18_res_recycling_pk_clust(t,j,kcr,w,pk18,type)        Nutrient recycling of phosphorus and potash (mio. tX)
 oq18_sumreg_res_recycling(t,i,kcr,w,cnpk18,type)        Regional recycled residue biomass (mio. tX per yr)
 oq18_cost_prod_res(t,i,kres,type)                       Production costs of harvesting crop residues (mio. USD17MER)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################

*** EOF declarations.gms ***
