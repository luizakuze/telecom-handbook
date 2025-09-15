%% Mínimos Quadrados
% Exemplo para função: y = ax² + bx + c
% Este script demonstra como ajustar uma parábola aos dados usando o método
% dos mínimos quadrados.

%% Definindo uma reta com ruídos em Y
x = [-1:0.1:1]; % Vetor x com valores de -1 a 1, com intervalos de 0.1
% y = 3*x.^2 + 2*x + 1 + rand(size(x)) % Exemplo de geração de dados com ruído
y = [2.5338    1.7392    2.1458    1.4081    1.1740   1.4963    0.6903    0.7184    1.3879 1.4335    1.5261    1.9597    2.2273    2.6514    2.5680    3.4425    3.8367    4.2665     4.5816    6.0102    6.3376];

% Vetor y com valores experimentais (possivelmente com ruído)

%% Matriz para descobrir A, B e C
%%% Regressão Linear para uma função quadrática y = ax² + bx + c
A = [sum(x.*x.*x.*x) sum(x.*x.*x) sum(x.*x);  % Construção da matriz A
     sum(x.*x.*x)    sum(x.*x)    sum(x);     % A matriz A contém somas de potências de x
     sum(x.*x)       sum(x)       size(x,2)]; % Incluindo uma linha com a soma de x e a quantidade de pontos

B = [sum(y.*x.*x);   % Construção do vetor B
     sum(y.*x);      % B contém somas de y multiplicado por potências de x
     sum(y)];        % Inclui também a soma simples de y

sol = A\B;  % Resolução do sistema de equações lineares para encontrar a, b e c
a = sol(1); % Coeficiente a (termo quadrático)
b = sol(2); % Coeficiente b (termo linear)
c = sol(3); % Coeficiente c (termo constante)

% O valor de 'a' foi ajustado manualmente para 2.8, possivelmente devido a
% conhecimento prévio ou ajuste empírico
a = 2.8;

%% Calculando os valores ajustados
y2 = a*x.^2 + b*x + c; % Calcula os valores de y usando a equação ajustada

%% Calculando o erro
erro = sum((y2 - y).*(y2 - y)); % Calcula o erro quadrático entre os valores ajustados e os dados reais

%% Mostrando na tela
plot(x, y, '*', x, y2); % Plota os dados reais como pontos ('*') e a curva ajustada
xlabel('x'); % Rotula o eixo x
ylabel('y'); % Rotula o eixo y
