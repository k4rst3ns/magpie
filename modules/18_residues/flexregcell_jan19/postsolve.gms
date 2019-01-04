*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

****** Residues

*** EOF postsolve.gms ***

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov18_res_biomass_ag(t,j,kcr,attributes,"marginal")        = v18_res_biomass_ag.m(j,kcr,attributes);
 ov18_res_biomass_bg(t,j,kcr,dm_nr,"marginal")             = v18_res_biomass_bg.m(j,kcr,dm_nr);
 ov_res_biomass_ag(t,i,kcr,attributes,"marginal")          = vm_res_biomass_ag.m(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"marginal")               = vm_res_biomass_bg.m(i,kcr,dm_nr);
 ov18_res_ag_removal(t,j,kcr,attributes,"marginal")        = v18_res_ag_removal.m(j,kcr,attributes);
 ov18_res_ag_recycling(t,j,kcr,attributes,"marginal")      = v18_res_ag_recycling.m(j,kcr,attributes);
 ov18_res_ag_burn(t,j,kcr,attributes,"marginal")           = v18_res_ag_burn.m(j,kcr,attributes);
 ov18_res_recycling(t,j,npk,"marginal")                    = v18_res_recycling.m(j,npk);
 ov_res_recycling(t,i,npk,"marginal")                      = vm_res_recycling.m(i,npk);
 oq18_prod_res_ag(t,j,kcr,attributes,"marginal")           = q18_prod_res_ag.m(j,kcr,attributes);
 oq18_prod_res_bg(t,j,kcr,dm_nr,"marginal")                = q18_prod_res_bg.m(j,kcr,dm_nr);
 oq18_res_field_balance(t,j,kcr,attributes,"marginal")     = q18_res_field_balance.m(j,kcr,attributes);
 oq18_res_field_burn(t,j,kcr,attributes,"marginal")        = q18_res_field_burn.m(j,kcr,attributes);
 oq18_translate(t,i,kres,attributes,"marginal")            = q18_translate.m(i,kres,attributes);
 oq18_res_recycling_nr(t,j,"marginal")                     = q18_res_recycling_nr.m(j);
 oq18_res_recycling_pk(t,j,pk18,"marginal")                = q18_res_recycling_pk.m(j,pk18);
 oq18_cost_prod_res(t,i,kres,"marginal")                   = q18_cost_prod_res.m(i,kres);
 oq18_sumreg_res_biomass_ag(t,i,kcr,attributes,"marginal") = q18_sumreg_res_biomass_ag.m(i,kcr,attributes);
 oq18_sumreg_res_biomass_bg(t,i,kcr,dm_nr,"marginal")      = q18_sumreg_res_biomass_bg.m(i,kcr,dm_nr);
 oq18_sumreg_res_recycling(t,i,npk,"marginal")             = q18_sumreg_res_recycling.m(i,npk);
 ov18_res_biomass_ag(t,j,kcr,attributes,"level")           = v18_res_biomass_ag.l(j,kcr,attributes);
 ov18_res_biomass_bg(t,j,kcr,dm_nr,"level")                = v18_res_biomass_bg.l(j,kcr,dm_nr);
 ov_res_biomass_ag(t,i,kcr,attributes,"level")             = vm_res_biomass_ag.l(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"level")                  = vm_res_biomass_bg.l(i,kcr,dm_nr);
 ov18_res_ag_removal(t,j,kcr,attributes,"level")           = v18_res_ag_removal.l(j,kcr,attributes);
 ov18_res_ag_recycling(t,j,kcr,attributes,"level")         = v18_res_ag_recycling.l(j,kcr,attributes);
 ov18_res_ag_burn(t,j,kcr,attributes,"level")              = v18_res_ag_burn.l(j,kcr,attributes);
 ov18_res_recycling(t,j,npk,"level")                       = v18_res_recycling.l(j,npk);
 ov_res_recycling(t,i,npk,"level")                         = vm_res_recycling.l(i,npk);
 oq18_prod_res_ag(t,j,kcr,attributes,"level")              = q18_prod_res_ag.l(j,kcr,attributes);
 oq18_prod_res_bg(t,j,kcr,dm_nr,"level")                   = q18_prod_res_bg.l(j,kcr,dm_nr);
 oq18_res_field_balance(t,j,kcr,attributes,"level")        = q18_res_field_balance.l(j,kcr,attributes);
 oq18_res_field_burn(t,j,kcr,attributes,"level")           = q18_res_field_burn.l(j,kcr,attributes);
 oq18_translate(t,i,kres,attributes,"level")               = q18_translate.l(i,kres,attributes);
 oq18_res_recycling_nr(t,j,"level")                        = q18_res_recycling_nr.l(j);
 oq18_res_recycling_pk(t,j,pk18,"level")                   = q18_res_recycling_pk.l(j,pk18);
 oq18_cost_prod_res(t,i,kres,"level")                      = q18_cost_prod_res.l(i,kres);
 oq18_sumreg_res_biomass_ag(t,i,kcr,attributes,"level")    = q18_sumreg_res_biomass_ag.l(i,kcr,attributes);
 oq18_sumreg_res_biomass_bg(t,i,kcr,dm_nr,"level")         = q18_sumreg_res_biomass_bg.l(i,kcr,dm_nr);
 oq18_sumreg_res_recycling(t,i,npk,"level")                = q18_sumreg_res_recycling.l(i,npk);
 ov18_res_biomass_ag(t,j,kcr,attributes,"upper")           = v18_res_biomass_ag.up(j,kcr,attributes);
 ov18_res_biomass_bg(t,j,kcr,dm_nr,"upper")                = v18_res_biomass_bg.up(j,kcr,dm_nr);
 ov_res_biomass_ag(t,i,kcr,attributes,"upper")             = vm_res_biomass_ag.up(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"upper")                  = vm_res_biomass_bg.up(i,kcr,dm_nr);
 ov18_res_ag_removal(t,j,kcr,attributes,"upper")           = v18_res_ag_removal.up(j,kcr,attributes);
 ov18_res_ag_recycling(t,j,kcr,attributes,"upper")         = v18_res_ag_recycling.up(j,kcr,attributes);
 ov18_res_ag_burn(t,j,kcr,attributes,"upper")              = v18_res_ag_burn.up(j,kcr,attributes);
 ov18_res_recycling(t,j,npk,"upper")                       = v18_res_recycling.up(j,npk);
 ov_res_recycling(t,i,npk,"upper")                         = vm_res_recycling.up(i,npk);
 oq18_prod_res_ag(t,j,kcr,attributes,"upper")              = q18_prod_res_ag.up(j,kcr,attributes);
 oq18_prod_res_bg(t,j,kcr,dm_nr,"upper")                   = q18_prod_res_bg.up(j,kcr,dm_nr);
 oq18_res_field_balance(t,j,kcr,attributes,"upper")        = q18_res_field_balance.up(j,kcr,attributes);
 oq18_res_field_burn(t,j,kcr,attributes,"upper")           = q18_res_field_burn.up(j,kcr,attributes);
 oq18_translate(t,i,kres,attributes,"upper")               = q18_translate.up(i,kres,attributes);
 oq18_res_recycling_nr(t,j,"upper")                        = q18_res_recycling_nr.up(j);
 oq18_res_recycling_pk(t,j,pk18,"upper")                   = q18_res_recycling_pk.up(j,pk18);
 oq18_cost_prod_res(t,i,kres,"upper")                      = q18_cost_prod_res.up(i,kres);
 oq18_sumreg_res_biomass_ag(t,i,kcr,attributes,"upper")    = q18_sumreg_res_biomass_ag.up(i,kcr,attributes);
 oq18_sumreg_res_biomass_bg(t,i,kcr,dm_nr,"upper")         = q18_sumreg_res_biomass_bg.up(i,kcr,dm_nr);
 oq18_sumreg_res_recycling(t,i,npk,"upper")                = q18_sumreg_res_recycling.up(i,npk);
 ov18_res_biomass_ag(t,j,kcr,attributes,"lower")           = v18_res_biomass_ag.lo(j,kcr,attributes);
 ov18_res_biomass_bg(t,j,kcr,dm_nr,"lower")                = v18_res_biomass_bg.lo(j,kcr,dm_nr);
 ov_res_biomass_ag(t,i,kcr,attributes,"lower")             = vm_res_biomass_ag.lo(i,kcr,attributes);
 ov_res_biomass_bg(t,i,kcr,dm_nr,"lower")                  = vm_res_biomass_bg.lo(i,kcr,dm_nr);
 ov18_res_ag_removal(t,j,kcr,attributes,"lower")           = v18_res_ag_removal.lo(j,kcr,attributes);
 ov18_res_ag_recycling(t,j,kcr,attributes,"lower")         = v18_res_ag_recycling.lo(j,kcr,attributes);
 ov18_res_ag_burn(t,j,kcr,attributes,"lower")              = v18_res_ag_burn.lo(j,kcr,attributes);
 ov18_res_recycling(t,j,npk,"lower")                       = v18_res_recycling.lo(j,npk);
 ov_res_recycling(t,i,npk,"lower")                         = vm_res_recycling.lo(i,npk);
 oq18_prod_res_ag(t,j,kcr,attributes,"lower")              = q18_prod_res_ag.lo(j,kcr,attributes);
 oq18_prod_res_bg(t,j,kcr,dm_nr,"lower")                   = q18_prod_res_bg.lo(j,kcr,dm_nr);
 oq18_res_field_balance(t,j,kcr,attributes,"lower")        = q18_res_field_balance.lo(j,kcr,attributes);
 oq18_res_field_burn(t,j,kcr,attributes,"lower")           = q18_res_field_burn.lo(j,kcr,attributes);
 oq18_translate(t,i,kres,attributes,"lower")               = q18_translate.lo(i,kres,attributes);
 oq18_res_recycling_nr(t,j,"lower")                        = q18_res_recycling_nr.lo(j);
 oq18_res_recycling_pk(t,j,pk18,"lower")                   = q18_res_recycling_pk.lo(j,pk18);
 oq18_cost_prod_res(t,i,kres,"lower")                      = q18_cost_prod_res.lo(i,kres);
 oq18_sumreg_res_biomass_ag(t,i,kcr,attributes,"lower")    = q18_sumreg_res_biomass_ag.lo(i,kcr,attributes);
 oq18_sumreg_res_biomass_bg(t,i,kcr,dm_nr,"lower")         = q18_sumreg_res_biomass_bg.lo(i,kcr,dm_nr);
 oq18_sumreg_res_recycling(t,i,npk,"lower")                = q18_sumreg_res_recycling.lo(i,npk);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

