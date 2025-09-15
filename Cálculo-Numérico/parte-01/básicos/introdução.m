% Introdução ao Matlab

% Definição de variáveis e vetores
a = 2; % Definindo a variável 'a' com valor 2
v = [1 2 3]; % Definindo um vetor linha 'v'
D = [6; -1; 0; 10]; % Definindo um vetor coluna 'D'
v = v' ; % Transpondo o vetor linha 'v' para um vetor coluna

% Números muito pequenos e grandes
x = 10^-300; % Definindo x como um número muito pequeno
y = 10^50;   % Definindo y como um número muito grande
z = 10^300;  % Definindo z como um número extremamente grande

% Operações com números grandes e pequenos
c1 = (x*z)/y; % Calculando c1 como (x*z)/y
c2 = (x/y)*z; % Calculando c2 como (x/y)*z

c1 = (x+y)+z; % Reatribuindo c1 como (x + y) + z
c2 = (y+z)+x; % Reatribuindo c2 como (y + z) + x

c1 - c2; % Calculando a diferença entre c1 e c2

% Análise de erro de arredondamento com números grandes e pequenos
x = -10^20; % Redefinindo x como um número muito grande negativo
y = 10^20;  % Mantendo y como um número muito grande positivo
z = 1;      % Definindo z como 1

c1 = x + (y + z); % Calculando c1 como x + (y + z)
c2 = (x + y) + z; % Calculando c2 como (x + y) + z

% Operações com vetores
vet = [1 3 8]; % Definindo o vetor 'vet'
SOMA = vet(1) + vet(2) + vet(3); % Somando os elementos do vetor 'vet'
S = sum(vet); % Usando a função sum para somar os elementos do vetor 'vet'

vetor0(3) = 5; % Atribuindo o valor 5 ao terceiro elemento do vetor 'vetor0'
vetor1 = [1:10]; % Criando um vetor 'vetor1' de 1 a 10
vetor2 = [1:0.5:10]; % Criando um vetor 'vetor2' de 1 a 10 com incremento de 0.5
vetor3 = 2*[0:4] + 1; % Criando um vetor 'vetor3' a partir de uma expressão aritmética

vetor3 / 2; % Dividindo cada elemento do vetor 'vetor3' por 2

vetor4 = [1 2 3 4]; % Definindo o vetor 'vetor4'
vetor5 = [5 6 7 8]; % Definindo o vetor 'vetor5'
mult = vetor4 .* vetor5; % Multiplicando elementos correspondentes dos vetores 'vetor4' e 'vetor5'

MAX = max(vetor5); % Encontrando o valor máximo do vetor 'vetor5'
MIN = min(vetor5); % Encontrando o valor mínimo do vetor 'vetor5'

vetor1 = [1.2 3.5 7.7 9.1]; % Redefinindo o vetor 'vetor1'
floor(vetor1); % Arredondando os elementos do vetor 'vetor1' para baixo
ceil(vetor1); % Arredondando os elementos do vetor 'vetor1' para cima
round(vetor1); % Arredondando os elementos do vetor 'vetor1' de forma padrão

vetor2 = [1.25 3.51 7.77 9.49]; % Redefinindo o vetor 'vetor2'
round(vetor2 * 10) / 10; % Arredondando os elementos do vetor 'vetor2' para uma casa decimal
round(vetor2, 1); % Arredondando os elementos do vetor 'vetor2' para uma casa decimal (maneira alternativa)

sqrt(3); % Calculando a raiz quadrada de 3

% Operações com raízes quadradas
x = sqrt(3); % Atribuindo a raiz quadrada de 3 a 'x'
y = sqrt(5); % Atribuindo a raiz quadrada de 5 a 'y'
z = sqrt(8); % Atribuindo a raiz quadrada de 8 a 'z'

c1 = (x + y) + z; % Calculando c1 como (x + y) + z
c2 = (y + z) + x; % Calculando c2 como (y + z) + x

c1 - c2; % Calculando a diferença entre c1 e c2

x = 2; % Redefinindo x como 2
n = [0:15]; % Criando um vetor 'n' de 0 a 15

seq = x .^ n ./ factorial(n); % Calculando uma sequência usando x, n e fatoriais

% Erro de propagação
S = 0; % Inicializando a soma 'S' como 0
MAX = 1000000; % Definindo o número máximo de iterações
valor = 0.999; % Definindo o valor que será somado em cada iteração

for i = 1:MAX
    S = S + valor; % Somando 'valor' a 'S' em cada iteração
    i; % Iterando o loop (a instrução 'i;' aqui é redundante e não faz nada)
end

extrato = valor * MAX; % Calculando o valor teórico esperado
erro = extrato - S; % Calculando o erro de propagação como a diferença entre o valor teórico e a soma calculada
