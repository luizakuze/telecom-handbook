L = 1; 
F = @(x) exp(x);
h = 1;

V = [];  % Vetor para armazenar os erros
Vh = []; % Vetor para armazenar os valores de h

for i = 1:4
    y0 = 1;       % Reinicia y0 para o valor inicial
    y = [y0];     % Inicializa o vetor y com o valor inicial
    h = h / 5;    % Reduz o passo h a cada iteração
    x = 0:h:L;    % Define o vetor de pontos x

    % Loop para calcular a solução numérica usando o método de Runge-Kutta de 4ª Ordem
    for j = 1:L/h
        k1 = y0;
        k2 = y0 + h * k1 / 2;
        k3 = y0 + h * k2 / 2;
        k4 = y0 + h * k3;  
        y1 = y0 + h * (k1 + 2 * k2 + 2 * k3 + k4) / 6;
        y = [y y1];
        y0 = y1;
    end 

    % Calcula o erro máximo entre a solução aproximada e a solução exata
    erro = max(abs(y - F(x)));
    V = [V erro];  % Armazena o erro no vetor V
    Vh = [Vh h];   % Armazena o valor de h no vetor Vh
end

% Plota o erro em escala log-log
plot(log(Vh), log(V));
xlabel('log(h)');
ylabel('log(Erro)');
title('Erro vs Passo de Integração (h)');
