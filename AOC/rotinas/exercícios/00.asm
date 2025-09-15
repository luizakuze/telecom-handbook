// O programa consiste em 3 partes:
// Parte 1: Inicializar 3 vetores de 12 bytes (A1, A2 e A3) e 1 vetor de 4 bytes (A4)
//          A2 deve conter de 1 a 12 e A3 deve conter de 12 a 1
// Parte 2: Somar os vetores A2 e A3 e armazenar em A1
// Parte 3: Somar posições específicar de A2 e A3 e armazena em A4      

.DSEG
.ORG SRAM_START


;PARTE 1 -----------------------------------------------------------------------

; 12 Bytes para A1, A2 e A3
; 4 Bytes para A4
A1: .BYTE 12
A2: .BYTE 12
A3: .BYTE 12
A4: .BYTE 4
.CSEG


; Inicia os ponteiros Y apontando para A2
A2setup:
        
    LDI YH, HIGH(A2)
    LDI YL, LOW(A2)
    LDI R16, 1

; Carrega um incrementador de 1 a 12 dentro das posições de memória
A2loop:

    ST Y+, R16
    INC R16
    CPI R16, 13
    BREQ A3setup
    rjmp A2loop

; Inicia os ponteiros Y apontando para A3 
A3setup: 

    LDI YH, HIGH(A3)
    LDI YL, LOW(A3)
    LDI R16, 1

; Carrega um decrementador de 12 a 1 dentro das posições de memória
A3loop: 

    ST Y+, R16
    INC R16
    CPI R16, 13
    BREQ A1setup
    rjmp A3loop

; PARTE 2 -----------------------------------------------------------------------

; Inicia os ponteiros X apontando para A2
; Inicia os ponteiros Y apontando para A3
; Inicia os ponteiros Z apontando para A1

A1setup: 

    ldi XH, HIGH(A1) 
    ldi XL, LOW(A1)

    ldi ZH, HIGH(A2)
    ldi ZL, LOW(A2)

    ldi R17, 1
        

    ; Carrega o valor de X e Y em dois registradores auxiliares para a soma
    ; Faz a soma dos registradores 
    ; Guarda o valor somado dentro da posição apontada pelo ponteiro Z (No caso, as posições de A1)
    ; Compara o valor 
    IncrementLoop:
        

    ld r0, -Y
    ld r1, Z+

    add r0, r1

    ST X+, r0
    INC R17

    CPI R17, 13
    BREQ ThirdPart
    rjmp IncrementLoop


; PARTE 3 -----------------------------------------------------------------------

; Inicia os ponteiros X apontando para A4
; Inicia os ponteiros Y apontando para A3
; Inicia os ponteiros Z apontando para A2

ThirdPart: 

    ldi YH, HIGH(A3) 
    ldi YL, LOW(A3)

    ldi ZH, HIGH(A2)
    ldi ZL, LOW(A2)

    ldi XH, HIGH(A4) 
    ldi XL, LOW(A4)

    ; Some A2(3) e A3(4) e guarde em A4(0)
    ldd r0, Z+2
    ldd r1, Y+3

    add r0, r1

    st X+, r0

    ; Some A2(5) e A3(7) e guarde em A4(1)
    ldd r0, Z+4
    ldd r1, Y+6

    add r0, r1

    st X+, r0

    ; Some A2(8) e A3(6) e guarde em A4(2)
    ldd r0, Z+7
    ldd r1, Y+5

    add r0, r1

    st X+, r0

    ; Some A2(10) e A3(12) e guarde em A4(3)
    ldd r0, Z+9
    ldd r1, Y+11

    add r0, r1

    st X, r0

    rjmp A2setup
