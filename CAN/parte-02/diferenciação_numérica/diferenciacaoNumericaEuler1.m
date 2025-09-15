%% Método da Diferenciação Numérica de Euler
L = 10;
F = @(x) exp(x); % Função exata
yo = 1;          % Condição inicial
y = [yo];        % Vetor para armazenar os valores de y
h = 0.01;        % Passo
x = 0:h:L;       % Vetor de valores de x

m = length(x) - 1; % Mesmo que: m = L/h;
for i = 1:m
    y1 = yo + h * yo; % Aplicação do método de Euler
    y = [y y1];       % Armazena o novo valor de y
    yo = y1;          % Atualiza yo para o próximo passo
end

% Plotando os resultados
figure; % Cria uma nova janela de gráfico
plot(x, y, '*', x, F(x));
legend('Método de Euler', 'Solução Exata');
xlabel('x');
ylabel('y(x)');
title('Método de Euler vs Solução Exata');

%% Plotando gráfico de erros
V = [];
Vh = [];
L = 1;
yo = 1;
h = 1;

for j = 1:4
    y = [yo];
    h = h / 10;
    x = 0:h:L;
    
    for i = 1:length(x) - 1
        y1 = yo + h * yo;
        y = [y y1];
        yo = y1;
    end
    
    erro = max(abs(y - F(x)));
    V = [V erro];
    Vh = [Vh h];
end

% Plotando o erro em função de h em escala log-log
figure; % Cria uma nova janela de gráfico
plot(log10(Vh), log10(V), '-o');
xlabel('log_{10}(h)');
ylabel('log_{10}(Erro)');
title('Erro do Método de Euler');
