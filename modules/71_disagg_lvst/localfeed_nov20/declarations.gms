*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variables
 vm_tprod(j,k)             Feed transported to cell (mio. tDM per yr)
 vm_costs_additional_mon(i)                       Punishment cost for additionally transported monogastric livst_egg (mio. USD05MER per yr)
;

equations
 q71_feed_liv(j,kfeed)                  Production constraint for livestock products (mio. tDM per yr)
 q71_transport_production(j,knofeed)    transport stuff feed
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov_tprod(t,j,k,type)                        Feed transported to cell (mio. tDM per yr)
 ov_costs_additional_mon(t,i,type)           Punishment cost for additionally transported monogastric livst_egg (mio. USD05MER per yr)
 oq71_feed_liv(t,j,kfeed,type)               Production constraint for livestock products (mio. tDM per yr)
 oq71_transport_production(t,j,knofeed,type) transport stuff feed
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
