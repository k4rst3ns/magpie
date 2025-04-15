*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

p59_topsoilc_actualstate(j, land, sPools59) = v59_topsoilc_actualstate.l(j, land, sPools59);
p59_topsoilc_density_post(t, j, land, sPools59)$(pcm_land(j,land) > 1e-10) = 
  p59_topsoilc_actualstate(j, land, sPools59) / pcm_land(j,land);
p59_land_before(j,land) = vm_land.l(j,land);

**** natural stock calculations

pc59_topsoilc_natural_steadystate(j, land, sPools59) =
     f59_litter_input(t, j, sPools59) /
       f59_topsoilc_decay(t, j, sPools59, "rainfed", "notill") *
        vm_land.l(j, land);

p59_topsoilc_naturalstate(t, j, land, sPools59)  = 
     pc59_topsoilc_naturalstate_previous(j, land, sPools59) *
       (1 - pc59_topsoilc_decay_timestep(j, sPools59, "rainfed", "notill")) +
         pc59_topsoilc_natural_steadystate(j, land, sPools59) *
           pc59_topsoilc_decay_timestep(j, sPools59, "rainfed", "notill");


pc59_topsoilc_naturalstate_previous(j, land, sPools59) =
  p59_topsoilc_naturalstate(t, j, land, sPools59);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov59_topsoilc_crop_steadystate(t,j,sPools59,w,tillage59,"marginal")        = v59_topsoilc_crop_steadystate.m(j,sPools59,w,tillage59);
 ov59_topsoilc_noncrop_steadystate(t,j,noncropland59,sPools59,"marginal")   = v59_topsoilc_noncrop_steadystate.m(j,noncropland59,sPools59);
 ov59_topsoilc_crop_previousstate(t,j,sPools59,w,tillage59,"marginal")      = v59_topsoilc_crop_previousstate.m(j,sPools59,w,tillage59);
 ov59_cropland_transitions(t,j,tillage59,w,noncropland59,"marginal")        = v59_cropland_transitions.m(j,tillage59,w,noncropland59);
 ov59_topsoilc_noncrop_previousstate(t,j,noncropland59,sPools59,"marginal") = v59_topsoilc_noncrop_previousstate.m(j,noncropland59,sPools59);
 ov59_topsoilc_actualstate(t,j,land,sPools59,"marginal")                    = v59_topsoilc_actualstate.m(j,land,sPools59);
 ov_cost_scm(t,j,"marginal")                                                = vm_cost_scm.m(j);
 ov_nr_som(t,j,"marginal")                                                  = vm_nr_som.m(i);
 ov_nr_som_fertilizer(t,j,"marginal")                                       = vm_nr_som_fertilizer.m(i);
 oq59_steadystate_term_crop(t,j,sPools59,w,tillage59,"marginal")            = q59_steadystate_term_crop.m(j,sPools59,w,tillage59);
 oq59_previousstate_term_crop(t,j,sPools59,w,tillage59,"marginal")          = q59_previousstate_term_crop.m(j,sPools59,w,tillage59);
 oq59_lutransitions_to_cropareas(t,j,noncropland59,"marginal")              = q59_lutransitions_to_cropareas.m(j,noncropland59);
 oq59_actualstate_crop(t,j,sPools59,"marginal")                             = q59_actualstate_crop.m(j,sPools59);
 oq59_steadystate_term_noncrop(t,j,noncropland59,sPools59,"marginal")       = q59_steadystate_term_noncrop.m(j,noncropland59,sPools59);
 oq59_previousstate_term_noncrop(t,j,noncropland59,sPools59,"marginal")     = q59_previousstate_term_noncrop.m(j,noncropland59,sPools59);
 oq59_actualstate_noncrop(t,j,noncropland59,sPools59,"marginal")            = q59_actualstate_noncrop.m(j,noncropland59,sPools59);
 oq59_carbon_soil(t,j,land,stockType,"marginal")                            = q59_carbon_soil.m(j,land,stockType);
 oq59_nr_som(t,j,"marginal")                                                = q59_nr_som.m(i);
 oq59_nr_som_fertilizer2(t,j,"marginal")                                    = q59_nr_som_fertilizer2.m(i);
 oq59_nr_som_fertilizer(t,j,"marginal")                                     = q59_nr_som_fertilizer.m(i);
 ov59_topsoilc_crop_steadystate(t,j,sPools59,w,tillage59,"level")           = v59_topsoilc_crop_steadystate.l(j,sPools59,w,tillage59);
 ov59_topsoilc_noncrop_steadystate(t,j,noncropland59,sPools59,"level")      = v59_topsoilc_noncrop_steadystate.l(j,noncropland59,sPools59);
 ov59_topsoilc_crop_previousstate(t,j,sPools59,w,tillage59,"level")         = v59_topsoilc_crop_previousstate.l(j,sPools59,w,tillage59);
 ov59_cropland_transitions(t,j,tillage59,w,noncropland59,"level")           = v59_cropland_transitions.l(j,tillage59,w,noncropland59);
 ov59_topsoilc_noncrop_previousstate(t,j,noncropland59,sPools59,"level")    = v59_topsoilc_noncrop_previousstate.l(j,noncropland59,sPools59);
 ov59_topsoilc_actualstate(t,j,land,sPools59,"level")                       = v59_topsoilc_actualstate.l(j,land,sPools59);
 ov_cost_scm(t,j,"level")                                                   = vm_cost_scm.l(j);
 ov_nr_som(t,j,"level")                                                     = vm_nr_som.l(i);
 ov_nr_som_fertilizer(t,j,"level")                                          = vm_nr_som_fertilizer.l(i);
 oq59_steadystate_term_crop(t,j,sPools59,w,tillage59,"level")               = q59_steadystate_term_crop.l(j,sPools59,w,tillage59);
 oq59_previousstate_term_crop(t,j,sPools59,w,tillage59,"level")             = q59_previousstate_term_crop.l(j,sPools59,w,tillage59);
 oq59_lutransitions_to_cropareas(t,j,noncropland59,"level")                 = q59_lutransitions_to_cropareas.l(j,noncropland59);
 oq59_actualstate_crop(t,j,sPools59,"level")                                = q59_actualstate_crop.l(j,sPools59);
 oq59_steadystate_term_noncrop(t,j,noncropland59,sPools59,"level")          = q59_steadystate_term_noncrop.l(j,noncropland59,sPools59);
 oq59_previousstate_term_noncrop(t,j,noncropland59,sPools59,"level")        = q59_previousstate_term_noncrop.l(j,noncropland59,sPools59);
 oq59_actualstate_noncrop(t,j,noncropland59,sPools59,"level")               = q59_actualstate_noncrop.l(j,noncropland59,sPools59);
 oq59_carbon_soil(t,j,land,stockType,"level")                               = q59_carbon_soil.l(j,land,stockType);
 oq59_nr_som(t,j,"level")                                                   = q59_nr_som.l(i);
 oq59_nr_som_fertilizer2(t,j,"level")                                       = q59_nr_som_fertilizer2.l(i);
 oq59_nr_som_fertilizer(t,j,"level")                                        = q59_nr_som_fertilizer.l(i);
 ov59_topsoilc_crop_steadystate(t,j,sPools59,w,tillage59,"upper")           = v59_topsoilc_crop_steadystate.up(j,sPools59,w,tillage59);
 ov59_topsoilc_noncrop_steadystate(t,j,noncropland59,sPools59,"upper")      = v59_topsoilc_noncrop_steadystate.up(j,noncropland59,sPools59);
 ov59_topsoilc_crop_previousstate(t,j,sPools59,w,tillage59,"upper")         = v59_topsoilc_crop_previousstate.up(j,sPools59,w,tillage59);
 ov59_cropland_transitions(t,j,tillage59,w,noncropland59,"upper")           = v59_cropland_transitions.up(j,tillage59,w,noncropland59);
 ov59_topsoilc_noncrop_previousstate(t,j,noncropland59,sPools59,"upper")    = v59_topsoilc_noncrop_previousstate.up(j,noncropland59,sPools59);
 ov59_topsoilc_actualstate(t,j,land,sPools59,"upper")                       = v59_topsoilc_actualstate.up(j,land,sPools59);
 ov_cost_scm(t,j,"upper")                                                   = vm_cost_scm.up(j);
 ov_nr_som(t,j,"upper")                                                     = vm_nr_som.up(i);
 ov_nr_som_fertilizer(t,j,"upper")                                          = vm_nr_som_fertilizer.up(i);
 oq59_steadystate_term_crop(t,j,sPools59,w,tillage59,"upper")               = q59_steadystate_term_crop.up(j,sPools59,w,tillage59);
 oq59_previousstate_term_crop(t,j,sPools59,w,tillage59,"upper")             = q59_previousstate_term_crop.up(j,sPools59,w,tillage59);
 oq59_lutransitions_to_cropareas(t,j,noncropland59,"upper")                 = q59_lutransitions_to_cropareas.up(j,noncropland59);
 oq59_actualstate_crop(t,j,sPools59,"upper")                                = q59_actualstate_crop.up(j,sPools59);
 oq59_steadystate_term_noncrop(t,j,noncropland59,sPools59,"upper")          = q59_steadystate_term_noncrop.up(j,noncropland59,sPools59);
 oq59_previousstate_term_noncrop(t,j,noncropland59,sPools59,"upper")        = q59_previousstate_term_noncrop.up(j,noncropland59,sPools59);
 oq59_actualstate_noncrop(t,j,noncropland59,sPools59,"upper")               = q59_actualstate_noncrop.up(j,noncropland59,sPools59);
 oq59_carbon_soil(t,j,land,stockType,"upper")                               = q59_carbon_soil.up(j,land,stockType);
 oq59_nr_som(t,j,"upper")                                                   = q59_nr_som.up(i);
 oq59_nr_som_fertilizer2(t,j,"upper")                                       = q59_nr_som_fertilizer2.up(i);
 oq59_nr_som_fertilizer(t,j,"upper")                                        = q59_nr_som_fertilizer.up(i);
 ov59_topsoilc_crop_steadystate(t,j,sPools59,w,tillage59,"lower")           = v59_topsoilc_crop_steadystate.lo(j,sPools59,w,tillage59);
 ov59_topsoilc_noncrop_steadystate(t,j,noncropland59,sPools59,"lower")      = v59_topsoilc_noncrop_steadystate.lo(j,noncropland59,sPools59);
 ov59_topsoilc_crop_previousstate(t,j,sPools59,w,tillage59,"lower")         = v59_topsoilc_crop_previousstate.lo(j,sPools59,w,tillage59);
 ov59_cropland_transitions(t,j,tillage59,w,noncropland59,"lower")           = v59_cropland_transitions.lo(j,tillage59,w,noncropland59);
 ov59_topsoilc_noncrop_previousstate(t,j,noncropland59,sPools59,"lower")    = v59_topsoilc_noncrop_previousstate.lo(j,noncropland59,sPools59);
 ov59_topsoilc_actualstate(t,j,land,sPools59,"lower")                       = v59_topsoilc_actualstate.lo(j,land,sPools59);
 ov_cost_scm(t,j,"lower")                                                   = vm_cost_scm.lo(j);
 ov_nr_som(t,j,"lower")                                                     = vm_nr_som.lo(i);
 ov_nr_som_fertilizer(t,j,"lower")                                          = vm_nr_som_fertilizer.lo(i);
 oq59_steadystate_term_crop(t,j,sPools59,w,tillage59,"lower")               = q59_steadystate_term_crop.lo(j,sPools59,w,tillage59);
 oq59_previousstate_term_crop(t,j,sPools59,w,tillage59,"lower")             = q59_previousstate_term_crop.lo(j,sPools59,w,tillage59);
 oq59_lutransitions_to_cropareas(t,j,noncropland59,"lower")                 = q59_lutransitions_to_cropareas.lo(j,noncropland59);
 oq59_actualstate_crop(t,j,sPools59,"lower")                                = q59_actualstate_crop.lo(j,sPools59);
 oq59_steadystate_term_noncrop(t,j,noncropland59,sPools59,"lower")          = q59_steadystate_term_noncrop.lo(j,noncropland59,sPools59);
 oq59_previousstate_term_noncrop(t,j,noncropland59,sPools59,"lower")        = q59_previousstate_term_noncrop.lo(j,noncropland59,sPools59);
 oq59_actualstate_noncrop(t,j,noncropland59,sPools59,"lower")               = q59_actualstate_noncrop.lo(j,noncropland59,sPools59);
 oq59_carbon_soil(t,j,land,stockType,"lower")                               = q59_carbon_soil.lo(j,land,stockType);
 oq59_nr_som(t,j,"lower")                                                   = q59_nr_som.lo(i);
 oq59_nr_som_fertilizer2(t,j,"lower")                                       = q59_nr_som_fertilizer2.lo(i);
 oq59_nr_som_fertilizer(t,j,"lower")                                        = q59_nr_som_fertilizer.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
