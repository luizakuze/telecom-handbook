@ BOTÃO LIGAR (PB0):

@ Quando o BOTÃO LIGAR for pressionado, os 8 LEDs (PD0 a PD7) devem acender imediatamente.
@ BOTÃO DESLIGAR (PB1):

@ Quando o BOTÃO DESLIGAR for pressionado, todos os LEDs devem apagar imediatamente.
@ Comportamento do Sistema:

@ BOTÃO LIGAR acende todos os LEDs (PB0 a PB7).
@ BOTÃO DESLIGAR apaga todos os LEDs (PB0 a PB7).
@ Interrupções:

@ INT0 (BOTÃO LIGAR) para acender todos os LEDs.
@ INT1 (BOTÃO DESLIGAR) para apagar todos os LEDs.


.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO_LIGAR = PB0     ; Botão ligar no pino PB0 (INT0)
.equ BOTAO_DESLIGAR = PB1  ; Botão desligar no pino PB1 (INT1)
.equ L0 = PD0              ; LED 0 no pino PD0
.equ L1 = PD1              ; LED 1 no pino PD1
.equ L2 = PD2              ; LED 2 no pino PD2
.equ L3 = PD3              ; LED 3 no pino PD3
.equ L4 = PD4              ; LED 4 no pino PD4
.equ L5 = PD5              ; LED 5 no pino PD5
.equ L6 = PD6              ; LED 6 no pino PD6
.equ L7 = PD7              ; LED 7 no pino PD7

.def AUX = R16             ; Registrador auxiliar

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0xFF           ; Configura PD0-PD7 como saída para LEDs
    out DDRD, AUX
    ldi AUX, 0x00           ; Desliga todos os LEDs inicialmente
    out PORTD, AUX

    cbi DDRB, BOTAO_LIGAR   ; Configura o botão ligar como entrada
    cbi DDRB, BOTAO_DESLIGAR; Configura o botão desligar como entrada
    sbi PORTB, BOTAO_LIGAR  ; Ativa o pull-up no pino do botão ligar
    sbi PORTB, BOTAO_DESLIGAR; Ativa o pull-up no pino do botão desligar

    ldi AUX, 0x03           ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX
    sbi EIMSK, INT0         ; Habilita interrupção INT0 (BOTÃO LIGAR)
    sbi EIMSK, INT1         ; Habilita interrupção INT1 (BOTÃO DESLIGAR)

    sei                     ; Habilita as interrupções globais

    rjmp main               ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main               ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão LIGAR (INT0)
; -------------------------------------------------
isr_int0:
    push R16                ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    sbi PORTD, L0           ; Liga todos os LEDs
    sbi PORTD, L1
    sbi PORTD, L2
    sbi PORTD, L3
    sbi PORTD, L4
    sbi PORTD, L5
    sbi PORTD, L6
    sbi PORTD, L7

    pop R16                 ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                    ; Retorna da interrupção

; -------------------------------------------------
; Rotina de interrupção para o botão DESLIGAR (INT1)
; -------------------------------------------------
isr_int1:
    push R16                ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    cbi PORTD, L0           ; Apaga todos os LEDs
    cbi PORTD, L1
    cbi PORTD, L2
    cbi PORTD, L3
    cbi PORTD, L4
    cbi PORTD, L5
    cbi PORTD, L6
    cbi PORTD, L7

    pop R16                 ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                    ; Retorna da interrupção
