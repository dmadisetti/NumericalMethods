function [out] = AverageIncrement(x)
    length = size(x,1);
    
    out = 0;
    if length < 2,
        return; 
    end

    [max,min] = Range(x);
    
    out = (max-min)/length;
end
