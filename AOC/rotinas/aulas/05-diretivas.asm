// - Programa soma duas variáveis de 8 bits: C = A + B.
// - Considerando que as variáveis A e B estão armazenadas na SRAM a partir do primeiro endereço de memória.
// - Considerando a ordenação little-endian.


.INCLUDE <m328Pdef.inc>

.DSEG // SEGMENTO DA SRAM (dados)
.ORG SRAM_START

A: .BYTE 1  // Primeiro byte da SRAM: 0x0100
B: .BYTE 1  // Segundo byte da SRAM: 0x0101
C: .BYTE 1  // Terceiro byte da SRAM: 0x0102

.CSEG ; SEGMENTO DA FLASH (programa)

start:
    lds r0, A
    lds r1, B
    
    add r0, r1
    
    sts C, r0
    
    rjmp start        
