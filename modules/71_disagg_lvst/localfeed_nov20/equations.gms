*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' While regional feedbaskets determine the overall feed availablity within a region, 
*' the cellular distribution of livestock production is underconstrained. Livestock production, 
*' is determinded by the availability of feed stuff with in cluster. 

*' The difference between feed stuff available and consumed in each cell is either 
*' negative (additional feed stuff is needed in a cell) or positive (surplus feed stuff 
*' can be exported). We calculate the transorted feed stuff splitted into 'from' and 'to' by

q71_feed_liv(j2,kfeed) ..
                 vm_prod(j2,kfeed) -  sum(kli,vm_prod(j2,kli)
                   * sum((ct,cell(i2,j2)),im_feed_baskets(ct,i2,kli,kfeed))) =g=
                      v71_tprod(j2, kfeed, "from") - v71_tprod(j2, kfeed, "to")
				 ;

*' Note that this implies that there is no transported feed stuff in the case of 
*' matching demand and supply within a cluster. This feed is assumed to be consumed on farm.

q71_transport_feed(j2,kfeed) ..
                 vm_tprod(j2,kfeed)  =e=
                   vm_prod(j2, kfeed)$(s71_transport = 0) + 
                   v71_tprod(j2, kfeed, "from")$(s71_transport = 1 or s71_transport = 3) +
                   v71_tprod(j2, kfeed, "to")$(  s71_transport = 2 or s71_transport = 3) + 0
                                 ;

*' 'vm_tprod' is the interface variable to the transport module and is specified for
*' different settings of 's71_transport', ranging from all feed stuff is accounted for transport (0),
*' to just additional feed stuff transported from (1), or to (2) a cluster, or both (3) is subject
*' to transport costs.

*' For all non feed production items full transport costs occur:

q71_transport_nofeed(j2,knofeed) ..
                 vm_tprod(j2,knofeed) =e= vm_prod(j2,knofeed);
