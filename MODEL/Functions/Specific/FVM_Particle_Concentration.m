function [c] = FVM_Particle_Concentration(C0,Particle_Struct,Constants_Struct,dt,I_App)
    %{

        SPM calculator for Lithium ion concentration vs time and particle radius using Finite Difference Method:
            % --- C0        >>>     Initial particle concentration distribution vector [mol/m^3]

        Variables to be extracted from Particle_struct:
            % --- R         >>>     Particle Radius vector [m]
            % --- L         >>>     Electrode Thickness [m]
            % --- dR        >>>     Differential radial vector [m]
            % --- Sa        >>>     Outer shell surface vector [m^2]
            % --- dV        >>>     Shell volumetric difference vector [m^3]
            % --- A         >>>     Electrode Cross-Sectional area [m^2]
            % --- eps       >>>     Volume fraction of the solid electrode material in the porous electrode [%]
            % --- D         >>>     Electrode Solid Diffusivity [m^2/sec]
            % --- C_max     >>>     Electrode Maximum Concentration [mol/m^3]
            % --- C_min     >>>     Electrode Minimum Concentration [mol/m^3]
          
        Variables to be extracted from Constants_Struct:
            % --- F         >>>     Faraday Constant [C/mol]
            % --- R         >>>     Molar Gas Constant [J⋅K^−1⋅mol^−1]

        Time and current calculation variables:
            % --- dt        >>>     Time differential for calculation
            % --- I_App     >>>     Applied current in dt

        Solution:
        % --- Cf        >>>     Final particle concentration distribution vector

    %}
    
    %TO DO LIST:
         %--MAIN
             %-- Update when struct parameters conformation is modified
        
        
           %Extract values from structs
                Particle_cell=struct2cell(Particle_Struct);
                [R_p,L,dR,Sa,dV,dx,A,eps,D,C_max,C_min] = Particle_cell{:};
                Constants_cell=struct2cell(Constants_Struct);
                [F,R] = Constants_cell{:};

           %Init
                c=C0(1:(length(R_p)-1));
                

     %--- Calculation
        
       

         %-- Step Lithium ion Flux through the electrode [mol/m^2/sec] 
            J=I_App*R_p(end)/F/3/eps/A/L(end);

          %-- Flux at surfaces between "bins" [mol/m^2/sec] 
            N = -D*diff(c)/dR;

          %-- Total moles crossing surfaces [mol] 
            M = N.*Sa(2:end-1);

          %-- Concatenate change in particle concentration distribution via diffusion [mol/m^3]
            c = c + ([0 M] - [M 0])*dt./dV;

          %-- Concentration at particle boundary change according to flux [mol/m^3]
            c(end) = c(end) + J*Sa(end)*dt/dV(end); 



       

end