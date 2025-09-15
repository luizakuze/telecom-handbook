# Método da Eliminação de Gauss

## Versão 1.1 - A e B matrizes separadas
```matlab
A = [1, 4, 2; -1, 0, 3; 1, -2, 1];
b = [17; 11; 1];

[m, n] = size(A);

% Eliminação Gaussiana sem Pivoteamento
for j = 1:n-1
    for i = j+1:m
        pivo = A(i, j) / A(j, j);
        A(i, :) = A(i, :) - A(j, :) * pivo;
        b(i) = b(i) - b(j) * pivo;
    end
end

% Substituição Reversa
x = zeros(m, 1);

for i = m:-1:1
    soma = 0;
    for j = i+1:n
        soma = soma + A(i, j) * x(j);
    end
    x(i) = (b(i) - soma) / A(i, i);
end

[A, b, x]
```
## Versão 1.2 - A e B matrizes separadas
```matlab

A = [1, 4, 2; -1, 0, 3; 1, -2, 1];
b = [17; 11; 1];

[linha, coluna] = size(A);

% Eliminação Gaussiana sem Pivoteamento
for j = 1:coluna-1
    for i = j+1:linha
        pivo = A(i, j) / A(j, j);
        A(i, :) = A(i, :) - A(j, :) * pivo;
        b(i) = b(i) - b(j) * pivo;
    end
end

% Substituição Reversa
x = zeros(linha, 1);

for i = linha:-1:1
    soma = 0;
    for j = i+1:coluna
        soma = soma + A(i, j) * x(j);
    end
    x(i) = (b(i) - soma) / A(i, i);
end

[A, b, x]
```

## Versão 2 - Com Matrizes Concatenadas
```matlab
%% entrando com valores e concatenando matrizes A e B em AB

A = [1, 4, 2; -1, 0, 3; 1, -2, 1];
b = [17; 11; 1];
AB = [A B];
[N_linhas,N_colunas] = size(AB); 
AB

%% zerando as diagonais
for i = 1:N_colunas
    for j = i+1:N_linhas
        fator = AB(j,i)/AB(i,i);
        AB(j,:) = AB(j,:) - fator * AB(i,:);
    end;
end;

AB

%% resolver equaÃ§Ãµes de baixo para cima
resultados = zeros(N_linhas, 1);

for i = N_linhas:-1:1 % decrementando de 1 em 1 (soma -1)
    somaB = AB(i, N_colunas);
    somaA = 0;
    for j = i+1:N_colunas-1
        % soma da matriz A
        somaA = somaA + AB(i,j) * resultados(j,1);
    end;
    resultados(i,1) = (somaB - somaA)/AB(i,i);
end;
resultados
```
