*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_costs_additional_mon(t,i,"marginal")      = vm_costs_additional_mon.m(i);
 ov71_dem_feed_clust(t,j,kli,kall,"marginal") = v71_dem_feed_clust.m(j,kli,kall);
 oq71_dem_feed_clust(t,i,kli,kall,"marginal") = q71_dem_feed_clust.m(i,kli,kall);
 ov_costs_additional_mon(t,i,"level")         = vm_costs_additional_mon.l(i);
 ov71_dem_feed_clust(t,j,kli,kall,"level")    = v71_dem_feed_clust.l(j,kli,kall);
 oq71_dem_feed_clust(t,i,kli,kall,"level")    = q71_dem_feed_clust.l(i,kli,kall);
 ov_costs_additional_mon(t,i,"upper")         = vm_costs_additional_mon.up(i);
 ov71_dem_feed_clust(t,j,kli,kall,"upper")    = v71_dem_feed_clust.up(j,kli,kall);
 oq71_dem_feed_clust(t,i,kli,kall,"upper")    = q71_dem_feed_clust.up(i,kli,kall);
 ov_costs_additional_mon(t,i,"lower")         = vm_costs_additional_mon.lo(i);
 ov71_dem_feed_clust(t,j,kli,kall,"lower")    = v71_dem_feed_clust.lo(j,kli,kall);
 oq71_dem_feed_clust(t,i,kli,kall,"lower")    = q71_dem_feed_clust.lo(i,kli,kall);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

