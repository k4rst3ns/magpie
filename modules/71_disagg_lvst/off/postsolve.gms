*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_costs_additional_mon(t,i,"marginal")     = vm_costs_additional_mon.m(i);
 ov_tprod(t,j,k,"marginal")                  = vm_tprod.m(j,k);
 oq71_transport_production(t,j,k,"marginal") = q71_transport_production.m(j,k);
 ov_costs_additional_mon(t,i,"level")        = vm_costs_additional_mon.l(i);
 ov_tprod(t,j,k,"level")                     = vm_tprod.l(j,k);
 oq71_transport_production(t,j,k,"level")    = q71_transport_production.l(j,k);
 ov_costs_additional_mon(t,i,"upper")        = vm_costs_additional_mon.up(i);
 ov_tprod(t,j,k,"upper")                     = vm_tprod.up(j,k);
 oq71_transport_production(t,j,k,"upper")    = q71_transport_production.up(j,k);
 ov_costs_additional_mon(t,i,"lower")        = vm_costs_additional_mon.lo(i);
 ov_tprod(t,j,k,"lower")                     = vm_tprod.lo(j,k);
 oq71_transport_production(t,j,k,"lower")    = q71_transport_production.lo(j,k);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

