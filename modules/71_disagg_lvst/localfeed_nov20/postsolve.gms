*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov71_tprod(t,j,kfeed,dir,"marginal")          = v71_tprod.m(j,kfeed,dir);
 ov_tprod(t,j,k,"marginal")                    = vm_tprod.m(j,k);
 ov_costs_additional_mon(t,i,"marginal")       = vm_costs_additional_mon.m(i);
 oq71_feed_liv(t,j,kfeed,"marginal")           = q71_feed_liv.m(j,kfeed);
 oq71_transport_feed(t,j,kfeed,"marginal")     = q71_transport_feed.m(j,kfeed);
 oq71_transport_nofeed(t,j,knofeed,"marginal") = q71_transport_nofeed.m(j,knofeed);
 ov71_tprod(t,j,kfeed,dir,"level")             = v71_tprod.l(j,kfeed,dir);
 ov_tprod(t,j,k,"level")                       = vm_tprod.l(j,k);
 ov_costs_additional_mon(t,i,"level")          = vm_costs_additional_mon.l(i);
 oq71_feed_liv(t,j,kfeed,"level")              = q71_feed_liv.l(j,kfeed);
 oq71_transport_feed(t,j,kfeed,"level")        = q71_transport_feed.l(j,kfeed);
 oq71_transport_nofeed(t,j,knofeed,"level")    = q71_transport_nofeed.l(j,knofeed);
 ov71_tprod(t,j,kfeed,dir,"upper")             = v71_tprod.up(j,kfeed,dir);
 ov_tprod(t,j,k,"upper")                       = vm_tprod.up(j,k);
 ov_costs_additional_mon(t,i,"upper")          = vm_costs_additional_mon.up(i);
 oq71_feed_liv(t,j,kfeed,"upper")              = q71_feed_liv.up(j,kfeed);
 oq71_transport_feed(t,j,kfeed,"upper")        = q71_transport_feed.up(j,kfeed);
 oq71_transport_nofeed(t,j,knofeed,"upper")    = q71_transport_nofeed.up(j,knofeed);
 ov71_tprod(t,j,kfeed,dir,"lower")             = v71_tprod.lo(j,kfeed,dir);
 ov_tprod(t,j,k,"lower")                       = vm_tprod.lo(j,k);
 ov_costs_additional_mon(t,i,"lower")          = vm_costs_additional_mon.lo(i);
 oq71_feed_liv(t,j,kfeed,"lower")              = q71_feed_liv.lo(j,kfeed);
 oq71_transport_feed(t,j,kfeed,"lower")        = q71_transport_feed.lo(j,kfeed);
 oq71_transport_nofeed(t,j,knofeed,"lower")    = q71_transport_nofeed.lo(j,knofeed);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
