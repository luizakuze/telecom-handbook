format long

a = [5 2 1; -1 4 2; 2 3 10];
b = [7; 3; -1];
[linha, coluna] = size(a);

% Normalização da matriz e vetor b
for i = 1:linha
    b(i) = b(i) / a(i,i); % Normaliza b com o elemento da diagonal de a
    a(i,:) = a(i,:) / a(i,i); % Normaliza a linha de a pelo elemento da diagonal
    a(i,i) = 0; % Zera o elemento da diagonal (substituído por 0)
end

% Vetor inicial x0
x0 = [1; 1; 1]; 
x1 = x0; % Copia x0 para x1

% Primeira iteração fora do loop while
for i = 1:linha 
    x1(i) = -a(i,:) * x1 + b(i);   
end

% Calcula o erro inicial
erro = sum(abs(x1 - x0)) / sum(abs(x1));

% Loop até que o erro seja menor que o tolerado
while erro > 0.0001
    x0 = x1; % Atualiza x0
    for i = 1:linha
        x1(i) = -a(i,:) * x1 + b(i); % Atualiza x1 usando o método Gauss-Seidel
    end
    
    % Recalcula o erro
    erro = sum(abs(x1 - x0)) / sum(abs(x1));
end

% Verifica a solução final
a = [5 2 1; -1 4 2; 2 3 10];
a * x1
x1
