% Mínimos Quadrados

%% Definindo uma reta com ruídos em Y
x = 0:10;
y = 2*x + 1 + rand(size(x)); % Com uma reta

%% Matriz para descobrir A e B
%%% Regressão Linear
A = [sum(x.*x) sum(x); sum(x) length(x)]; % length(x) = size(x,2)
B = [sum(x.*y); sum(y)];
sol = A\B;
a = sol(1,1);
b = sol(2,1);
y2 = a*x + b; 

%% Mostrando na tela
plot(x, y, '*', x, y2); 
title('Regressão Linear por Mínimos Quadrados');
xlabel('x');
ylabel('y');
legend('Dados com Ruído', 'Reta Ajustada');

%% Anotações Gerais
% rand(3), números aleatórios geram um ruído no y
% rand(1, 10)/10, uma linha com 10 números/10
% '*' mostra nuvem de pontos no plot
