function[C_s_p_surfrep] = Plot_3D_Solution(SOL_struct,DOM_struct,Data_res,str)
    %{
    DESCRIPTION: Parameter values find function for Battery parameter set Model Structs
        -      SOL_struct    >>>  Load the Solution struct with two fields
                         >> Time
                         >> Current
                         >> Concentration     

        -         str        >>>  User defined specific plots                
    %}
   %TO DO LIST
    %-- Add 

    tic
    figure('Name','SPM 3D Data plots','NumberTitle','off');

        %--- Extract solutions
                SOL_cell=struct2cell(SOL_struct);
                [t,I_app,Csp] = SOL_cell{:};

                DOM_cell=struct2cell(DOM_struct);
                [Rsp,Lsp] = DOM_cell{:};
            
            %-- Check functions
                exist t; 
                time_check=ans;
                exist Csp; 
                Csp_check=ans;
                exist str; 
                str_check=ans;
 
             %--- Resolution   
         
                num_res=round(length(t)*(str2double(regexp(Data_res,'(?<!\d)(\d)+(?!\d)','match'))/100));    % - Extract the percentage

                t_rep=linspace(0,t(end),num_res); % Define time representation
                
                %-- Vector resolution
                    for i=1:length(t_rep)
                        k(i)=find(0:length(t)>=t_rep(i),1);
                        C_s_p_surfrep(i,:) = Csp(k(i),:);
                    end
                    
        %--- Condition
                if time_check==1 && Csp_check==1


                    if str_check==1         %-- User's specified plot operation mode condition

                    else                    %-- Deffault plot output condition
                        
                        surf(Rsp(2:end),t_rep,C_s_p_surfrep,'facecolor','b','facealpha',0.3,'edgecolor',[1 0 1])
                        grid('on');
                        xlabel('Distance [m]','interpreter','latex'); ylabel('Time [h]','interpreter','latex'); zlabel('Concentration [mol/m3]','interpreter','latex');
                        title('Time vs R Positive particle Concentration [mol/m3]','interpreter','latex');
                        xlim([Rsp(1) Rsp(end)]);
                        ylim([t_rep(1) t_rep(end)]);
                        zlim([min(C_s_p_surfrep(:,end))-0.1*max(C_s_p_surfrep(:,end)) 1.1*max(C_s_p_surfrep(:,end))]);




                    end
                else
                    fprintf(['Any of the solution struct fields is missing, check the functions and the check outputs below:\n'])
                    time_check
                    Iapp_check
                    Csp_check
                end
    toc
    fprintf(['\n\n']) 
end