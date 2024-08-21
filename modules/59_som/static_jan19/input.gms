*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

$setglobal c59_static_spatial_level  cellular
*   options:   cellular  (use preprocessed cellular stock change factors)
*              cluster   (use cshare_released on cluster within gams)

$setglobal c59_som_scenario  cc
*   options:  cc        (climate change)
*             nocc      (no climate change)
*             nocc_hist (no climate change after year defined by sm_fix_cc)

* Exogenous nr release through som loss (only in static realization)
$setglobal c59_exo_scen  constant
*   options:   constant  (constant from 2020)
*              fadeout_2050  (fading out till 2050)

table f59_soilclayer_density(t_all,j,layer59) LPJ carbon density of top and sub soil layer for natural vegetation (tC per ha)
$ondelim
$include "./modules/59_som/static_jan19/input/lpj_carbon_soillayer.cs3"
$offdelim
;
$if "%c59_som_scenario%" == "nocc" f59_soilclayer_density(t_all,j,layer59) = f59_soilclayer_density("y1995",j,layer59);
$if "%c59_som_scenario%" == "nocc_hist" f59_soilclayer_density(t_all,j,layer59)$(m_year(t_all) > sm_fix_cc) = f59_soilclayer_density(t_all,j,layer59)$(m_year(t_all) = sm_fix_cc);
m_fillmissingyears(f59_soilclayer_density,"j,layer59");

parameters f59_cshare_released(j) Share of soil carbon that is released on cropland compared to natural vegetation after 20 years (1)
/
$ondelim
$include "./modules/59_som/static_jan19/input/cshare_released.cs2b"
$offdelim
/
;

table f59_som_exogenous(t_all,i,exo_scen59) Nr released through changing soil organic matter
$ondelim
$include "./modules/59_som/static_jan19/input/f59_som_exogenous.cs3"
$offdelim
;
