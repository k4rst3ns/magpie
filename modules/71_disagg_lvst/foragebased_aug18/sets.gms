*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

sets
   kli_rum(kli) Ruminant livestock
   /
   livst_rum, livst_milk
   /

   kli_mon(kli) Monogastric livestock
   /
   livst_pig, livst_chick, livst_egg
   /
   
   kforage(k) Forage feed categories
   /
  pasture, foddr
   /

  knforage(kall) non-forage all other products
   /
   tece, maiz, trce, rice_pro, soybean, rapeseed, groundnut, sunflower, oilpalm, puls_pro,
   potato, cassav_sp, sugr_cane, sugr_beet, others, cottn_pro, begr, betr,
   oils, oilcakes, sugar, molasses, alcohol, ethanol, distillers_grain, brans, scp, fibres,
   livst_rum, livst_pig,livst_chick, livst_egg, livst_milk, fish,
   res_cereals, res_fibrous, res_nonfibrous, wood, woodfuel
   / 
; 

alias(j,j3);
alias(cell,cell2);
alias(kforage,kforage2);
