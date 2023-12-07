*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variables
  vm_costs_additional_mon(i)                       Punishment cost for additionally transported monogastric livst_egg (mio. USD05MER per yr)
  v71_dem_feed_clust(j,kli,kall)                   Cluster-level feed demand including byproducts (mio. tDM per yr)
;

equation
  q71_dem_feed_clust(i, kli, kall)                 Allows for distribution of feed demand to cellular level (mio. tDM)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_costs_additional_mon(t,i,type)      Punishment cost for additionally transported monogastric livst_egg (mio. USD05MER per yr)
 ov71_dem_feed_clust(t,j,kli,kall,type) Cluster-level feed demand including byproducts (mio. tDM per yr)
 oq71_dem_feed_clust(t,i,kli,kall,type) Allows for distribution of feed demand to cellular level (mio. tDM)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
