%% Parâmetros iniciais
L = 2 * pi;           % Limite superior de x (2π)
F = @(x) exp(sin(x)); % Solução exata da equação diferencial y' = y * cos(x)
yo = 1;               % Condição inicial y(0) = 1
y = [yo];             % Vetor para armazenar valores de y
h = 0.1;              % Passo
x = 0:h:L;            % Vetor de valores de x

%% Método de Euler
m = length(x) - 1;
for i = 1:m
    y1 = yo + h * (yo * cos(x(i))); % Cálculo do próximo valor usando Euler
    y = [y y1];                     % Armazena o novo valor de y
    yo = y1;                        % Atualiza yo para o próximo passo
end

% Exibe o valor aproximado de y(2*pi)
fprintf('O valor aproximado de y(2*pi) é %.4f\n', y(end));

% Plotando o resultado
figure; 
plot(x, y, '-o', x, F(x));          % Plota a solução numérica e a exata
legend('Método de Euler', 'Solução Exata');
xlabel('x');
ylabel('y(x)');
title('Método de Euler para y'' = y*cos(x)');

%% Plotando gráfico de erros
V = [];       % Vetor para armazenar os erros máximos
Vh = [];      % Vetor para armazenar os valores de h (passo)
yo = 1;       % Reinicia a condição inicial y(0) = 1
h = 0.1;      % Reinicia o passo

for j = 1:4
    y = [yo];
    h = h / 10;              % Diminui o passo h em cada iteração
    x = 0:h:L;               % Recalcula o vetor de x com o novo h
    
    for i = 1:length(x) - 1
        y1 = yo + h * (yo * cos(x(i))); % Calcula o próximo valor de y
        y = [y y1];                     % Armazena o novo valor de y
        yo = y1;                        % Atualiza yo para o próximo passo
    end
    
    % Calcula o erro máximo entre a solução numérica e a solução exata
    erro = max(abs(y - F(x))); 
    V = [V erro];  % Armazena o erro máximo no vetor V
    Vh = [Vh h];   % Armazena o valor atual de h no vetor Vh
end

% Plotando o erro em função de h em escala log-log
figure;
plot(log10(Vh), log10(V), '-o');
xlabel('log_{10}(h)');
ylabel('log_{10}(Erro)');
title('Erro do Método de Euler para y'' = y*cos(x)');
