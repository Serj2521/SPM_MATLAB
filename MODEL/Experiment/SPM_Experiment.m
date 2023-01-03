function [S] = SPM_Experiment(MODE,Exp_M,dt)
%{
\--- MODE  >>> String (Deffault / Excel) to switch between operation modes

\--- Exp_M >>> Experiment string

             \-- IF "Deffault"  >>> String Array at different CC/CV rates until defined Voltage/Time constraints. The following syntax refer to experiment set options

                    \- Charge at "X" (V or A) until (voltage, time or current) reach "Y" (volts, amperes or seconds)
                    \- Discharge at "X" (V or A) until (voltage, time or current) reach "Y" (volts, amperes or seconds)
                    \- Rest until time reach Y seconds

             -- IF "Excel" >>> Built Current dataset according to a two columns Excel file (1st Column: Experiment time [s] ; 2nd Column: Current [A])

\---  dt  >>> Defines differential to generate time vector in deffault operation mode

\---  S   >>> 

%}

%To do List:
 %-
EXP_C_Steps={};
    if MODE=="Deffault"

        for i=1:length(Exp_M)

            if strfind(Exp_M(i),'Charge')==1
                if strfind(Exp_M(i),'time')>0

                    Step_input_data=str2double(regexp(Exp_M(i),'(?<!\d)(\d)+(?!\d)','match'));     % - Extract the number from each step
                    Step_Current_Vector=-Step_input_data(1)*ones(Step_input_data(2),1);            % - Generates Current Vector
                    EXP_C_Steps=[EXP_C_Steps;Step_Current_Vector];                               % - Concatenate current in cell struct
                
                else

                    fprintf(['[WARNING]: Error in experiment step: ']) 
                    fprintf('%i',i)
                    fprintf(['. Please, check syntax.\n\n']) 

                end

            elseif strfind(Exp_M(i),'Discharge')==1
                if strfind(Exp_M(i),'time')>0
               
                    Step_input_data=str2double(regexp(Exp_M(i),'(?<!\d)(\d)+(?!\d)','match'));    % - Extract the number from each step
                    Step_Current_Vector=Step_input_data(1)*ones(Step_input_data(2),1);           % - Generates Current Vector
                    EXP_C_Steps=[EXP_C_Steps;Step_Current_Vector];                              % - Concatenate current in cell struct
                
                else

                    fprintf(['[WARNING]: Error in experiment step: ']) 
                    fprintf('%i',i)
                    fprintf(['. Please, check syntax.\n\n']) 
                
                end

            elseif strfind(Exp_M(i),'Rest')==1
                if strfind(Exp_M(i),'time')>0 
               strfind(Exp_M(i),'seconds')>0 
                    Step_input_data=str2double(regexp(Exp_M(i),'(?<!\d)(\d)+(?!\d)','match'));    % - Extract the number from each step
                    Step_Current_Vector=zeros(Step_input_data,1);                                % - Generates Current Vector
                    EXP_C_Steps=[EXP_C_Steps;Step_Current_Vector];                              % - Concatenate current in cell struct
                
                else

                    fprintf(['[WARNING]: Error in experiment step: ']) 
                    fprintf('%i',i)
                    fprintf(['. Please, check syntax.\n\n']) 

                end

            else
                fprintf(['[WARNING]: Error in experiment step: ']) 
                fprintf('%i',i)
                fprintf(['. Please, check syntax.\n\n'])
            end
        end
        
        S = struct('Exp_Time',1,'App_Current',EXP_C_Steps);

    elseif MODE=="Excel"
        %xlsread("Experiment\EXCEL_Experiment_UPLOAD_example.xlsx")
    end
end