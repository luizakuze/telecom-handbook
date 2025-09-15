f = @(x) x*x+x-6;
df = @(x) 2*x+1; % derivada


x1 = 5;
x2 = x1 - f(x1)/df(x1);

erro = abs(x2-x1);

%% iteração

while erro > 10^-6
    x1 = x2;
    x2 = x1 - f(x1)/df(x1);
    erro = abs(x2-x1);
end
x3 % resultado da raiz aproximada
