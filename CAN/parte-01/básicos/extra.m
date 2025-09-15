% Este é um exemplo simples de código Matlab

% definindo uma matriz
A = [1, 2, 3; 
     4, 5, 6; 
     7, 8, 9];

% calculando o determinante
determinante_A = det(A);

% exibindo o determinante da matriz A
disp(['O determinante da matriz A é: ', num2str(determinante_A)]);

% criando um vetor de 1 a 10
vetor = 1:10;

% usando um loop para imprimir todo o vetor
disp('Valores do vetor:');
for i = 1:length(vetor)
    disp(vetor(i));
end

% mostrando um vetor sem o loop
disp(vetor)

% plotando um gráfico
x = linspace(0, 10, 100); % Cria um vetor de 100 pontos entre 0 e 10
y = sin(x); % Calcula o seno de cada ponto em x
plot(x, y); % Plota o gráfico de seno
xlabel('x'); % Rótulo do eixo x
ylabel('sin(x)'); % Rótulo do eixo y
title('Gráfico de sin(x)'); % Título do gráfico
grid on; % Ativa a grade no gráfico

% criando uma função para calcular a média dos valores do vetor
function media = calcularMedia(vetor)
    soma = sum(vetor); % Calcula a soma dos elementos do vetor
    media = soma / length(vetor); % Calcula a média
end

% forma mais simples para calcular a média dos valores do vetor
media = mean(vetor)

% chamando a função calcularMedia com um vetor de exemplo
exemplo_vetor = [2, 4, 6, 8, 10];
media_exemplo = calcularMedia(exemplo_vetor);
disp(['A média do vetor de exemplo é: ', num2str(media_exemplo)]);
