% matrizes

% matriz de zeros 10x10 linhaSxColunas
z=zeros(10);

% matriz de um 
ones(10);

% matriz 5x3
zeros(5,3);

% zerando aquela matriz de um
ones(10)*0;

% matriz identidade
eye(4);

mat1=[3 4; 2 3]; % matriz 2x2
det(mat1); % determinante
inv(mat1); % inversa: troca posição, troca sinal

% preenchendo coluna no meio com 1 2 3 4 5
mat2 = zeros(5,3);

% :.2 = coluna 2
% : todos
mat2(:,2)=[1:5];

% notação científica
format shortEng;
3.2;

% aumentar numero de casas exibidas
format long;
3.2;

mat2(1,:)=[5 9 -1];
mat2(1,:)=[5 9 -1]';

numel(mat2);

% o que era linha vira coluna
mat2';

% transformando em 1 linha apena e 15 colunas
reshape(mat2, 1, 4);