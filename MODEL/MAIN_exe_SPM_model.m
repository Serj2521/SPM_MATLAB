clc
clear all
tic

Model = struct;

Model.Param_Val = Load_Chem_Param("Chen2020");

Model.Domain = SPM_Discrete_Dom(Model.Param_Val); %"Rmesh",25,'Lmesh',35

Model.Experiment = SPM_Experiment("Deffault", ...
    repmat([ ...
    "Discharge at 2 A until time reach 3600 seconds", ...
    "Rest until time reach 1200 seconds", ...
    "Charge at 2 A until time reach 3600 seconds"...
    ],1,1) ...
    ,1);  

Model.Solution = SPM_FVM(Model.Param_Val,Model.Domain,Model.Experiment,"From initial 100% SOC");

