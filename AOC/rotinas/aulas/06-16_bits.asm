// - Programa soma duas variáveis de 16 bits: C = A + B.
// - Considerando que as variáveis A e B estão armazenadas na SRAM a partir do primeiro endereço de memória.
// - Considerando a ordenação little-endian.
// - NOTA: Mesmo código do exemplo anterior no arquivo "05-diretivas.asm", mas com variáveis de 16 bits.

.INCLUDE <m328Pdef.inc>

.DSEG // SEGMENTO DA SRAM (dados)
.ORG SRAM_START

A: .BYTE 2  // 2 bytes para A: endereço 0x0100 e 0x0101
B: .BYTE 2  // 2 bytes para B: endereço 0x0102 e 0x0103
C: .BYTE 2  // 2 bytes para C: endereço 0x0104 e 0x0105

.CSEG // SEGMENTO DA FLASH (programa)
start:
    // MSB e LSB de A
    lds r0, A // lsb
    lds r1, A+1 // msb
    
    // MSB e LSB de B
    lds r2, B // lsb
    lds r3, B+1 // msb
    
    // Soma LSBs
    add r0, r2
    // Soma MSBs
    adc r1, r3
    
    // Guarda soma anterior em C
    sts C, r0
    sts C+1, r1
 
    rjmp start