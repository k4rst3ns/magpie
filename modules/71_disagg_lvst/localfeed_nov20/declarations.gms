*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

positive variables
 v71_tprod(j, kfeed, dir)                         Transported feed production to or from a cluster (mio. tDM per yr)
 vm_tprod(j,k)                                    Transported production (mio. tDM per yr)
 vm_costs_additional_mon(i)                       Punishment cost for additionally transported monogastric livst_egg (mio. USD05MER per yr)
;

equations
 q71_feed_liv(j,kfeed)                  Production constraint for livestock products (mio. tDM per yr)
 q71_transport_feed(j,kfeed)            Determination of transported production
 q71_transport_nofeed(j,knofeed)        Transport of non feed stuff 
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov71_tprod(t,j,kfeed,dir,type)          Transported feed production to or from a cluster (mio. tDM per yr)
 ov_tprod(t,j,k,type)                    Transported production (mio. tDM per yr)
 ov_costs_additional_mon(t,i,type)       Punishment cost for additionally transported monogastric livst_egg (mio. USD05MER per yr)
 oq71_feed_liv(t,j,kfeed,type)           Production constraint for livestock products (mio. tDM per yr)
 oq71_transport_feed(t,j,kfeed,type)     Determination of transported production
 oq71_transport_nofeed(t,j,knofeed,type) Transport of non feed stuff 
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
