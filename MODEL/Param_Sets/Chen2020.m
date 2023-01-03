%% MODEL: Chen2022

Param_Val_M = [

   % General Constants

    {'Faraday Constant [C/mol]',96487};
    {'Molar Gas Constant [J⋅K^−1⋅mol^−1]',8.314};

   % Cell Constructive Param

    {'Electrode Cross-Sectional area [m2]',0.1027};
    {'Positive Current Collector Thickness [m]',1e-5};
   
   % Positive electrode parametrization

    {'Positive Particle Radius [m]',5.22e-6};
    {'Positive Electrode thickness [m]',7.56e-5};
    {'Positive Electrode Minimum Concentration [mol/m^3]',17038};
    {'Positive Electrode Maximum Concentration [mol/m^3]',63104};
    {'Volume fraction of the solid electrode material in the porous electrode [%]',0.665};
    {'Positive Electrode Solid Diffusivity [m^2/sec]',4e-15}

    ];



%{
%% Cell Constructive details struct
cell2mat(Param_Val_M(:,2))
Param_val.Cell = struct( ...
    'A',          {'Faraday Constant [C/mol]',0.1027},...
    'Pos_C_L',    {'Positive Current Collector Thickness [m]',1e-5} ...
    );

%% Positive electrode parametrization struct

Param_val.Pos_e = struct( ...
    'R_p',          {'Positive Particle Radius [m]',5.22e-6},...
    'L_p',          {'Positive Electrode thickness [m]',7.56e-5}, ...
    'C_min_p',      {'Positive Electrode Min Concentration [mol/m^3]',17038},...
    'C_max_p',      {'Positive Electrode Max Concentration [mol/m^3]',63104}, ...   
    'Eps_p',        {'Volume fraction of the solid electrode material in the porous electrode [%]',0.665}, ...
    'D_p',          {'Positive Electrode Solid Diffusivity [m^2/sec]',4e-15} ...
    );




save('Chen2020.mat','-struct','Param_val');
disp('Contents of newstruct.mat:')
whos('-file','Chen2020.mat')

%}
