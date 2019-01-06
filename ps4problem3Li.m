clear;
clc;
load carbig;
x1 = Weight;
x2 = Horsepower;
y = MPG;

%{
b. Find beta^star by solving the normal system numerically in Matlab. 
Remark: The original data contains NaN values, so before finding beta^star, 
you will have to “clean” the data by removing all those values.
%}

counter = 1;
while counter <= length(x1)
    % remove all NaN values 
    if (isnan(x1(counter))) || (isnan(x2(counter))) || (isnan(y(counter)))
        x1(counter) = [];
        x2(counter) = [];
        y(counter) = [];
    else 
        counter = counter + 1;
    end
end

s = size(x1);
A = zeros(s(1), 4); % preallocate matrix A

for j=1:s(1)
    A(j,:) = [1, x1(j), x2(j), x1(j) * x2(j)];
end

b = inv(A'*A) * A' * y; % calculate beta^star

%{
c. Plot the scatter plot of the data {(x(i)1, x(i)2, y(i))}, i = 
1, . . . , m and the fitted surface y = f(x1, x2) given by (4).
%}

figure(1); 
syms f(a, c);
f(a, c) = b(1) + b(2) * a + b(3) * c + b(4) * a * c;
ezsurf(f, [0,6000,0,200]); % plot fitted surface
hold on;
scatter3(x1, x2, y, 5, 'filled', 'black'); % plot data
title('Data Points and Fitted Surface y = f(x1, x2)');