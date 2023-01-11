function [S]=Load_Chem_Param(Chem)
%{

   % --- Chem - Name of the chemistry file to be uploaded
   % --- NOTE: "Chem" should match one of the existing sets ion Param_Sets folder
   % --- NOTE: Deffault Parameters should be implemented in this function

%}

   %TO DO LIST:
    %-- Add Deffault mode operation with standard parameters
    %-- Add error check?
    %-- Add struct groups for different negative electrode and separator
    %and update  positive electrode struct
tic
    run(append(Chem,'.m'))    % --- Load Chemical Cell Parameters

    S = struct('Parameter',Param_Val_M(:,1),'Value',Param_Val_M(:,2));

    fprintf(['[COMMENT]: Parameters from "'])
    fprintf([Chem]) 
    fprintf(['" have been successfully loaded to model\n'])

toc
fprintf(['\n\n'])    


end