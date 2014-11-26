function [out] = AverageIncrement(x)
	% Grab the length of the data and divide
    length = size(x,1);
    
    out = 0;
    if length < 2,
        return; 
    end

    [max,min] = Range(x);
    
    % Average increment is the Range over the lenth of the data set
    out = (max-min)/length;
end
