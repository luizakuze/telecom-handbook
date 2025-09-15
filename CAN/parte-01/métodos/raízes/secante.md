
# Método da Secante

```matlab
% secante

%% definindo a função
f = @(x)x^2-3;

% valores para raíz de 3
x1 = 1;
x2 = 1.2;

%% derivada aproximada
fx = (f(x2)-f(x1))/(x2-x1);

x3 = x2 - (f(x2)/fx);

%% iteração

%erro = abs(x3-x2);

while(abs(x3-x2) > 10^-3)
    x1 = x2;
    x2 = x3;
    
    fx = (f(x2)-f(x1))/(x2-x1);
    
    x3 = x2 - (f(x2)/fx);
end

x3
```
