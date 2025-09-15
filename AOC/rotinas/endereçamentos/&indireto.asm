# Endereçamento Indireto 
## Guarda um ponteiro para um endereço de memória em um registrador 
## Sintaxe: "ld Rd, index"; Rd <- (index)
## Sintaxe: "st index, Rr"; (index) <- Rr
## index = X, Y ou Z

// Primeiro endereçamento direto para armazenar o valor constante em r27 e r26 (X)
ldi xh, 0x01 ; Byte mais significativo de X (XH)  
ldi xl, 0x00 ; Byte menos significativo de X (XL)

// Agora sim o endereçamento indireto, 
ld r0, X ; R0 recebe o valor que está no endereço de memória apontado por X (0x0100)
inc r0   ; Incrementa o valor de R0
st X, r0 ; Armazena o valor de R0 no endereço de memória apontado por X