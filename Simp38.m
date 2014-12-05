function [out] = Simp38(x, y)
    length = size(x,1);

    % Procedure requires sorted data
    sorted = sortrows([x,y],1);
    x = sorted(:,1);
    y = sorted(:,2);
 
    % If data too small just do the Simp13 method
    out = 0;
    if length < 4,
        out = Simp13(x,y);
        return;
    end
    
    % Grab the average increment for procedure
    h = AverageIncrement(x);
    
    % Whats the remainder from the procedure?
    modulo = mod(length - 1, 3);

    % Calculate integral for each    
    for i = 1:3:length - modulo - 1
        out = out + (h*3/8) * (y(i) + 3 * y(i+1) + 3 * y(i+2) + y(i+3));
    end
    
    % Apply Simp13 to remainder
    if modulo ~= 0
        remainder = length-modulo;
        out = out + Simp13(x(remainder:length),y(remainder:length));
    end
end
