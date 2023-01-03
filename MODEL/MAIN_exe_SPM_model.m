clc
clear all

%Model.a = 1;

Model.Param_Val = Load_Chem_Param("Chen2020");

Model.Domain = SPM_Discrete_Dom(Model); %"Rmesh",25,'Lmesh',35

Model.Experiment = SPM_Experiment( ...
    "Deffault", ...
    repmat([ ...
    "Discharge at 2 Amperes until time reach 3000 seconds", ...
    "Rest until time reach 3000 secods", ...
    "Charge at 2 Amperes until time reach 3000 seconds"...
    ],1,2) ...
    ,1);  
%xlsread("Experiment\EXCEL_Experiment_UPLOAD_example.xlsx")

Model.Solution = SPM_FVM();

