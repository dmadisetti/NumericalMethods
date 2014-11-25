function [max,min] = Range(x)
    xSize = size(x);
    
    length = xSize(1);

    if length < 1,
        return; 
    end
    
    max = x(1);
    min = x(1);
    
    for i = 1:length
        if x(i)> max
            max = x(i);
        end
        if x(i)< min
            min = x(i);
        end
    end
end