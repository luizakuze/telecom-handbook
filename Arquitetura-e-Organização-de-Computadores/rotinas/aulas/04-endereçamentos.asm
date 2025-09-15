// Endereçamento Imediato: Rd <- K
// - Não precisa da SRAM 
ldi R16, 0x14 




// Endereçamento Direto: Rd <- DS(K)
// Usa a SRAM
// Load + Store
lds r0, 0x0100
sts 0x0101, r0
  



// Endereçamento indireto
// Ponteiros: Bom para um loop
// possibilidade de alterar o ponteiro é a vantagem
// ponteiros: x y ou z
loop: 
    ldi xh, 0x01  
    ldi xl, 0x00 
    ld r0, x
    inc r0
    st x, r0
    rjmp loop
    
// Mesma coisa que:
loop:
    ldi r27, 0x01  
    ldi r26, 0x00 
    ld r0, X  
    inc r0
    st X, r0
    rjmp loop




// Endereçamento indireto com pós-decremento
// Ótimo para percorrer de frente para o final
// Sintaxe X+, Y+ ou Z+
    ldi xh, 0x01 // r27
    ldi xl, 0x00 // r26
loop: 
    inc r0
    st x+, r0
    rjmp loop




// Endereçamento indireto com pré-decremento
// Ótimo para percorrer de trás para frente
// Sintaxe -X, -Y ou -Z
    ldi xh, 0x01 // r27
    ldi xl, 0x00 // r26
loop: 
    inc r0
    st -x, r0
    rjmp loop




// Endereçamento indireto com deslocamento
// Sintaxe X+q, Y+q ou Z+q
    ldi yh, 0x01 // r29
    ldi yl, 0x00 // r28
loop: 
    inc r0
    std y+2, r0
    inc r0
    std y+3, r0
    rjmp loop

