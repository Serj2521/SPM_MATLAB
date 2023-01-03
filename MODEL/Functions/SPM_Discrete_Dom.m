function [S] = SPM_Discrete_Dom(Model,Rn,Rn_value,Ln,Ln_value)
%{

DISCRETIZATION FUNCTION:

    % --- Model     >>>  Upload the struct from the model
    % --- Rn        >>>  User Defined Positive Particle Grid spatial discretization difference NAME (if not uses default)
    % --- Rn_value  >>>  User Defined Positive Particle Grid spatial discretization difference VALUE (if not uses default)
    % --- Ln        >>>  User Defined Positive Electrode Spatial Grid spatial discretization difference NAME (if not uses default)
    % --- Ln_value  >>>  User Defined Positive Electrode Spatial Grid spatial discretization difference NAME (if not uses default)

%}

   % --- Function variables check 

    exist Rn;           Rn_Check = logical(ans);       % --- Check Spatial Positive Particle grid domain input name
    
    exist Rn_value;     Rn_N_Check = logical(ans);     % --- Check Spatial Positive Particle grid domain input value
    
    exist Ln;           Ln_Check = logical(ans);       % --- Check Spatial Positive electrode grid domain input name
    
    exist Ln_value;     Ln_N_Check = logical(ans);     % --- Check Spatial Positive electrode grid domain input value


    if isfield (Model,'Param_Val') == true                  % --- Check if Param values is loaded
        
        %--- Positive Particle Radius defining loop

        for i=1:length(Model.Param_Val)
            
            Model.Param_Val(i).Parameter=="Positive Particle Radius [m]";
            
            if ans==true

                R_p=Model.Param_Val(i).Value;

            end
        
        end
        
        % --- Positive Electrode L defining loop

        for i=1:length(Model.Param_Val)
            
            Model.Param_Val(i).Parameter=="Positive Electrode thickness [m]";
            
            if ans==true

                L_p=Model.Param_Val(i).Value;

            end
        
        end

            % --- Positive particle Radius Discretization
            
                if Rn_Check==true && Rn_N_Check==true                    % --- Check User Defined 
                    fprintf(['[COMMENT]: User define '])
                    fprintf([Rn]) 
                    fprintf([' as the discretization domain for Positive Particle Radius,'])
                    fprintf(['with a value of ']) 
                    Rn_value
                    fprintf(['spatial diff.\n\n'])
                    R=linspace(0,R_p,Rn_value);         % ----- Positive Particle Radius Discretized Domain from parametrization
        
                else
                    fprintf(['[COMMENT]: Default Discretization parameters loaded for Positive Particle Spatial Grid\n'])
                    R=linspace(0,R_p,20);              % ----- Default Positive Particle Radius Discretized Domain
                    Rn='R_p_mesh';
                end
        
           % --- Positive Electrode L Discretization
                
                if Ln_Check==true && Ln_N_Check==true                    % --- Check User Defined 
                    fprintf(['[COMMENT]: User define '])
                    fprintf([Ln]) 
                    fprintf([' as the discretization domain for Positive Electrode,'])
                    fprintf(['with a value of ']) 
                    Ln_value
                    fprintf(['spatial diff.\n'])
                    L=linspace(0,L_p,Ln_value);       % ----- Positive Particle Radius Discretized Domain from parametrization
        
                else
                    fprintf(['[COMMENT]: Default Discretization parameters loaded for Positive Electrode Spatial Grid\n'])
                    L=linspace(0,L_p,20);              % ----- Default Positive Particle Radius Discretized Domain
                    Ln='L_p_mesh';
                end
        
        S = struct(Rn,R,Ln,L);

    else
        
        fprintf(['[WARNING]: No parameter values detected to define model spatial domain...\n' ...
            'Please, select one of the following available:\n\n' ...
            '"Chen2020"\n'])
        
    end
    
end