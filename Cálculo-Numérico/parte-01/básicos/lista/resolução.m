% Lista 1 CAN

% 1) 
% Criar uma matriz identidade I com dimensão 5x5 e substituir a posição I(2,3) por 10.
mat = eye(5,5);
mat(2,3) = 10;

% 2) 
% Criar uma matriz de zeros Z com dimensão 2x7, mudar toda linha 2 por 10 e o valor da posição Z(1,1) por 20.
z = zeros(2,7);
z(2,:) = 10;
z(1,1) = 20;

% Lista 1 CAN

% 3) 
% Criar a matriz A: [2 1; 3 4] e multiplicar a coluna 1 por 2.
a = [2 1; 3 4];
a(:,1) = a(:,1) * 2;

% 4) 
% Criar um vetor B com dimensão 1x11 de uns e mudar as posições pares por 2.
b = ones(1,11);
b(2:2:end) = 2;

% 5) 
% Criar o vetor V = [1 2] e em seguida criar a matriz X a partir da concatenação de V.
v = [1 2];
x = [v; v]; % x = [v' v'];

% 6) 
% Criar as matrizes M1 = [1 3; 2 1] e a matriz M2 que é a transposta de M1, qual é o máximo valor de M1 * M2.
m1 = [1 3; 2 1];
m2 = m1';
max(max(m1 * m2))

% 7) 
% Seja K1 = [1 -2 3 -5 6 7] e K2 = [-2 -10 -15 -20 40 3], multiplicar K1 e K2 elemento a elemento e calcular o menor valor do vetor resultado.
k1 = [1 -2 3 -5 6 7];
k2 = [-2 -10 -15 -20 40 3];
min(k1 .* k2)

% 8) 
% Criar um vetor VP com tamanho 7x1 com 7 primeiros pares positivos e VI com tamanho 1x7 com 7 primeiros ímpares positivos e calcular
% V1 = VP * VI e V2 = VI * VP. Há diferença entre V1 e V2?
VP = [2:2:14]';
VI = [1:2:13];
V1 = VP * VI;
V2 = VI * VP;

% 9) 
% Criar a matriz G de zeros com tamanho 5x7, substituir a primeira linha por 1, terceira coluna por 3 e a quarta linha por 4.
G = zeros(5,7);
G(1,:) = 1;
G(:,3) = 3;
G(4,:) = 4;

% 10) 
% Criar um vetor D com tamanho 1x21 e nele estão os 21 primeiros termos da progressão aritmética onde a1 = -1 e a razão é 0.1.
%% fórmula progressão aritmética: an = a + (n-1)d
%% d: razão, n: número de termos, a: primeiro termo
a1 = -1; % primeiro termo
r = 0.1; % razão da progressão
n = 21; % número de termos desejados
D = a1 + (0:n-1)*r
