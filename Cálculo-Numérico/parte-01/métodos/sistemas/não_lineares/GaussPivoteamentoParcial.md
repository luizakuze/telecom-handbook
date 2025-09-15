# Eliminação de Gauss com Pivoteamento Parcial

## Versão corrigida
```matlab
% Definição da matriz A e do vetor b
A = [0 0 1; 3 1 1; -1 -1 -1];
b = [1; 5; -3];

% Obtendo as dimensões da matriz A
[linha, coluna] = size(A);

% Eliminação Gaussiana com pivotamento parcial
for j = 1:coluna-1
    % Encontrar o máximo valor absoluto na coluna atual (para pivotamento)
    [maximo, posicaoRelativa] = max(abs(A(j:linha, j))); % posicaoRelativa é relativa ao subvetor
    
    % Ajustar a posição relativa para a posição absoluta
    posicao = posicaoRelativa + j - 1; % Converter para posição absoluta na matriz
    
    % Trocar a linha atual (j) com a linha da posição do valor máximo (posicao)
    A([posicao, j], :) = A([j, posicao], :); % Trocar linhas na matriz A
    b([posicao, j], :) = b([j, posicao], :); % Trocar linhas no vetor b
    
    % Eliminação dos elementos abaixo do pivot
    for i = j+1:linha
        % Calcula o multiplicador para zerar a posição A(i, j)
        pivo = A(i, j) / A(j, j); 
        % Atualiza a linha i de A subtraindo a linha j multiplicada pelo pivot
        A(i, :) = A(i, :) - A(j, :) * pivo; 
        % Atualiza o elemento correspondente em b
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

% Exibindo os resultados finais
[A, b, x]

```

## Versão em aula
```matlab
% A = [0 1; 2 2];
% b = [4; 8];

A = [0 0 1; 3 1 1; -1 -1 -1];
b = [1 ;5 ;-3];
%% alternando posições das linhas
% maximo = max(A(:,1));
% posicao = find(maximo == A(:,1));
% A([posicao,1],:) = A([1,posicao],:);
% b([posicao,1],:) = b([1,posicao],:);
% A
% b

[m, n] = size(A);

for j = 1:n-1
    maximo = max(abs(A([j:m],j))); % abs para evitar erro c valores negativos
    posicao = find(maximo == abs(A([j:m],j)))+j-1;
    A([posicao,j],:) = A([j,posicao],:);
    b([posicao,j],:) = b([j,posicao],:);
    
    for i = j+1:m
        pivo = A(i,j)/A(j,j);
        A(i,:) = A(i,:) - A(j,:) * pivo;
        b(i) = b(i) - b(j) * pivo;
    end
end

% Normalizmaximo = max(A(:,1));
for i = 1:m
    b(i) = b(i) / A(i,i);
    A(i,:) = A(i,:) / A(i,i);
end

% Resolvendo o sistema 
x = zeros(m, 1);

for i = n:-1:1
    soma = 0;
    for j = i+1:n
       soma = soma + A(i,j) * x(j);
    end
    x(i) = b(i) - soma;
end

[A, b, x]
```
## Versão extra
```matlab
% Definição da matriz A e do vetor b
A = [0 0 1; 3 1 1; -1 -1 -1];
b = [1; 5; -3];

% Obtendo as dimensões da matriz A
[linha, coluna] = size(A);

% Eliminação Gaussiana com pivotamento parcial
for j = 1:coluna-1
    % Encontrar o máximo valor absoluto na coluna atual (para pivotamento)
    maximo = max(abs(A(j:linha, j))); 
    % Encontrar a posição do valor máximo
    posicao = find(maximo == abs(A(j:linha, j))) + j - 1;
    
    % Trocar a linha atual (j) com a linha da posição do valor máximo (posicao)
    A([posicao, j], :) = A([j, posicao], :);
    b([posicao, j], :) = b([j, posicao], :);
    
    % Eliminação dos elementos abaixo do pivot
    for i = j+1:linha
        % Calcula o multiplicador para zerar a posição A(i, j)
        pivo = A(i, j) / A(j, j);
        % Atualiza a linha i de A subtraindo a linha j multiplicada pelo pivot
        A(i, :) = A(i, :) - A(j, :) * pivo;
        % Atualiza o elemento correspondente em b
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

% Exibindo os resultados finais
[A, b, x]

```
