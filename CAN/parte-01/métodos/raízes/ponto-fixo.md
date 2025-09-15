# Método do Ponto Fixo

## Código corrigido
```matlab
% Definição da função phi
phi = @(x) 2*exp(x) + 4*x;

% Valor inicial
x1 = 1.99;

% Iterações
x2 = phi(x1);
while abs(x1 - x2) > 0.0001
    x1 = x2;
    x2 = phi(x1) % Avalia phi em x2
end
```
