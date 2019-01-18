*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

vm_dem_bioen.fx(i2,kap)=0;

v60_dem_bioen_gen.fx(i,k1st60,"1stgen")  = f60_1stgen_bioenergy_dem(t,i,"%c60_1stgen_biodem%",k1st60);
v60_dem_bioen_gen.fx(i,kres,"tradition") = f60_1stgen_bioenergy_dem(t,i,"%c60_1stgen_biodem%",kres);
