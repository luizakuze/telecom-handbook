% Mínimos Quadrados
% Este exemplo utiliza o método dos mínimos quadrados para ajustar uma reta 
% aos dados que seguem aproximadamente uma curva exponencial com ruído.

%% Definindo uma reta com ruídos em Y
x = 0:10; % Vetor x com valores inteiros de 0 a 10
y = 3*exp(x/5) + rand(size(x)); % Função exponencial com ruído aleatório em y

%% Matriz para descobrir A e B
%%% Regressão Linear
% A regressão linear aqui busca ajustar uma reta y = ax + b aos dados
% O sistema de equações lineares para a regressão linear é representado pela matriz A e o vetor B

A = [sum(x.*x) sum(x);        % Matriz A é construída com somas de x² e x
     sum(x)    size(x, 2)];   % A segunda linha contém a soma de x e o número de pontos (n)

B = [sum(x.*y);   % Vetor B contém somas de x*y e a soma de y
     sum(y)];

sol = A\B;  % Resolve o sistema linear para encontrar os coeficientes a e b
a = sol(1); % Coeficiente angular (a) da reta ajustada
b = sol(2); % Coeficiente linear (b) da reta ajustada

y2 = a*x + b; % Calcula os valores ajustados da reta y = ax + b

%% Mostrando na tela
plot(x, y, '*', x, y2); % Plota os pontos reais (com ruído) e a reta ajustada
xlabel('x'); % Rotula o eixo x
ylabel('y'); % Rotula o eixo y
legend('Dados com Ruído', 'Reta Ajustada'); % Adiciona uma legenda para identificar as séries
title('Ajuste Linear por Mínimos Quadrados'); % Adiciona um título ao gráfico
