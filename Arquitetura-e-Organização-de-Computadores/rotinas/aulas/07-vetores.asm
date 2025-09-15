// O código assembly abaixo executa as seguintes operações:

// - Declara três vetores com 12 posições de 8 bits (A1, A2 e A3) e um vetor de 3 posições de 8 bits (A4).
// -----Foi utilizado: .DSEG e ".BYTE 10"

// - Inicializa os vetores A2 e A3 com os valores de 1 até 12.
// -----Foi utilizado: Endereçamento indireto com pós incremento.
// -----Foi utilizado: Um loop com 12 iterações.

// - Soma a primeira posição do A2 com a última do A3 e armazene na primeira do A1. Fazendo isso sucessivamente até que todas as posições sejam operadas.
// -----Foi utilizado: Endereçamento indireto com pós incremento para acessar o A1 e o A2 e endereçamento indireto com pré decremento para acessar o A3.
// -----Foi utilizado: Um loop com 12 iterações.

// - Soma A2(2) e A3(5), A2(3) e A3(4), A2(8) e A3(9) e salve consecutivamente no A4.
// -----Foi utilizado: Endereçamento indireto com deslocamento para acessar o A2 e o A3 e endereçamento indireto com pós incremento para acessar o A4.
// -----Não foi utilizado um loop, pois o código é pequeno e não há necessidade!

.INCLUDE <m328Pdef.inc>

.DSEG
//.ORG 0x0200
A1:  .BYTE 12   ; Vetor A1 com 12 posições
A2:  .BYTE 12   ; Vetor A2 com 12 posições
A3:  .BYTE 12   ; Vetor A3 com 12 posições
A4:  .BYTE 3    ; Vetor A4 com 3 posições

.CSEG
//.ORG 0x0000

start:
    ; -------------------------------------
    ; Inicializar A2 e A3 com valores de 1 a 12
    ; -------------------------------------
    ldi YH, HIGH(A2)       ; Ponteiro Y -> início de A2
    ldi YL, LOW(A2)
    ldi ZH, HIGH(A3)       ; Ponteiro Z -> início de A3
    ldi ZL, LOW(A3)

    ldi r16, 1             ; Inicializa r16 com o valor 1

INIT_A2_A3:
    st Y+, r16             ; Armazena r16 na posição atual de A2 e incrementa Y
    st Z+, r16             ; Armazena r16 na posição atual de A3 e incrementa Z
    inc r16                ; Incrementa r16 (próximo valor)
    cpi r16, 13            ; Compara r16 com 13
    brne INIT_A2_A3        ; Repete o loop enquanto r16 != 13
    
    ; ----------------------------------------------------  
    ; Somar a primeira posição de A2 com a última do A3 e
    ; armazenar em todas as posições de A1
    ; ---------------------------------------------------- 
    ldi YH, HIGH(A2)       ; Ponteiro Y -> início de A2
    ldi YL, LOW(A2)
    ldi ZH, HIGH(A3+12)    ; Ponteiro Z -> final de A3 (última posição + 1)
    ldi ZL, LOW(A3+12)
    ldi XH, HIGH(A1)       ; Ponteiro X -> início de A1
    ldi XL, LOW(A1)

    ldi r16, 1             ; Inicializa r16 com 1 (contador do loop)

SUM_SEQ:
    ld r17, Y+             ; Carrega próximo valor de A2
    ld r18, -Z             ; Carrega valor de A3 (decrementando Z)
    add r17, r18           ; Soma r17 (A2) e r18 (A3)
    st X+, r17             ; Armazena o resultado em A1 e incrementa X
    inc r16                ; Incrementa o contador
    cpi r16, 13            ; Compara r16 com 13
    brne SUM_SEQ           ; Repete o loop enquanto r16 != 13
    
    ; -------------------------------------
    ; Somar valores específicos de A2 e A3 e armazenar em A4:
    ; A2(2) + A2(5) em A4(0)
    ; A2(3) + A3(4) em A4(1)
    ; A2(8) + A3(9) em A4(2)
    ; -------------------------------------
    ldi YH, HIGH(A2)       ; Ponteiro Y -> início de A2
    ldi YL, LOW(A2)
    ldi ZH, HIGH(A3)       ; Ponteiro Z -> início de A3
    ldi ZL, LOW(A3)
    ldi XH, HIGH(A4)       ; Ponteiro X -> início de A4
    ldi XL, LOW(A4)

    ; Somar A2[2] e A3[5] -> A4[0]
    ldd r17, Y+2           ; Carrega A2[2] (deslocamento +2)
    ldd r18, Z+5           ; Carrega A3[5] (deslocamento +5)
    add r17, r18           ; Soma os valores
    st X+, r17             ; Armazena o resultado em A4[0]

    ; Somar A2[3] e A3[4] -> A4[1]
    ldd r17, Y+3           ; Carrega A2[3] (deslocamento +3)
    ldd r18, Z+4           ; Carrega A3[4] (deslocamento +4)
    add r17, r18           ; Soma os valores
    st X+, r17             ; Armazena o resultado em A4[1]

    ; Somar A2[8] e A3[9] -> A4[2]
    ldd r17, Y+8           ; Carrega A2[8] (deslocamento +8)
    ldd r18, Z+9           ; Carrega A3[9] (deslocamento +9)
    add r17, r18           ; Soma os valores
    st X+, r17             ; Armazena o resultado em A4[2]
 
    rjmp start // loop infinito