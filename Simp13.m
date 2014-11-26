function [out] = Simp13(x, y)
    length = size(x,1);

    % Procedure requires sorted data        
    sorted = sortrows([x,y],1);
    x = sorted(:,1);
    y = sorted(:,2);
    
    % If data too small just do the Trapezoidal method
    out = 0;
    if length < 3,
        out = Trapezoidal(x,y);
        return;
    end

    % Grab the average increment for procedure
    h = AverageIncrement(x);

    % Whats the remainder from the procedure?    
    modulo = mod(length - 1, 2);
    
    % Calculate integral for each
    for i = 2:2:length - modulo
        out = out + (h/3) * (y(i-1) + 4 * y(i) + y(i+1));
    end

    % Apply Trapezoidal to remainder    
    if modulo ~= 0
        remainder = length-modulo;
        out = out + Trapezoidal(x(remainder:length),y(remainder:length));
    end
end