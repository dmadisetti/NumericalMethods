function [out] = Simp38(x, y)
    length = size(x,1);

    sorted = sortrows([x,y],1);
    x = sorted(:,1);
    y = sorted(:,2);
 
    out = 0;
    if length < 4,
        out = Simp13(x,y);
        return;
    end
    
    h = AverageIncrement(x);
    
    modulo = mod(length - 1, 3);
    
    for i = 1:3:length - modulo - 1
        out = out + (h*3/8) * (y(i) + 3 * y(i+1) + y(i+2) + y(i+3));
    end
    
    if modulo ~= 0
        remainder = length-modulo;
        out = out + Simp13(x(remainder:length),y(remainder:length));
    end
end
