function [out] = Trapezoidal(x, y)
    length = size(x,1); 
    
    % Need sorted data
    sorted = sortrows([x,y],1);
    x = sorted(:,1);
    y = sorted(:,2);
    
    out = 0;
    % If only 1 data point, no area
    if length < 2,
        return; 
    end
    
    % Calculate integral by trapezoids
    for i = 2:1:length
        out = out + (x(i) - x(i-1)) * (y(i-1) + y(i))/2;
    end
end
