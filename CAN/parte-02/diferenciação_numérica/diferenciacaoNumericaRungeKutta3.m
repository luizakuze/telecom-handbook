L = 1;             % Define o comprimento total
y0 = 1;            % Valor inicial de y(0)
F = @(x) exp(sin(x)); % Função exata para comparação (solução analítica para y' = ycos(x))
h = 0.1;           % Passo de integração

y = [y0];          % Inicializa o vetor y com o valor inicial
x = 0:h:L;         % Define o vetor de pontos x

% Loop para calcular a solução numérica usando o método de Runge-Kutta de 4ª Ordem
for i = 1:L/h
    k1 = y0 * cos(x(i));               % Calcula o valor de k1
    k2 = (y0 + h * k1 / 2) * cos(x(i) + h / 2); % Calcula o valor de k2
    k3 = (y0 + h * k2 / 2) * cos(x(i) + h / 2); % Calcula o valor de k3
    k4 = (y0 + h * k3) * cos(x(i) + h);         % Calcula o valor de k4
    y1 = y0 + h * (k1 + 2*k2 + 2*k3 + k4) / 6;  % Calcula o próximo valor de y usando a fórmula do Runge-Kutta
    y = [y y1];                      % Armazena o valor calculado no vetor y
    y0 = y1;                         % Atualiza y0 para o próximo passo
end 

% Plota a solução numérica e a solução exata
plot(x, y, 'b-', x, F(x), 'r--');
legend('Aproximado', 'Exato'); % Adiciona legenda
xlabel('x');                   % Rótulo do eixo x
ylabel('y(x)');                % Rótulo do eixo y
title('Método de Runge-Kutta de 4ª Ordem para y'' = ycos(x)'); % Título do gráfico
