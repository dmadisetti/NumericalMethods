function [max,min] = Range(x)
    length = size(x,1);

    if length < 1,
        return; 
    end
    
    % Default max and min to first element  
    max = x(1);
    min = x(1);
    
    % Find the minimum and maximum by comparing to all values
    for i = 1:length
        if x(i)> max
            max = x(i);
        end
        if x(i)< min
            min = x(i);
        end
    end
end