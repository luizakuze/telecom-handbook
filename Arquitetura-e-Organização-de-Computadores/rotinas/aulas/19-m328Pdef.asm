# Qual a funcção do arquivo m328Pdef.inc ?

## - Define nomes simbólicos para registradores e bits do ATmega328P.
## - Facilita a programação Assembly, permitindo usar nomes em vez de endereços numéricos.
## - Melhora a legibilidade do código, tornando-o mais intuitivo.

# Exemplo de uso:
## Sem o arquivo (ruim!): Números diretos

LDI R16, 0xFF  
OUT 0x1B, R16  ; Escreve em um registrador de controle (mas qual?)

## Com o arquivo: Usando nomes simbólicos

.INCLUDE "m328Pdef.inc"

LDI R16, 0xFF  
OUT DDRB, R16  ; Configura o PORTB como saída
