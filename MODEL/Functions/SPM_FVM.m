function [S] = SPM_FVM(PARAM,DOM,EXP,Init)
    %{

    SPM solver with Finite Difference Method:
    
        % --- PARAM     >>>  Upload the parameters struct branch 
        % --- DOM       >>>  Upload the domain struct branch 
        % --- EXP       >>>  Upload the experiment struct branch
        % --- Init      >>>  String to define steady state initial confitions
    
    %}
    
    %TO DO LIST:
     %--MAIN
         %-- Add deffault model
         %-- Add Negative electrode and separator domains

    S=1;

    %--- Obtain values from Struct Domain 
    Dom_values = cell2mat(struct2cell(DOM));

        
            %---- Positive Particle radial vector domain  
                R_p = Dom_values (1,:);
            %---- Positive Electrode spatial vector domain  
                L_p = Dom_values (2,:);
    

     %--- Obtain values to parametrize the General Constants

    
             %--- Faraday Constant defining Function
    
                F=Find_Param_Value(PARAM,"Faraday Constant [C/mol]");
    
             %--- Molar Gas Constant defining Function
    
                R=Find_Param_Value(PARAM,"Molar Gas Constant [J⋅K^−1⋅mol^−1]");


     %--- Obtain values and functions to parametrize POSITIVE electrode   

    
             %--- Positive Electrode cross-section defining Function
    
                A_p=Find_Param_Value(PARAM,"Electrode Cross-Sectional area [m^2]");
    
             %--- Positive Electrode volume fraction defining Function
    
                Epsi_p=Find_Param_Value(PARAM,"Volume fraction of the solid electrode material in the porous electrode [%]");            
    
             %--- Positive Particle diffusivity defining Function
    
                D_s_p=Find_Param_Value(PARAM,"Positive Electrode Solid Diffusivity [m^2/sec]");            
    
             %--- Positive Particle Maximum Concentration defining Function
    
                C_max_p=Find_Param_Value(PARAM,"Positive Electrode Maximum Concentration [mol/m^3]");
    
             %--- Positive Particle Minimum Concentration defining Function
    
                C_min_p=Find_Param_Value(PARAM,"Positive Electrode Minimum Concentration [mol/m^3]");
    
             %--- Positive Current Collector Thickness defining Function
    
                CC_thck_p=Find_Param_Value(PARAM,"Positive Current Collector Thickness [m]");              
    
   %--- FVM SOLVER

    %---- Init

        In_SOC=str2double(regexp(Init,'(?<!\d)(\d)+(?!\d)','match'));    % - Extract the initial SOC number

        % - Solid Positive Particle Initial concentration distribution
        C_init_p=interp1(0:50:100,C_min_p:(C_max_p-C_min_p)/2:C_max_p,In_SOC,"linear");
        C0_p=C_init_p*ones(1,length(R_p));
       
        % - Solid Negative Particle Initial concentration distribution
        %C_init_n=interp1(100:-50:0,C_min_n:(C_max_n-C_min_n)/2:C_max_n,In_SOC,"linear");
        %C0_n=C_init_n*ones(1,length(R_n));


end