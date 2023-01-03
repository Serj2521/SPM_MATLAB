function [S]=Load_Chem_Param(Chem)

   % --- Chem - Name of the chemistry file to be uploaded
   % --- NOTE: "Chem" should match one of the existing sets ion PAram_Sets folder
   % --- NOTE: Deffault Parameters should be implemented in this function

    run(append(Chem,'.m'))    % --- Load Chemical Cell Parameters

    S = struct('Parameter',Param_Val_M(:,1),'Value',Param_Val_M(:,2));

end