format long

delta = 0.0001; % Definição do passo de integração (d = delta)

x = -2:delta:3; % Definição do domínio de integração de -2 a 3 com passo delta
f = @(x) x .* x; % Função a ser integrada, f(x) = x^2
F = f(x); % Calcula os valores da função f(x) no domínio x

m = size(x, 2); % Determina o número de pontos no domínio x

% Construção do vetor de coeficientes de Simpson
v = ones(1, m); % Inicializa o vetor com todos os valores iguais a 1
v(2:2:m) = 4; % Define os coeficientes pares como 4
v(3:2:m-1) = 2; % Define os coeficientes ímpares internos como 2

% Cálculo da integral usando o método de Simpson
integral = sum(delta * F .* v / 3); % Aplica a fórmula de Simpson: (delta/3) * soma(F(x) * v)
