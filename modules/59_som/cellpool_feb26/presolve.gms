*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* SOM pools and densities will be updated after natural regrowth and disturbance loss accounting.
* The secondary forest pool will receive carbon from primary forest (due to natural disturbance)
* and from other land (due to regrowth).
* Note: This will only account for transitions of primary forest to secondary forest and
* other land to secondary forest. See current version of 35_natveg to check consistency.

pc59_som_pool(j,"secdforest") = pc59_som_pool(j,"secdforest") +
                               (pc59_land_before(j,"primforest") - pcm_land(j,"primforest")) *
                                                pc59_carbon_density(j,"primforest") +
                               (pc59_land_before(j,"other") - pcm_land(j,"other")) *
                                                pc59_carbon_density(j,"other");

pc59_som_pool(j,"other") = pc59_som_pool(j,"other") -
                          (pc59_land_before(j,"other") - pcm_land(j,"other")) *
                                             pc59_carbon_density(j,"other");

pc59_som_pool(j,"primforest") = pc59_som_pool(j,"primforest") -
                               (pc59_land_before(j,"primforest") - pcm_land(j,"primforest")) *
                                                pc59_carbon_density(j,"primforest");

p59_carbon_density(t,j,land)$(pcm_land(j,land) > 1e-10) = pc59_som_pool(j,land) / pcm_land(j,land);

* Initialize cropland area by crop type and irrigation for first timestep
* For later timesteps, update from previous timestep solution
if (sum(t_past, 1) = 0,
  pc59_area(j,kcr,w) = fm_croparea(t,j,w,kcr);
else
  pc59_area(j,kcr,w) = vm_area.l(j,kcr,w);
);

* Store cropland area snapshot when we reach the reference year (if using fixed year mode)
* This snapshot is then used for all subsequent SCM target calculations
* NOTE: s59_scm_reference_year should be <= s59_scm_scenario_start to ensure
*       the snapshot is taken before the SCM policy begins
if (s59_scm_reference_year > 0,
  if (m_year(t) = s59_scm_reference_year,
    p59_area_scm_reference(j,kcr,w) = pc59_area(j,kcr,w);
  );
);

* Convert share target to absolute area target at regional level
* Mode selection:
*   s59_scm_reference_year = -1: Use previous timestep cropland area (dynamic mode)
*   s59_scm_reference_year > 0:  Use fixed reference year cropland area (fixed year mode)
* This decouples the SCM target from current cropland area decisions while allowing spatial flexibility
* Only count crops eligible for SCM (annuals only, exclude perennials and rice)
if (s59_scm_reference_year <= 0,
  i59_scm_target_area(t,i) = i59_scm_scenario_fader(t) * 
    (s59_scm_target * p59_country_weight(i) * sum((cell(i,j),kscm59,w), pc59_area(j,kscm59,w))
    + s59_scm_target_noselect * (1-p59_country_weight(i)) * sum((cell(i,j),kscm59,w), pc59_area(j,kscm59,w)));
else
  i59_scm_target_area(t,i) = i59_scm_scenario_fader(t) * 
    (s59_scm_target * p59_country_weight(i) * sum((cell(i,j),kscm59,w), p59_area_scm_reference(j,kscm59,w))
    + s59_scm_target_noselect * (1-p59_country_weight(i)) * sum((cell(i,j),kscm59,w), p59_area_scm_reference(j,kscm59,w)));
);

* Exclude perennials and rice from soil carbon management
* SCM practices (cover crops, reduced tillage) are not compatible with perennial crops or flooded rice
v59_area_scm.fx(j,knoscm59,w,"scm") = 0;
