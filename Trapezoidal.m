function [out] = Trapezoidal(x, y)
    length = size(x,1); 
    
    sorted = sortrows([x,y],1);
    x = sorted(:,1);
    y = sorted(:,2);
    
    out = 0;
    if length < 2,
        return; 
    end
    
    for i = 2:1:length
        out = out + (x(i) - x(i-1)) * (y(i-1) + y(i))/2;
    end
end
