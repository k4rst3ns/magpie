*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Amount produced at cellular level feed demand  is flexible, can be distributed as it wants 

 q71_dem_feed_clust(i2, kli, kall) ..
                  sum(cell(i2,j2), v71_dem_feed_clust(j2, kli, kall)) =e=
                  vm_dem_feed(i2, kli, kall) ;

