// O programa abaixo mostra um exemplo de sub-rotina que soma dois valores de 32 bits.
// - O ponteiros X e Y são usados para passar como parâmetro a posição das variáveis.
// - O resultado é armazenado na variável apontada pelo ponteiro Z.
// - Byte menos significativo armazenado no menor endereço
// - Contexto salvo corretamente
// - Há um programa principal para testar a sub-rotina

.INCLUDE <m328Pdef.inc>

; ---------------------------------------------
; Declaracao de variaveis na SRAM
; ---------------------------------------------
.DSEG
.ORG 0x0200
A:  .BYTE 4          ; Primeira variavel de 32 bits
B:  .BYTE 4          ; Segunda variavel de 32 bits
C:  .BYTE 4          ; Resultado da soma de 32 bits

; ---------------------------------------------
; Seção de código principal
; ---------------------------------------------
.CSEG
.ORG 0x0000
start:
    ; Programa principal para o teste da sub-rotina
    LDI r16, 0x04
    STS A+0, r16        ; A[0] = 0x04
    LDI r16, 0x03
    STS A+1, r16        ; A[1] = 0x03
    LDI r16, 0x02
    STS A+2, r16        ; A[2] = 0x02
    LDI r16, 0x01
    STS A+3, r16        ; A[3] = 0x01

    LDI r16, 0xFF
    STS B+0, r16        ; B[0] = 0xFF
    LDI r16, 0x03
    STS B+1, r16        ; B[1] = 0x03
    LDI r16, 0x02
    STS B+2, r16        ; B[2] = 0x02
    LDI r16, 0x01
    STS B+3, r16        ; B[3] = 0x01

    ; Configurando os ponteiros para as variaveis
    LDI XL, LOW(A)
    LDI XH, HIGH(A)     ; Ponteiro X aponta para A

    LDI YL, LOW(B)
    LDI YH, HIGH(B)     ; Ponteiro Y aponta para B

    LDI ZL, LOW(C)
    LDI ZH, HIGH(C)     ; Ponteiro Z aponta para C

    ; Chama a sub-rotina soma32bits
    RCALL soma32bits

    RJMP start

; ---------------------------------------------
; Sub-rotina: soma32bits
; Soma dois valores de 32 bits apontados por X e Y
; Coloca o resultado na variavel apontada por Z
; ---------------------------------------------
soma32bits:
    ; Salvar o contexto
    PUSH r0
    PUSH r1
    PUSH r2
    PUSH r3
    PUSH r4
    PUSH r5
    PUSH r6
    PUSH r7
    IN r7, SREG
    PUSH r7

    ; Soma os 4 bytes (32 bits)
    LD r0, X+           ; Lendo byte 0 de A
    LD r1, X+           ; Lendo byte 1 de A
    LD r2, X+           ; Lendo byte 2 de A
    LD r3, X            ; Lendo byte 3 de A

    LD r4, Y+           ; Lendo byte 0 de B
    LD r5, Y+           ; Lendo byte 1 de B
    LD r6, Y+           ; Lendo byte 2 de B
    LD r7, Y            ; Lendo byte 3 de B

    ; Realiza a soma
    ADD r0, r4          ; Soma byte 0 de A e B  // Soma inicial Rd + Rr
    ADC r1, r5          ; Soma byte 1 com carry // No ADC consideramos Rd + Rr + C, onde Rd é o registrador de destino, Rr é o registrador de origem e C é o carry
    ADC r2, r6          ; Soma byte 2 com carry 
    ADC r3, r7          ; Soma byte 3 com carry

    ; Armazena o resultado em C
    ST Z+, r0           ; Armazena byte 0 do resultado
    ST Z+, r1           ; Armazena byte 1 do resultado
    ST Z+, r2           ; Armazena byte 2 do resultado
    ST Z, r3            ; Armazena byte 3 do resultado

    ; Restaurar contexto
    POP r7
    OUT SREG, r7
    POP r7
    POP r6
    POP r5
    POP r4
    POP r3
    POP r2
    POP r1
    POP r0

    RET
