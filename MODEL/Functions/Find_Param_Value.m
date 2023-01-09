function [X]=Find_Param_Value(S,string_f)
    %{
    DESCRIPTION: Parameter values find function for Battery parameter set Model Structs
        -      S    >>>  Upload the parametrization struct with two fields
                         >> Parameter 
                         >> Value

        -  string_f >>>  Selects the string to find

        -      X    >>>  
    %}
    
        for i=1:length(S)
            
            S(i).Parameter==string_f;
            
            if ans==true

                X=S(i).Value;

            end
        
        end

end