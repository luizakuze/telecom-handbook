.INCLUDE <m328Pdef.inc>  ; Inclui definições do ATmega328P

; ==========================
; Definições de pinos
; ==========================
.equ BOTAO_AUMENTAR = PD2   ; Botão + (aumenta o tamanho do salto, INT0)
.equ BOTAO_DIMINUIR = PD3   ; Botão - (diminui o tamanho do salto, INT1)

; ==========================
; Definição de registradores
; ==========================
.def AUX = R16        ; Registrador auxiliar
.def LED_INDEX = R17  ; Índice do LED atual
.def SALTO = R18      ; Define o tamanho do salto do LED
.def DIRECAO = R19    ; 0 = esquerda para direita, 1 = direita para esquerda

; ==========================
; Configuração inicial
; ==========================
setup:
    ldi AUX, 0xFF
    out DDRB, AUX       ; Configura PB0-PB7 como saída para LEDs
    ldi AUX, 0x00
    out PORTB, AUX      ; Apaga todos os LEDs

    ; Configura botões como entrada com pull-up ativado
    cbi DDRD, BOTAO_AUMENTAR
    cbi DDRD, BOTAO_DIMINUIR
    sbi PORTD, BOTAO_AUMENTAR
    sbi PORTD, BOTAO_DIMINUIR

    ; Configura interrupções externas para os botões
    ldi AUX, 0b00001010   
    sts EICRA, AUX        ; Configura INT0 e INT1 para ativação na borda de descida
    sbi EIMSK, INT0       ; Habilita interrupção externa INT0 (botão +)
    sbi EIMSK, INT1       ; Habilita interrupção externa INT1 (botão -)

    sei                   ; Habilita interrupções globais

    clr LED_INDEX         ; Começa no primeiro LED (PB0)
    clr DIRECAO           ; Define a direção inicial (PB0 → PB7)
    ldi SALTO, 2          ; Começa com um salto de 2 LEDs

    rjmp main             ; Pula para o loop principal

; ==========================
; Loop principal (Movimento do LED)
; ==========================
main:
    clr AUX                     ; Limpa o registrador auxiliar
    ldi R20, 1                  ; Inicia com 0b00000001 no R20 (LED no PB0)
    
    mov R21, LED_INDEX          ; Copia LED_INDEX para R21 (contador de shifts)
loop_shift:  
    cpi R21, 0                  ; Se LED_INDEX for 0, já está na posição correta
    breq led_setado             ; Se sim, pula para próxima etapa
    lsl R20                     ; Desloca bit para a esquerda
    dec R21                     ; Decrementa contador de shifts
    rjmp loop_shift             ; Continua deslocando até alcançar LED_INDEX

led_setado:
    mov AUX, R20                ; Copia valor final para AUX
    out PORTB, AUX              ; Atualiza LEDs no PORTB

    ldi R20, 8
    rcall delay                 ; Chama a rotina de atraso

    tst DIRECAO                  ; Verifica direção
    breq mover_direita            ; Se DIRECAO = 0, move para a direita
    rjmp mover_esquerda           ; Caso contrário, move para a esquerda

mover_direita:
    add LED_INDEX, SALTO        ; Incrementa de acordo com o valor escolhido
    cpi LED_INDEX, 8
    brlt main                    
    ldi LED_INDEX, 6             ; Se chegou ao final, troca a direção
    ldi DIRECAO, 1
    rjmp main

mover_esquerda:
    sub LED_INDEX, SALTO        ; Decrementa de acordo com o valor escolhido
    brpl main                    
    clr LED_INDEX                ; Se chegou ao início, troca a direção
    clr DIRECAO
    rjmp main

; ==========================
; Interrupção para aumentar o salto (botão +)
; ==========================
isr_int0:
    push R16
    in R16, SREG
    push R16

    cpi SALTO, 4                 ; Se SALTO == 4, não aumenta mais
    breq fim_int0
    inc SALTO                    ; Aumenta o tamanho do salto

fim_int0:
    pop R16
    out SREG, R16
    pop R16
    reti

; ==========================
; Interrupção para diminuir o salto (botão -)
; ==========================
isr_int1:
    push R16
    in R16, SREG
    push R16

    cpi SALTO, 2                 ; Se SALTO == 2, não diminui mais
    breq fim_int1
    dec SALTO                    ; Diminui o tamanho do salto

fim_int1:
    pop R16
    out SREG, R16
    pop R16
    reti

; ==========================
; Rotina de atraso
; ==========================
delay:
    push R17
    push R18
    clr R17
    clr R18

loopdelay:
    dec R17
    brne loopdelay
    dec R18
    brne loopdelay
    dec R20
    brne loopdelay

    pop R18
    pop R17
    ret