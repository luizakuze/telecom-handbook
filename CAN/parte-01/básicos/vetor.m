% vetor
vet1 = [1 2 3];
vet2 = [4 5 6];

% dot - prouto escalar
dot(vet1, vet2)

% produto vetorial
cross(vet1, vet2)


% vetor começa em 7 - 79 e pula e 7 em 7
vet3=[7:7:79];

% número de linhas e colunas
size(vet3);

% vetor começa em 8 e pula de 2 em 2
vet4=[8:2:28];
size(vet4);

% produto escalar sem utilizar o dot
sum(vet1.*vet2);

% transpondo o vetor (vetor linha em vetor coluna) - mesmo produto escalar
% sem dot
vet3*vet4';