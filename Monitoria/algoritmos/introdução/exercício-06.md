# Exercício 06 - Introdução
  
## Introdução  
<div align="center">

_"Escreva um fluxograma e um pseudocódigo para um algoritmo que lê cinco inteiros,
cada um sendo 0 ou 1, que compõem os bits da representação binária de um número,
e escreve esse número (em decimal).
<br> <br> Assuma que os bits são informados do mais significativo para o menos significativo. <br> <br>
Em seguida, execute um teste de mesa com a entrada 1, 0, 1, 1, 0; a saída deve ser 22"_

</div>

## Resolução

<div align="center">

![](../../imagens/ex-06.png)

</div>

### Teste de mesa

<div align="center">


|Inst|bit1|bit2|bit3|bit4|bit5|resultado|
----|----|----|----|----|----|----|
|0|?|?|?|?|?|?|
|1|?|?|?|?|?|?|
|2|?|?|?|?|?|?| inicio
|3|1|?|?|?|?|?|
|4|1|0|?|?|?|?|
|5|1|0|1|?|?|?|
|6|1|0|1|1|?|?|
|7|1|0|1|1|0|?|
|8|16|0|1|1|0|?| bit1 *
|9|16|0|1|1|0|?| bit2 *
|10|16|0|4|1|0|?| bit3 *
|11|16|0|4|2|0|?| bit4 *
|12|16|0|4|2|0|22| resultado
|13|16|0|4|2|0|22|
|14|16|0|4|2|0|22|

</div>