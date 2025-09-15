# Versão 1 - Sem concatenar matrizes
```matlab
format long

% Para linha, o somatório dos termos que não são diagonal (aii) tem que ser um número maior que o valor o termo diagonal (aii); 
% Isso vale para colunas também.

% colocando no terminal, chega aproximadamente a 1 a cada iteração
% x = [0 ; 0];
% a = [0 1/2 ; 4/9 0];
% b = [3/2 ; 13/9];
% x1 = -a*x+b

a = [5 2 1; -1 4 2; 2 3 10];
b = [7; 3; -1];
[m,n] = size(a);

for i = 1:n
    b(i) = b(i)/a(i,i); % tem que ser b primeiro, para manter o valor da diagonal
    a(i,:) = a(i,:)/a(i,i);
    a(i,i)=0;
end

x0 = [1;1;1]; % chute inicial
x1 = -a*x0+b
erro = sum(abs(x1-x0))/sum(abs(x1));

while(erro>0.0001)
    x0 = x1;
    x1 = -a*x0+b;
    erro = sum(abs(x1-x0))/sum(abs(x1));
end

a
b
erro
x1
```

# Versão 2 - Concatenando Matrizes
```matlab
% Definição da matriz A e vetor b
A = [5 2 1; -1 4 2; 2 3 10];
b = [7; 3; -1];

% Concatenando a matriz A e o vetor b
Ab = [A b];

% Tamanho da matriz A
[m, n] = size(A);

% Normalização de Ab
for i = 1:n
    Ab(i, :) = Ab(i, :) / Ab(i, i);
    Ab(i, i) = 0; % Ajusta a diagonal principal para zero após normalização
end

% Chute inicial
x0 = [1; 1; 1];

% Primeira iteração
x1 = zeros(n, 1); % Inicializa x1
for i = 1:n
    x1(i) = -Ab(i, 1:n) * x0 + Ab(i, n + 1); % Ab(i, n + 1) acessa a última coluna
end

% Cálculo do erro inicial
erro = sum(abs(x1 - x0)) / sum(abs(x1));

% Loop até que o erro seja menor que a tolerância
while erro > 0.0001
    x0 = x1;
    x1 = zeros(n, 1); % Inicializa x1
    for i = 1:n
        x1(i) = -Ab(i, 1:n) * x0 + Ab(i, n + 1); % Ab(i, n + 1) acessa a última coluna
    end
    erro = sum(abs(x1 - x0)) / sum(abs(x1));
end
```
