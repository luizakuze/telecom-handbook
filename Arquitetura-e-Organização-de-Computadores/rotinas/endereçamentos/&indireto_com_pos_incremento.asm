# Endereçamento Indireto com Pós-Incremento

## Sintaxe: "ld Rr, index+";   1. Rr <- (index);
##                         ;   2. index <- index + 1

## Sintaxe: "st index+, Rr";   1. (index) <- Rr; 
##                         ;   2.  index <- index + 1



    // Primeiro endereçamento direto para armazenar o valor constante em r27 e r26 (X)
    ldi xh, 0x01 ; Byte mais significativo de X (XH)
    ldi xl, 0x00 ; Byte menos significativo de X (XL)
Loop:
    inc r0       ; Incrementa o valor de R0
    st X+, r0    ; Guarda R0 aonde aponta X 
    rjmp loop


// Programa guarda a partir da posição 0x0100 os valores de 1, 2, 3, 4 ... nas próximas posições de memória