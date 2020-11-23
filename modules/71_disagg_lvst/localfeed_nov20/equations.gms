*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Ruminant livestock production within a cell is determined by the production of the non-transportable
*' feed items grazed pasture and fodder. These must be larger than the ruminant feed requirements
*' that are given by the product of ruminant production and the respective feed baskets:

q71_feed_liv(j2,kfeed) ..
                 vm_prod(j2,kfeed) + vm_tprod(j2,kfeed)  =g=
                  sum(kli,vm_prod(j2,kli)
                   * sum((ct,cell(i2,j2)),im_feed_baskets(ct,i2,kli,kfeed)))
				 ;

q71_transport_production(j2,knofeed) ..
                 vm_tprod(j2,knofeed) =e= vm_prod(j2,knofeed);
