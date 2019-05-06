*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

i59_subsoilc_density(t_all,j) = fm_carbon_density(t_all,j,"secdforest","soilc") - f59_topsoilc_density(t_all,j);
$ifthen "%c59_static_spatial_level%" == "cellular" i59_topsoilc_density(t_all,j) = fm_carbon_density(t_all,j,"crop","soilc") - i59_subsoilc_density(t_all,j);
$elseif "%c59_static_spatial_level%" == "cluster"  i59_topsoilc_density(t_all,j) = f59_topsoilc_density(t_all,j) * (1- f59_cshare_released(j));
$endif
