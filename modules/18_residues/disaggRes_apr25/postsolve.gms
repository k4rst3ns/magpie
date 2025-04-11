*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

****** Residues

*** EOF postsolve.gms ***

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov18_prod_res(t,j,kres,"marginal")                        = v18_prod_res.m(j,kres);
 ov_res_biomass_ag(t,i,kcr,w,dm_cnr,"marginal")            = vm_res_biomass_ag.m(i,kcr,w,dm_cnr);
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,"marginal")            = vm_res_biomass_bg.m(i,kcr,w,dm_cnr);
 ov_res_ag_burn(t,i,kcr,w,dm_cnr,"marginal")               = vm_res_ag_burn.m(i,kcr,w,dm_cnr);
 ov_res_recycling(t,i,kcr,w,dm_cnr,"marginal")             = vm_res_recycling.m(i,kcr,w,dm_cnr);
 ov_cost_prod_kres(t,i,kres,"marginal")                    = vm_cost_prod_kres.m(i,kres);
 ov18_res_ag_removal_clust(t,j,kcr,w,dm_cnr,"marginal")    = v18_res_ag_removal_clust.m(j,kcr,w,dm_cnr);
 ov18_res_ag_recycling_clust(t,j,kcr,w,dm_cnr,"marginal")  = v18_res_ag_recycling_clust.m(j,kcr,w,dm_cnr);
 ov18_res_biomass_ag_clust(t,j,kcr,w,dm_cnr,"marginal")    = v18_res_biomass_ag_clust.m(j,kcr,w,dm_cnr);
 ov18_res_biomass_bg_clust(t,j,kcr,w,dm_cnr,"marginal")    = v18_res_biomass_bg_clust.m(j,kcr,w,dm_cnr);
 ov18_res_ag_burn_clust(t,j,kcr,w,dm_cnr,"marginal")       = v18_res_ag_burn_clust.m(j,kcr,w,dm_cnr);
 ov18_res_recycling_clust(t,j,kcr,w,dm_cnr,"marginal")     = v18_res_recycling_clust.m(j,kcr,w,dm_cnr);
 oq18_prod_res_ag_clust(t,j,kcr,w,dm_cnr,"marginal")       = q18_prod_res_ag_clust.m(j,kcr,w,dm_cnr);
 oq18_sumreg_res_biomass_ag(t,i,kcr,w,dm_cnr,"marginal")   = q18_sumreg_res_biomass_ag.m(i,kcr,w,dm_cnr);
 oq18_prod_res_bg_clust(t,j,kcr,w,dm_cnr,"marginal")       = q18_prod_res_bg_clust.m(j,kcr,w,dm_cnr);
 oq18_sumreg_res_biomass_bg(t,i,kcr,w,dm_cnr,"marginal")   = q18_sumreg_res_biomass_bg.m(i,kcr,w,dm_cnr);
 oq18_res_field_balance_clust(t,j,kcr,w,dm_cnr,"marginal") = q18_res_field_balance_clust.m(j,kcr,w,dm_cnr);
 oq18_res_field_burn_clust(t,j,kcr,w,dm_cnr,"marginal")    = q18_res_field_burn_clust.m(j,kcr,w,dm_cnr);
 oq18_sumreg_res_biomass_burn(t,i,kcr,w,dm_cnr,"marginal") = q18_sumreg_res_biomass_burn.m(i,kcr,w,dm_cnr);
 oq18_translate(t,j,kres,dm_cnr,"marginal")                = q18_translate.m(j,kres,dm_cnr);
 oq18_prod_res_cell(t,i,kres,"marginal")                   = q18_prod_res_cell.m(i,kres);
 oq18_res_recycling_cnr_clust(t,j,kcr,w,c_nr,"marginal")   = q18_res_recycling_cnr_clust.m(j,kcr,w,c_nr);
 oq18_res_recycling_pk_clust(t,j,kcr,w,pk18,"marginal")    = q18_res_recycling_pk_clust.m(j,kcr,w,pk18);
 oq18_sumreg_res_recycling(t,i,kcr,w,cnpk18,"marginal")    = q18_sumreg_res_recycling.m(i,kcr,w,cnpk18);
 oq18_cost_prod_res(t,i,kres,"marginal")                   = q18_cost_prod_res.m(i,kres);
 ov18_prod_res(t,j,kres,"level")                           = v18_prod_res.l(j,kres);
 ov_res_biomass_ag(t,i,kcr,w,dm_cnr,"level")               = vm_res_biomass_ag.l(i,kcr,w,dm_cnr);
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,"level")               = vm_res_biomass_bg.l(i,kcr,w,dm_cnr);
 ov_res_ag_burn(t,i,kcr,w,dm_cnr,"level")                  = vm_res_ag_burn.l(i,kcr,w,dm_cnr);
 ov_res_recycling(t,i,kcr,w,dm_cnr,"level")                = vm_res_recycling.l(i,kcr,w,dm_cnr);
 ov_cost_prod_kres(t,i,kres,"level")                       = vm_cost_prod_kres.l(i,kres);
 ov18_res_ag_removal_clust(t,j,kcr,w,dm_cnr,"level")       = v18_res_ag_removal_clust.l(j,kcr,w,dm_cnr);
 ov18_res_ag_recycling_clust(t,j,kcr,w,dm_cnr,"level")     = v18_res_ag_recycling_clust.l(j,kcr,w,dm_cnr);
 ov18_res_biomass_ag_clust(t,j,kcr,w,dm_cnr,"level")       = v18_res_biomass_ag_clust.l(j,kcr,w,dm_cnr);
 ov18_res_biomass_bg_clust(t,j,kcr,w,dm_cnr,"level")       = v18_res_biomass_bg_clust.l(j,kcr,w,dm_cnr);
 ov18_res_ag_burn_clust(t,j,kcr,w,dm_cnr,"level")          = v18_res_ag_burn_clust.l(j,kcr,w,dm_cnr);
 ov18_res_recycling_clust(t,j,kcr,w,dm_cnr,"level")        = v18_res_recycling_clust.l(j,kcr,w,dm_cnr);
 oq18_prod_res_ag_clust(t,j,kcr,w,dm_cnr,"level")          = q18_prod_res_ag_clust.l(j,kcr,w,dm_cnr);
 oq18_sumreg_res_biomass_ag(t,i,kcr,w,dm_cnr,"level")      = q18_sumreg_res_biomass_ag.l(i,kcr,w,dm_cnr);
 oq18_prod_res_bg_clust(t,j,kcr,w,dm_cnr,"level")          = q18_prod_res_bg_clust.l(j,kcr,w,dm_cnr);
 oq18_sumreg_res_biomass_bg(t,i,kcr,w,dm_cnr,"level")      = q18_sumreg_res_biomass_bg.l(i,kcr,w,dm_cnr);
 oq18_res_field_balance_clust(t,j,kcr,w,dm_cnr,"level")    = q18_res_field_balance_clust.l(j,kcr,w,dm_cnr);
 oq18_res_field_burn_clust(t,j,kcr,w,dm_cnr,"level")       = q18_res_field_burn_clust.l(j,kcr,w,dm_cnr);
 oq18_sumreg_res_biomass_burn(t,i,kcr,w,dm_cnr,"level")    = q18_sumreg_res_biomass_burn.l(i,kcr,w,dm_cnr);
 oq18_translate(t,j,kres,dm_cnr,"level")                   = q18_translate.l(j,kres,dm_cnr);
 oq18_prod_res_cell(t,i,kres,"level")                      = q18_prod_res_cell.l(i,kres);
 oq18_res_recycling_cnr_clust(t,j,kcr,w,c_nr,"level")      = q18_res_recycling_cnr_clust.l(j,kcr,w,c_nr);
 oq18_res_recycling_pk_clust(t,j,kcr,w,pk18,"level")       = q18_res_recycling_pk_clust.l(j,kcr,w,pk18);
 oq18_sumreg_res_recycling(t,i,kcr,w,cnpk18,"level")       = q18_sumreg_res_recycling.l(i,kcr,w,cnpk18);
 oq18_cost_prod_res(t,i,kres,"level")                      = q18_cost_prod_res.l(i,kres);
 ov18_prod_res(t,j,kres,"upper")                           = v18_prod_res.up(j,kres);
 ov_res_biomass_ag(t,i,kcr,w,dm_cnr,"upper")               = vm_res_biomass_ag.up(i,kcr,w,dm_cnr);
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,"upper")               = vm_res_biomass_bg.up(i,kcr,w,dm_cnr);
 ov_res_ag_burn(t,i,kcr,w,dm_cnr,"upper")                  = vm_res_ag_burn.up(i,kcr,w,dm_cnr);
 ov_res_recycling(t,i,kcr,w,dm_cnr,"upper")                = vm_res_recycling.up(i,kcr,w,dm_cnr);
 ov_cost_prod_kres(t,i,kres,"upper")                       = vm_cost_prod_kres.up(i,kres);
 ov18_res_ag_removal_clust(t,j,kcr,w,dm_cnr,"upper")       = v18_res_ag_removal_clust.up(j,kcr,w,dm_cnr);
 ov18_res_ag_recycling_clust(t,j,kcr,w,dm_cnr,"upper")     = v18_res_ag_recycling_clust.up(j,kcr,w,dm_cnr);
 ov18_res_biomass_ag_clust(t,j,kcr,w,dm_cnr,"upper")       = v18_res_biomass_ag_clust.up(j,kcr,w,dm_cnr);
 ov18_res_biomass_bg_clust(t,j,kcr,w,dm_cnr,"upper")       = v18_res_biomass_bg_clust.up(j,kcr,w,dm_cnr);
 ov18_res_ag_burn_clust(t,j,kcr,w,dm_cnr,"upper")          = v18_res_ag_burn_clust.up(j,kcr,w,dm_cnr);
 ov18_res_recycling_clust(t,j,kcr,w,dm_cnr,"upper")        = v18_res_recycling_clust.up(j,kcr,w,dm_cnr);
 oq18_prod_res_ag_clust(t,j,kcr,w,dm_cnr,"upper")          = q18_prod_res_ag_clust.up(j,kcr,w,dm_cnr);
 oq18_sumreg_res_biomass_ag(t,i,kcr,w,dm_cnr,"upper")      = q18_sumreg_res_biomass_ag.up(i,kcr,w,dm_cnr);
 oq18_prod_res_bg_clust(t,j,kcr,w,dm_cnr,"upper")          = q18_prod_res_bg_clust.up(j,kcr,w,dm_cnr);
 oq18_sumreg_res_biomass_bg(t,i,kcr,w,dm_cnr,"upper")      = q18_sumreg_res_biomass_bg.up(i,kcr,w,dm_cnr);
 oq18_res_field_balance_clust(t,j,kcr,w,dm_cnr,"upper")    = q18_res_field_balance_clust.up(j,kcr,w,dm_cnr);
 oq18_res_field_burn_clust(t,j,kcr,w,dm_cnr,"upper")       = q18_res_field_burn_clust.up(j,kcr,w,dm_cnr);
 oq18_sumreg_res_biomass_burn(t,i,kcr,w,dm_cnr,"upper")    = q18_sumreg_res_biomass_burn.up(i,kcr,w,dm_cnr);
 oq18_translate(t,j,kres,dm_cnr,"upper")                   = q18_translate.up(j,kres,dm_cnr);
 oq18_prod_res_cell(t,i,kres,"upper")                      = q18_prod_res_cell.up(i,kres);
 oq18_res_recycling_cnr_clust(t,j,kcr,w,c_nr,"upper")      = q18_res_recycling_cnr_clust.up(j,kcr,w,c_nr);
 oq18_res_recycling_pk_clust(t,j,kcr,w,pk18,"upper")       = q18_res_recycling_pk_clust.up(j,kcr,w,pk18);
 oq18_sumreg_res_recycling(t,i,kcr,w,cnpk18,"upper")       = q18_sumreg_res_recycling.up(i,kcr,w,cnpk18);
 oq18_cost_prod_res(t,i,kres,"upper")                      = q18_cost_prod_res.up(i,kres);
 ov18_prod_res(t,j,kres,"lower")                           = v18_prod_res.lo(j,kres);
 ov_res_biomass_ag(t,i,kcr,w,dm_cnr,"lower")               = vm_res_biomass_ag.lo(i,kcr,w,dm_cnr);
 ov_res_biomass_bg(t,i,kcr,w,dm_cnr,"lower")               = vm_res_biomass_bg.lo(i,kcr,w,dm_cnr);
 ov_res_ag_burn(t,i,kcr,w,dm_cnr,"lower")                  = vm_res_ag_burn.lo(i,kcr,w,dm_cnr);
 ov_res_recycling(t,i,kcr,w,dm_cnr,"lower")                = vm_res_recycling.lo(i,kcr,w,dm_cnr);
 ov_cost_prod_kres(t,i,kres,"lower")                       = vm_cost_prod_kres.lo(i,kres);
 ov18_res_ag_removal_clust(t,j,kcr,w,dm_cnr,"lower")       = v18_res_ag_removal_clust.lo(j,kcr,w,dm_cnr);
 ov18_res_ag_recycling_clust(t,j,kcr,w,dm_cnr,"lower")     = v18_res_ag_recycling_clust.lo(j,kcr,w,dm_cnr);
 ov18_res_biomass_ag_clust(t,j,kcr,w,dm_cnr,"lower")       = v18_res_biomass_ag_clust.lo(j,kcr,w,dm_cnr);
 ov18_res_biomass_bg_clust(t,j,kcr,w,dm_cnr,"lower")       = v18_res_biomass_bg_clust.lo(j,kcr,w,dm_cnr);
 ov18_res_ag_burn_clust(t,j,kcr,w,dm_cnr,"lower")          = v18_res_ag_burn_clust.lo(j,kcr,w,dm_cnr);
 ov18_res_recycling_clust(t,j,kcr,w,dm_cnr,"lower")        = v18_res_recycling_clust.lo(j,kcr,w,dm_cnr);
 oq18_prod_res_ag_clust(t,j,kcr,w,dm_cnr,"lower")          = q18_prod_res_ag_clust.lo(j,kcr,w,dm_cnr);
 oq18_sumreg_res_biomass_ag(t,i,kcr,w,dm_cnr,"lower")      = q18_sumreg_res_biomass_ag.lo(i,kcr,w,dm_cnr);
 oq18_prod_res_bg_clust(t,j,kcr,w,dm_cnr,"lower")          = q18_prod_res_bg_clust.lo(j,kcr,w,dm_cnr);
 oq18_sumreg_res_biomass_bg(t,i,kcr,w,dm_cnr,"lower")      = q18_sumreg_res_biomass_bg.lo(i,kcr,w,dm_cnr);
 oq18_res_field_balance_clust(t,j,kcr,w,dm_cnr,"lower")    = q18_res_field_balance_clust.lo(j,kcr,w,dm_cnr);
 oq18_res_field_burn_clust(t,j,kcr,w,dm_cnr,"lower")       = q18_res_field_burn_clust.lo(j,kcr,w,dm_cnr);
 oq18_sumreg_res_biomass_burn(t,i,kcr,w,dm_cnr,"lower")    = q18_sumreg_res_biomass_burn.lo(i,kcr,w,dm_cnr);
 oq18_translate(t,j,kres,dm_cnr,"lower")                   = q18_translate.lo(j,kres,dm_cnr);
 oq18_prod_res_cell(t,i,kres,"lower")                      = q18_prod_res_cell.lo(i,kres);
 oq18_res_recycling_cnr_clust(t,j,kcr,w,c_nr,"lower")      = q18_res_recycling_cnr_clust.lo(j,kcr,w,c_nr);
 oq18_res_recycling_pk_clust(t,j,kcr,w,pk18,"lower")       = q18_res_recycling_pk_clust.lo(j,kcr,w,pk18);
 oq18_sumreg_res_recycling(t,i,kcr,w,cnpk18,"lower")       = q18_sumreg_res_recycling.lo(i,kcr,w,cnpk18);
 oq18_cost_prod_res(t,i,kres,"lower")                      = q18_cost_prod_res.lo(i,kres);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

