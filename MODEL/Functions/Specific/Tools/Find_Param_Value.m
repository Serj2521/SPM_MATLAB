function [X]=Find_Param_Value(S,string_f)
    %{
    DESCRIPTION: Parameter values find function for Battery parameter set Model Structs
        -      S    >>>  Upload the parametrization struct with two fields
                         >> Parameter 
                         >> Value

        -  string_f >>>  Selects the string to find

        -      X    >>>  
    %}
   %TO DO LIST:
    %-- Add error debuging message when not found parameter
    
        for i=1:length(S)
            
            S(i).Parameter==string_f;
            
            if ans==true

                X=S(i).Value;
        
        end

end