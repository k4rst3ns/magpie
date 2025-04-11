*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' The AG crop residue biomass `vm_res_biomass_ag` is calculated as a function
*' of harvested area `vm_area` and production `vm_prod_reg`. `f18_cgf` contains
*' slope and intercept parameters of the CGFs.

 q18_prod_res_ag_reg(i2,kcr,w,dm_cnr) ..
                 vm_res_biomass_ag(i2,kcr,w,dm_cnr)
                 =e=
                 (sum(cell(i2,j2), vm_area(j2,kcr,w)) * sum(ct,f18_multicropping(ct,i2)) * f18_cgf("intercept",kcr)
                 + sum(cell(i2,j2), vm_prod_kcr_w(j2,kcr,w)) * f18_cgf("slope",kcr))
                 * f18_attributes_residue_ag(dm_cnr,kcr);

*' The BG crop residue biomass `vm_res_biomass_bg` is calculated as a function of
*' total aboveground biomass.

 q18_prod_res_bg_reg(i2,kcr,w,dm_cnr) ..
                 vm_res_biomass_bg(i2,kcr,w,dm_cnr)
                 =e=
                 (sum(cell(i2,j2), vm_prod_kcr_w(j2,kcr,w)) + 
                   vm_res_biomass_ag(i2,kcr,w,"dm")) * f18_cgf("bg_to_ag",kcr)
                 * f18_attributes_residue_bg(dm_cnr,kcr);

*' In contrast to AG biomass, AG production `vm_res_biomass_ag(i,kcr,w,dm_cnr)`
*' is defined as the part of residues which is removed from the field. The
*' difference between biomass and production is either burned on field or
*' remains on the fields (either incorporated in soils or not) and decays.
*' The field balance equations ensures that the production of AG residues
*' `vm_res_biomass_ag(i,kcr,w,dm_cnr)` is properly assigned to different uses:
*' removal, on-field burning and recycling of AG residues.

 q18_res_field_balance(i2,kcr,w,dm_cnr) ..
                  vm_res_biomass_ag(i2,kcr,w,dm_cnr)
                  =e=
                  v18_res_ag_removal(i2,kcr,w,dm_cnr)
                  + vm_res_ag_burn(i2,kcr,w,dm_cnr)
                  + v18_res_ag_recycling(i2,kcr,w,dm_cnr);

*' The amount of residues burned on fields in a region `vm_res_ag_burn` is
*' determined by the share (ic18_res_use_min_shr) of AG residue biomass.
*' Based on @smil_nitrogen_1999, residue burning is fixed to 15% of total AG
*' crop residue dry matter in developed and 25% in developing regions for each
*' crop. For future time steps, these rates are scenario dependent, and either
*' kept constant or reduced to 10% and 0% in 2050.

 q18_res_field_burn(i2,kcr,w,dm_cnr) ..
                  vm_res_ag_burn(i2,kcr,w,dm_cnr)
                  =e=
                  sum(ct, im_development_state(ct,i2) * i18_res_use_burn(ct,"high_income",kcr)
                  + (1-im_development_state(ct,i2)) * i18_res_use_burn(ct,"low_income",kcr))
                  * vm_res_biomass_ag(i2,kcr,w,dm_cnr);


*' While the residue biomass is estiamted with a crop-specific nutrient
*' composition (which is required for consistent nutrient budgets), the
*' removed residues are assumed to have homogeneous properties
*' (to reduce the number of commodities in MAgPIE) within three crop residue
*' groups (cereal straw, fibrous residues that cannot be digested
*' by monogastrics, and non-fibrous residues that can be digested).
*' The following constraint, in combination with the field balance equation,
*' guarantees that mass balances are not violated while a homogeneous
*' good is extracted from heterogeneous goods.


 q18_translate(i2,kres,dm_cnr)..
                  sum((kres_kcr(kres,kcr),w), v18_res_ag_removal(i2,kcr,w,dm_cnr))
                  =e=
                  vm_prod_reg(i2,kres) * fm_attributes(dm_cnr,kres);

*' Amount produced at cellular level is flexible, can be distributed as it wants 

 q18_prod_res_reg(i2,kres)..
                  sum(cell(i2,j2), v18_prod_res(j2,kres))
                  =e=
                  vm_prod_reg(i2,kres);

*' Residues recycled to croplands in nutrients `vm_res_recycling(i2,"nr")` are
*' calcualted based on the amount of AG residues left on field for recycling, the
*' nutrients coming from burned residues, and on biomass that is left in
*' BG residues. They are calculated to be transmitted to the nitrogen budget
*' module [50_nr_soil_budget].

 q18_res_recycling_cnr(i2,kcr,w,dm_cnr) ..
                  vm_res_recycling(i2,kcr,w,dm_cnr)
                  =e=
                  v18_res_ag_recycling(i2,kcr,w,dm_cnr)
                    + vm_res_ag_burn(i2,kcr,w,dm_cnr)*(1-f18_res_combust_eff(kcr))
                    + vm_res_biomass_bg(i2,kcr,w,dm_cnr)
                  ;

*' Costs of residue harvest are based on straw baling and hauling from 
*' Budynski, Stephanie. 2020. Straw Manufacturing in Alberta (@budynski_straw_2020), 
*' using the lower range of the US costs.

 q18_cost_prod_res(i2,kres) ..
                  vm_cost_prod_kres(i2,kres)
                  =e=
                  vm_prod_reg(i2,kres) * fm_attributes("wm",kres)  *  f18_fac_req_kres(kres);

*' Trade of AG residues is not considered, so that all produced AG residues have
*' to be assigned to uses within the respective world region.

*** EOF constraints.gms ***
