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
         %-- Excel mode operation
         %-- Optimize
    tic

    %--- Obtain values from Struct Domain 
    Dom_values = cell2mat(struct2cell(DOM));

        
            %---- Positive Particle radial vector domain  
                POS_P.R = Dom_values (1,:);
            %---- Positive Electrode spatial vector domain  
                POS_P.L = Dom_values (2,:);

                %--- Particle Spatial domain calculations

                    %-- dR: Radial differential value
                        POS_P.dR=diff(POS_P.R(1:2));
                    %-- Sa: Outer surface area of each shell
                        POS_P.Sa = 4*pi*(POS_P.R).^2;   
                    %-- dV: Volume of each shell
                        POS_P.dV = diff((4/3)*pi*((POS_P.R).^3));

                %--- Electrode Spatial domain calculations

                    %-- dx
                       POS_P.dx=diff(POS_P.L(1:2)); 

     %--- Obtain values to parametrize the General Constants and generate CNT struct to group constant parameters

    
             %--- Faraday Constant defining Function
    
                CNT.F=Find_Param_Value(PARAM,"Faraday Constant [C/mol]");
    
             %--- Molar Gas Constant defining Function
    
                CNT.R=Find_Param_Value(PARAM,"Molar Gas Constant [J⋅K^−1⋅mol^−1]");


     %--- Obtain values and functions to parametrize POSITIVE electrode and generate POS_P struct to group electrode parameters  

    
             %--- Positive Electrode cross-section defining Function
    
                POS_P.A=Find_Param_Value(PARAM,"Electrode Cross-Sectional area [m^2]");

             %--- Positive Electrode thickness defining Function
    
                POS_P.L=Find_Param_Value(PARAM,"Positive Electrode thickness [m]");                
    
             %--- Positive Electrode volume fraction defining Function
    
                POS_P.Epsi=Find_Param_Value(PARAM,"Volume fraction of the solid electrode material in the porous electrode [%]");            
    
             %--- Positive Particle diffusivity defining Function
    
                POS_P.D_s=Find_Param_Value(PARAM,"Positive Electrode Solid Diffusivity [m^2/sec]");            
    
             %--- Positive Particle Maximum Concentration defining Function
    
                POS_P.C_max=Find_Param_Value(PARAM,"Positive Electrode Maximum Concentration [mol/m^3]");
    
             %--- Positive Particle Minimum Concentration defining Function
    
                POS_P.C_min=Find_Param_Value(PARAM,"Positive Electrode Minimum Concentration [mol/m^3]");
    
             %--- Positive Current Collector Thickness defining Function
    
                POS_P.CC_thck=Find_Param_Value(PARAM,"Positive Current Collector Thickness [m]");              
    
   %--- FVM SOLVER

    %---- Init

        In_SOC=str2double(regexp(Init,'(?<!\d)(\d)+(?!\d)','match'));    % - Extract the initial SOC number

        % - Solid Positive Particle Initial concentration distribution
        C0_init_p=interp1(100:-50:0,POS_P.C_min:(POS_P.C_max-POS_P.C_min)/2:POS_P.C_max,In_SOC,"linear");  %Mean Initial SOC linear interpolation vector
        C_p=C0_init_p*ones(1,length(POS_P.R)-1);
       
        % - Solid Negative Particle Initial concentration distribution
        %C0_init_n=interp1(0:50:100,C_min_n:(C_max_n-C_min_n)/2:C_max_n,In_SOC,"linear");
        %C_n=C0_init_n*ones(1,length(R_n));

        % --- Simulation initial conditions

            %-- Time variables
            time=0;             %  >>>   Step time variable
            S.Time=0;           %  >>>   Struct saved time variable for each step

            %-- Current variables
            Current=0;             %  >>>   Step applied current variable
            S.Current=0;           %  >>>   Struct saved applied current variable for each step

            %-- Positive particle concentration distribution variables
            S.C_p=C_p;           %  >>>   Struct saved applied current variable for each step

    %---- Calculation

        if EXP.Mode==1                                  %- OPERATION MODE: Deffault

            EXP_Array_data=struct2cell(EXP.Array);          %-- Extract experiment step data




            for j=1:length(EXP.Array)                   %- EXPERIMENT STEPS LOOP


                if char(EXP_Array_data(3,j))=="Discrete defined Time and Current for experiment"    %-- Condition type 1 matched
                    
                    
                    Global_step_time=diff(cell2mat(EXP_Array_data(1,j)))';
                    Global_step_current=cell2mat(EXP_Array_data(2,j));
                    
                    
                    for i=1:length(Global_step_time)           %-- Loop over set experiment step time

                        time=time+Global_step_time(i);              %- Loop local time
                        S.Time=[S.Time;time];                       %- Struct concatenation for loop local time

                        Current=Global_step_current(i);             %- Loop local applied current
                        S.Current=[S.Current;Current];              %- Struct concatenation for loop local applied current

                        C_p = FVM_Particle_Concentration(C_p,POS_P,CNT,Global_step_time(i),Global_step_current(i));      %- Loop local concentration distribution calculation
                        S.C_p=[S.C_p;C_p];                                                                               %- Struct concatenation for loop local concentration distribution calculation
                    end
                    
                    fprintf(['[COMMENT]: Simulation run successfully for experiment step '])
                    fprintf('%i',j)
                    fprintf(['.\n'])

                elseif char(EXP_Array_data(3,j))=="Voltage limit constraint"                        %-- Condition type 2 matched
                       


                else
                    fprintf(['[ERROR]: Check experiment functions.\n'])  
                    fprintf(['Step '])
                    fprintf('%i',j)
                    fprintf([' cannot be run.\n'])
                end
                EXP.Array;
                
            end
        


        elseif EXP.Mode==2                               % OPERATION MODE: Excel data




        else
            fprintf(['[WARNING]: Experiment data has not been found.\n\n'])  
        end  


toc
fprintf(['\n\n']) 

end