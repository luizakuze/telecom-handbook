# Endereçamento Indireto com Pré-Decremento

## Sintaxe: "ld Rr, -index";   1. index <- index - 1
##                         ;   2. Rr <- (index);

## Sintaxe: "st -index, Rr";   1. index <- index - 1
##                         ;   2. (index) <- Rr; 


; Inicializa o registrador X com o endereço 0x010B
ldi r27, 0x01  ; Byte mais significativo de X (XH)
ldi r26, 0x0B  ; Byte menos significativo de X (XL)

Loop:
    inc r0      ; Incrementa r0
    st -X, r0   ; Armazena conteúdo do r0 na posição anterior de X atual
    rjmp Loop    