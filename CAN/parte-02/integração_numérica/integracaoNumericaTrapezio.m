% Integração Numérica
% Exemplo 1: Função e^(-x^2)
% dx = 0.001 (passo de integração)
% Definição da função: f(x) = e^(-x^2)
dx = 0.001; 
f = @(x) exp(-x .* x); % Define a função anônima
x = 0:dx:1; % Define o domínio de integração
y = f(x); % Calcula os valores da função
integral = sum(dx * y); % Calcula a integral numérica usando a soma de Riemann

% Exemplo 2: Área de um triângulo (aproximadamente 0.5)
% Função f(x) = x
dx = 0.001;
f = @(x) x; % Define a função anônima
x = 0:dx:1; % Define o domínio de integração
y = f(x); % Calcula os valores da função
integral = sum(dx * y); % Calcula a integral numérica

% Exemplo 3: Área de um triângulo (menos aproximado, com dx maior)
% Função f(x) = x
dx = 0.1;
f = @(x) x; % Define a função anônima
x = 0:dx:1; % Define o domínio de integração
y = f(x); % Calcula os valores da função
integral = sum(dx * y); % Calcula a integral numérica

% Correção para a soma de Riemann (método trapezoidal)
int2 = sum(y(2:end-1)); % Soma dos termos intermediários
integral_trapezoidal = dx * (0.5 * (y(1) + y(end)) + int2); % Soma trapezoidal
