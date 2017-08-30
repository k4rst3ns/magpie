
* demand for non-food products "knf" is set to 0;
vm_dem_food.fx(i,knf)=0;
v15_kcal_regression.fx(iso,knf)=0;

*** Price-demand model is calculated the first time, using standard prices

p15_iteration_counter(t)    =0;

display "starting demand model for intitialisation run....";

* helping the solver by starting from reasonable values
* by setting real income per capita on exogenous gdp per capita
v15_income_pc_real_ppp_iso.lo(iso)=10;
v15_income_pc_real_ppp_iso.fx(iso)=im_gdp_pc_ppp_iso(t,iso);

solve m15_food_demand USING nlp MAXIMIZING v15_objective ;
p15_modelstat(t) = m15_food_demand.modelstat;

display "Food Demand Model Initialisation run finished with modelstat ";
display p15_modelstat;
if(( p15_modelstat(t)) > 2 and (p15_modelstat(t) ne 7 ),
  m15_food_demand.solprint = 1
  Execute_Unload "fulldata.gdx";
  abort "Food Demand Model became infeasible. Stop run.";
);

* releasing real per capita binding for later runs that include shocks

v15_income_pc_real_ppp_iso.lo(iso)=10;
v15_income_pc_real_ppp_iso.up(iso)=Inf;

* deriving calibration values

if (sum(sameas(t_past,t),1) = 1,
    p15_kcal_balanceflow(t,iso,kfo) = f15_kcal_pc_iso(t,iso,kfo) - v15_kcal_regression.l(iso, kfo);
    p15_kcal_balanceflow_lastcalibrationyear(iso,kfo) = p15_kcal_balanceflow(t,iso,kfo);
else
    p15_kcal_balanceflow(t,iso,kfo) = p15_kcal_balanceflow_lastcalibrationyear(iso,kfo) * f15_kcal_balanceflow_fadeout(t,"%c15_calibscen%")
);


 p15_kcal_pc_iso_initial(t,iso,kfo) = (v15_kcal_regression.l(iso,kfo) + p15_kcal_balanceflow(t,iso,kfo));

 p15_kcal_pc_iso_initial(t,iso,kfo)$(p15_kcal_pc_iso_initial(t,iso,kfo)<0) = 0;

* estimate regional indicators from demand model
 p15_kcal_pc_initial(t,i,kfo)$(
     sum(i_to_iso(i,iso),
       im_pop_iso(t,iso)
     ) >0 ) =
                             sum(i_to_iso(i,iso),
                                 p15_kcal_pc_iso_initial(t,iso,kfo)
                                 * im_pop_iso(t,iso)
                             ) / sum(i_to_iso(i,iso),
                                 im_pop_iso(t,iso)
                             );



 v15_kcal_pc.l(i,kfo) = p15_kcal_pc_initial(t,i,kfo);

p15_demand_nonfood_iso_initial(t,iso)  =  v15_demand_nonfood.l(iso);