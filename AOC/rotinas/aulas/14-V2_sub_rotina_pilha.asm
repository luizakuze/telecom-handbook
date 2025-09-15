// O programa abaixo é uma outra versão para a sub-rotina do arquivo "13-V1_sub_rotina_pilha.asm".
// Onde há uma sub-rotina que soma dois valores de 32 bits.

.INCLUDE <m328Pdef.inc>

.DSEG
.ORG 0x0200
varA:  .BYTE 4          ; Primeira variável de 32 bits
varB:  .BYTE 4          ; Segunda variável de 32 bits
result: .BYTE 4         ; Resultado da soma de 32 bits

.CSEG
.ORG 0x0000
start:
    ; Inicializa varA e varB com valores para teste
    ldi ZH, HIGH(varA)
    ldi ZL, LOW(varA)
    ldi r16, 0x01       ; Byte 0 de varA = 0x01
    st Z+, r16
    ldi r16, 0x00       ; Byte 1 de varA = 0x00
    st Z+, r16
    ldi r16, 0x00       ; Byte 2 de varA = 0x00
    st Z+, r16
    ldi r16, 0x00       ; Byte 3 de varA = 0x00
    st Z, r16           ; Finaliza varA

    ldi ZH, HIGH(varB)
    ldi ZL, LOW(varB)
    ldi r16, 0xFF       ; Byte 0 de varB = 0xFF
    st Z+, r16
    ldi r16, 0x00       ; Byte 1 de varB = 0x00
    st Z+, r16
    ldi r16, 0x00       ; Byte 2 de varB = 0x00
    st Z+, r16
    ldi r16, 0x00       ; Byte 3 de varB = 0x00
    st Z, r16           ; Finaliza varB

    ; Configura os ponteiros X, Y e Z
    ldi XH, HIGH(varA)
    ldi XL, LOW(varA)   ; X aponta para varA
    ldi YH, HIGH(varB)
    ldi YL, LOW(varB)   ; Y aponta para varB
    ldi ZH, HIGH(result)
    ldi ZL, LOW(result) ; Z aponta para o resultado

    ; Chama a sub-rotina sum32
    rcall sum32

    ; Loop infinito
end:
    rjmp end

; --------------------------------------------------------------
; Sub-rotina sum32: Soma duas variáveis de 32 bits na SRAM
; Ponteiros:
; - X: Endereço da primeira variável
; - Y: Endereço da segunda variável
; - Z: Endereço do resultado
; --------------------------------------------------------------
sum32:
    ; Salva contexto
    push r16
    push r17
    push r18
    push r19
    push r20
    in r16, SREG
    push r16

    ; Soma os bytes, do menos significativo para o mais significativo
    clr r20         ; Inicializa carry (r20 = 0)

    ldi r18, 4      ; 4 bytes (32 bits), vai fazer 4 vezes o loop

sum_loop:
    ld r16, X+      ; Lê o byte atual de varA
    ld r17, Y+      ; Lê o byte atual de varB
    add r16, r17    ; Soma os dois bytes
    adc r16, r20    ; Adiciona o carry da soma anterior
    st Z+, r16      ; Armazena o byte de resultado em result
    mov r20, r16    ; Atualiza o carry
    dec r18         ; Decrementa o contador
    brne sum_loop   ; Repete até todos os 4 bytes serem somados

    ; Restaura contexto
    pop r16
    out SREG, r16
    pop r20
    pop r19
    pop r18
    pop r17
    pop r16

    ret             ; Retorna para o programa principal