function [out] = CurveFit(x, y, order)
    
    % Curve fit algorithm ...
    % With inspiration from Dr. Banerjee
    length = size(x,1);
    matrix = zeros(order + 1, order + 1);
    answers = zeros(1, order + 1)';
    for i = 1:order +1
        bsum = 0;
        for j = 1:order +1
            p = i + j - 2;
            for k= 1:length
                matrix(i,j) = matrix(i,j) + x(k)^p;
                bsum = bsum + (y(k)*(x(k)^(i-1)));
            end
        end
        answers(i) = bsum;
    end
    variables = answers' * inv(matrix);

    % create equation from matrix
    syms x;
    out = 0;
    for i = 1:order +1
        out = out + variables(i)*x^(i-1);
    end
end