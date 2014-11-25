function [out] = Simp13(x, y)
    length = size(x,1);
        
    sorted = sortrows([x,y],1);
    x = sorted(:,1);
    y = sorted(:,2);
    
    out = 0;
    if length < 3,
        out = Trapezoidal(x,y);
        return;
    end

    h = AverageIncrement(x);
    
    modulo = mod(length - 1, 2);
    
    for i = 2:2:length - modulo
        out = out + (h/3) * (y(i-1) + 4 * y(i) + y(i+1));
    end
    
    if modulo ~= 0
        remainder = length-modulo;
        out = out + Trapezoidal(x(remainder:length),y(remainder:length));
    end
end