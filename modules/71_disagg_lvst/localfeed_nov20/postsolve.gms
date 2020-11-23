*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_tprod(t,j,k,"marginal")                        = vm_tprod.m(j,k);
 ov_costs_additional_mon(t,i,"marginal")           = vm_costs_additional_mon.m(i);
 oq71_feed_liv(t,j,kfeed,"marginal")               = q71_feed_liv.m(j,kfeed);
 oq71_transport_production(t,j,knofeed,"marginal") = q71_transport_production.m(j,knofeed);
 ov_tprod(t,j,k,"level")                           = vm_tprod.l(j,k);
 ov_costs_additional_mon(t,i,"level")              = vm_costs_additional_mon.l(i);
 oq71_feed_liv(t,j,kfeed,"level")                  = q71_feed_liv.l(j,kfeed);
 oq71_transport_production(t,j,knofeed,"level")    = q71_transport_production.l(j,knofeed);
 ov_tprod(t,j,k,"upper")                           = vm_tprod.up(j,k);
 ov_costs_additional_mon(t,i,"upper")              = vm_costs_additional_mon.up(i);
 oq71_feed_liv(t,j,kfeed,"upper")                  = q71_feed_liv.up(j,kfeed);
 oq71_transport_production(t,j,knofeed,"upper")    = q71_transport_production.up(j,knofeed);
 ov_tprod(t,j,k,"lower")                           = vm_tprod.lo(j,k);
 ov_costs_additional_mon(t,i,"lower")              = vm_costs_additional_mon.lo(i);
 oq71_feed_liv(t,j,kfeed,"lower")                  = q71_feed_liv.lo(j,kfeed);
 oq71_transport_production(t,j,knofeed,"lower")    = q71_transport_production.lo(j,knofeed);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
