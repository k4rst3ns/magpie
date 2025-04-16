*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_nr_som(t,i,"marginal")                                       = vm_nr_som.m(i);
 ov_nr_som_fertilizer(t,i,"marginal")                            = vm_nr_som_fertilizer.m(i);
 ov_cost_scm(t,j,"marginal")                                     = vm_cost_scm.m(j);
 oq59_soilcarbon_cropland(t,j,stockType,"marginal")              = q59_soilcarbon_cropland.m(j,stockType);
 oq59_soilcarbon_regular(t,j,regularland59,stockType,"marginal") = q59_soilcarbon_regular.m(j,regularland59,stockType);
 oq59_soilcarbon_other(t,j,stockType,"marginal")                 = q59_soilcarbon_other.m(j,stockType);
 ov_nr_som(t,i,"level")                                          = vm_nr_som.l(i);
 ov_nr_som_fertilizer(t,i,"level")                               = vm_nr_som_fertilizer.l(i);
 ov_cost_scm(t,j,"level")                                        = vm_cost_scm.l(j);
 oq59_soilcarbon_cropland(t,j,stockType,"level")                 = q59_soilcarbon_cropland.l(j,stockType);
 oq59_soilcarbon_regular(t,j,regularland59,stockType,"level")    = q59_soilcarbon_regular.l(j,regularland59,stockType);
 oq59_soilcarbon_other(t,j,stockType,"level")                    = q59_soilcarbon_other.l(j,stockType);
 ov_nr_som(t,i,"upper")                                          = vm_nr_som.up(i);
 ov_nr_som_fertilizer(t,i,"upper")                               = vm_nr_som_fertilizer.up(i);
 ov_cost_scm(t,j,"upper")                                        = vm_cost_scm.up(j);
 oq59_soilcarbon_cropland(t,j,stockType,"upper")                 = q59_soilcarbon_cropland.up(j,stockType);
 oq59_soilcarbon_regular(t,j,regularland59,stockType,"upper")    = q59_soilcarbon_regular.up(j,regularland59,stockType);
 oq59_soilcarbon_other(t,j,stockType,"upper")                    = q59_soilcarbon_other.up(j,stockType);
 ov_nr_som(t,i,"lower")                                          = vm_nr_som.lo(i);
 ov_nr_som_fertilizer(t,i,"lower")                               = vm_nr_som_fertilizer.lo(i);
 ov_cost_scm(t,j,"lower")                                        = vm_cost_scm.lo(j);
 oq59_soilcarbon_cropland(t,j,stockType,"lower")                 = q59_soilcarbon_cropland.lo(j,stockType);
 oq59_soilcarbon_regular(t,j,regularland59,stockType,"lower")    = q59_soilcarbon_regular.lo(j,regularland59,stockType);
 oq59_soilcarbon_other(t,j,stockType,"lower")                    = q59_soilcarbon_other.lo(j,stockType);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

