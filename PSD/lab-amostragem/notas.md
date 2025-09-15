Passos para análise:
Verificação do Aliasing: Aliasing ocorre quando a taxa de amostragem é inferior à taxa de Nyquist, ou seja, quando a frequência do sinal original é maior que a metade da frequência de amostragem. Para um sinal de frequência 
𝑓
f, a taxa de Nyquist é 
2
𝑓
2f, então a amostragem deve ser pelo menos 
2
𝑓
2f para evitar aliasing.

Cálculo da Frequência do Sinal Reconstruído: Após a reconstrução do sinal usando interpolação sinc, calcularemos a frequência do sinal reconstruído. Se ocorrer aliasing, a frequência reconstruída será alterada e corresponderá a uma frequência aliased.

Detalhamento de cada caso:
Caso 1: Cosseno de 30Hz, Amostragem de 50Hz
matlab
Copiar
% Cosseno: 30Hz, Amostragem: 50Hz
[m,t] = makecos(30); % Cria um sinal cosseno de 30Hz
[it3,ts3] = makeimp(50); % Cria um trem de impulsos com uma taxa de amostragem de 50Hz
ms3 = sampleit1(t,m,ts3); % Amostra o sinal cosseno com a taxa de amostragem de 50Hz
mr3 = interpsinc(ms3,ts3,t); % Reconstrói o sinal amostrado usando interpolação sinc
Verificação do Aliasing: Neste caso, a frequência do sinal é 30Hz, e a taxa de amostragem é 50Hz, que é maior que o dobro da frequência do sinal (
2
×
30
=
60
2×30=60 Hz). Isso significa que não ocorrerá aliasing e a frequência do sinal reconstruído deve ser a mesma.

Frequência reconstruída: A frequência do sinal reconstruído será 30Hz, pois a amostragem está acima da taxa de Nyquist.

Caso 2: Cosseno de 40Hz, Amostragem de 15Hz
matlab
Copiar
% Cosseno: 40Hz, Amostragem: 15Hz
[m,t] = makecos(40); % Cria um sinal cosseno de 40Hz
[it4,ts4] = makeimp(15); % Cria um trem de impulsos com uma taxa de amostragem de 15Hz
ms4 = sampleit1(t,m,ts4); % Amostra o sinal cosseno com a taxa de amostragem de 15Hz
mr4 = interpsinc(ms4,ts4,t); % Reconstrói o sinal amostrado usando interpolação sinc
Verificação do Aliasing: Neste caso, a frequência do sinal é 40Hz e a taxa de amostragem é 15Hz. A taxa de amostragem é inferior ao dobro da frequência do sinal (
2
×
40
=
80
2×40=80 Hz), o que resulta em aliasing.

O aliasing ocorre quando a frequência do sinal excede a metade da taxa de amostragem. No caso da amostragem de 15Hz, o sinal de 40Hz será refletido de volta no espectro, resultando em uma frequência aliased. A nova frequência aliased pode ser calculada como:

𝑓
alias
=
∣
𝑓
original
−
𝑓
sampling
∣
f 
alias
​
 =∣f 
original
​
 −f 
sampling
​
 ∣
Onde 
𝑓
sampling
f 
sampling
​
  é a frequência de amostragem e 
𝑓
original
f 
original
​
  é a frequência do sinal. Então:

𝑓
alias
=
∣
40
−
15
∣
=
25
Hz
f 
alias
​
 =∣40−15∣=25Hz
Portanto, a frequência reconstruída será 25Hz, resultante do aliasing.

Caso 3: Cosseno de 10Hz, Amostragem de 50Hz
matlab
Copiar
% Cosseno: 10Hz, Amostragem: 50Hz
[m,t] = makecos(10); % Cria um sinal cosseno de 10Hz
[it5,ts5] = makeimp(50); % Cria um trem de impulsos com uma taxa de amostragem de 50Hz
ms5 = sampleit1(t,m,ts5); % Amostra o sinal cosseno com a taxa de amostragem de 50Hz
mr5 = interpsinc(ms5,ts5,t); % Reconstrói o sinal amostrado usando interpolação sinc
Verificação do Aliasing: Neste caso, a frequência do sinal é 10Hz, e a taxa de amostragem é 50Hz. Como 
2
×
10
=
20
2×10=20 Hz, a amostragem está bem acima da taxa de Nyquist (
20
20 Hz). Portanto, não ocorre aliasing.

Frequência reconstruída: A frequência do sinal reconstruído será a mesma do sinal original, ou seja, 10Hz.

Caso 4: Cosseno de 20Hz, Amostragem de 40Hz
matlab
Copiar
% Cosseno: 20Hz, Amostragem: 40Hz
[m,t] = makecos(20); % Cria um sinal cosseno de 20Hz
[it6,ts6] = makeimp(40); % Cria um trem de impulsos com uma taxa de amostragem de 40Hz
ms6 = sampleit1(t,m,ts6); % Amostra o sinal cosseno com a taxa de amostragem de 40Hz
mr6 = interpsinc(ms6,ts6,t); % Reconstrói o sinal amostrado usando interpolação sinc
Verificação do Aliasing: A frequência do sinal é 20Hz, e a taxa de amostragem é 40Hz. Como 
2
×
20
=
40
2×20=40 Hz, a amostragem está exatamente na taxa de Nyquist. Isso significa que não ocorrerá aliasing, mas o sinal será amostrado no limite de Nyquist.

Frequência reconstruída: A frequência do sinal reconstruído será a mesma do sinal original, ou seja, 20Hz.

Resumo das Frequências Reconstruídas:
Caso 1 (30Hz amostrado a 50Hz): Frequência reconstruída = 30Hz (sem aliasing)

Caso 2 (40Hz amostrado a 15Hz): Frequência reconstruída = 25Hz (aliasing)

Caso 3 (10Hz amostrado a 50Hz): Frequência reconstruída = 10Hz (sem aliasing)

Caso 4 (20Hz amostrado a 40Hz): Frequência reconstruída = 20Hz (sem aliasing)





O que é aliasing?
O aliasing ocorre quando a frequência de amostragem de um sinal não é alta o suficiente para capturar a frequência do sinal original corretamente. O teorema de Nyquist nos diz que a taxa de amostragem deve ser, no mínimo, o dobro da frequência do sinal para evitar aliasing.

Ou seja, para um sinal com frequência 
𝑓
original
f 
original
​
 , a taxa de amostragem mínima 
𝑓
sampling
f 
sampling
​
  deve ser:

𝑓
sampling
≥
2
⋅
𝑓
original
f 
sampling
​
 ≥2⋅f 
original
​
 
Se a taxa de amostragem for menor que o dobro da frequência do sinal, a amostragem não será capaz de capturar o sinal corretamente, e o espectro do sinal será refletido, causando aliasing.

Como calcular a frequência aliasada?
Quando a taxa de amostragem é insuficiente para capturar a frequência original corretamente, ocorre a distorção do espectro. A nova frequência, chamada frequência aliasada, pode ser calculada pela reflexão da frequência original em relação à taxa de amostragem.

A fórmula para calcular a frequência aliasada é:

𝑓
alias
=
∣
𝑓
original
−
𝑛
⋅
𝑓
sampling
∣
f 
alias
​
 =∣f 
original
​
 −n⋅f 
sampling
​
 ∣
Onde:

𝑓
original
f 
original
​
  é a frequência original do sinal.

𝑓
sampling
f 
sampling
​
  é a frequência de amostragem.

𝑛
n é o menor número inteiro tal que 
𝑛
⋅
𝑓
sampling
≥
𝑓
original
n⋅f 
sampling
​
 ≥f 
original
​
 . O número 
𝑛
n determina em qual múltiplo da frequência de amostragem ocorre a reflexão (ou aliasing).

O objetivo dessa fórmula é refletir a frequência para dentro da faixa de frequências que pode ser representada pela amostragem, ou seja, dentro do intervalo de 
0
0 a 
𝑓
sampling
/
2
f 
sampling
​
 /2 (metade da taxa de amostragem).

Exemplo prático para o caso do sinal de 40Hz amostrado a 15Hz
No seu exemplo, temos:

A frequência do sinal original: 
𝑓
original
=
40
f 
original
​
 =40 Hz.

A taxa de amostragem: 
𝑓
sampling
=
15
f 
sampling
​
 =15 Hz.

O teorema de Nyquist nos diz que a frequência máxima que pode ser representada sem aliasing é 
𝑓
sampling
2
=
15
2
=
7
,
5
2
f 
sampling
​
 
​
 = 
2
15
​
 =7,5 Hz. Como a frequência do sinal (40Hz) é muito maior que essa frequência máxima (7,5Hz), ocorre aliasing.

Passo 1: Calculando a frequência aliasada
Vamos calcular a frequência aliasada usando a fórmula 
𝑓
alias
=
∣
𝑓
original
−
𝑛
⋅
𝑓
sampling
∣
f 
alias
​
 =∣f 
original
​
 −n⋅f 
sampling
​
 ∣.

Primeiro, encontramos o menor valor de 
𝑛
n tal que 
𝑛
⋅
𝑓
sampling
≥
𝑓
original
n⋅f 
sampling
​
 ≥f 
original
​
 .

𝑛
⋅
𝑓
sampling
≥
40
 Hz
n⋅f 
sampling
​
 ≥40 Hz
𝑛
⋅
15
≥
40
⇒
𝑛
≥
40
15
≈
2.67
n⋅15≥40⇒n≥ 
15
40
​
 ≈2.67
O menor valor inteiro de 
𝑛
n é 
𝑛
=
3
n=3.

Agora, aplicamos na fórmula:

𝑓
alias
=
∣
40
−
3
⋅
15
∣
f 
alias
​
 =∣40−3⋅15∣
𝑓
alias
=
∣
40
−
45
∣
=
5
 Hz
f 
alias
​
 =∣40−45∣=5 Hz
Portanto, a frequência aliasada do sinal original de 40Hz amostrado a 15Hz é 5Hz.

Resumo do que acontece
Quando a taxa de amostragem não é suficiente para capturar a frequência original do sinal, ocorre aliasing.

A frequência original 
𝑓
original
f 
original
​
  se reflete dentro da faixa representável pela amostragem.

A nova frequência que será observada no espectro amostrado é dada pela fórmula de aliasing: 
𝑓
alias
=
∣
𝑓
original
−
𝑛
⋅
𝑓
sampling
∣
f 
alias
​
 =∣f 
original
​
 −n⋅f 
sampling
​
 ∣.

No exemplo de 40Hz amostrado a 15Hz, a frequência aliasada resultante foi 5Hz.

Esse fenômeno de aliasing é muito importante em sistemas de aquisição de sinais, e para evitar esse problema, é essencial garantir que a taxa de amostragem seja alta o suficiente para capturar todas as frequências de interesse.