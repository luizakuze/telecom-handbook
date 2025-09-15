@ Descrição: Simule um sistema com dois botões, BOTAO1 (PD2) e BOTAO2 (PD3), e 8 LEDs (PB0 a PB7). O comportamento será o seguinte:

@ Comportamento dos Botões:

@ BOTAO1 (PD2): Quando pressionado, todos os LEDs (PB0 a PB7) devem acender.
@ BOTAO2 (PD3): Quando pressionado, todos os LEDs devem apagar.
@ Comportamento do Sistema:

@ Quando BOTAO1 é pressionado, todos os LEDs devem acender.
@ Quando BOTAO2 é pressionado, todos os LEDs devem apagar.


.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO1 = PD2   ; Botão 1 no pino PD2 (INT0)
.equ BOTAO2 = PD3   ; Botão 2 no pino PD3 (INT1)
.equ L0 = PB0       ; LED 0 no pino PB0
.equ L1 = PB1       ; LED 1 no pino PB1
.equ L2 = PB2       ; LED 2 no pino PB2
.equ L3 = PB3       ; LED 3 no pino PB3
.equ L4 = PB4       ; LED 4 no pino PB4
.equ L5 = PB5       ; LED 5 no pino PB5
.equ L6 = PB6       ; LED 6 no pino PB6
.equ L7 = PB7       ; LED 7 no pino PB7

.def AUX = R16      ; Registrador auxiliar

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0xFF           ; Configura PB0-PB7 como saída para LEDs
    out DDRB, AUX
    ldi AUX, 0x00           ; Desliga todos os LEDs inicialmente
    out PORTB, AUX

    cbi DDRD, BOTAO1        ; Configura o botão 1 como entrada
    cbi DDRD, BOTAO2        ; Configura o botão 2 como entrada
    sbi PORTD, BOTAO1       ; Ativa o pull-up no pino do botão 1
    sbi PORTD, BOTAO2       ; Ativa o pull-up no pino do botão 2

    ldi AUX, 0x03           ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX
    sbi EIMSK, INT0         ; Habilita interrupção INT0 (BOTAO1)
    sbi EIMSK, INT1         ; Habilita interrupção INT1 (BOTAO2)

    sei                     ; Habilita as interrupções globais

    rjmp main               ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main               ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão 1 (BOTAO1 - INT0)
; -------------------------------------------------
isr_int0:
    push R16                ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    ; Acende todos os LEDs
    sbi PORTB, L0           ; Liga todos os LEDs
    sbi PORTB, L1
    sbi PORTB, L2
    sbi PORTB, L3
    sbi PORTB, L4
    sbi PORTB, L5
    sbi PORTB, L6
    sbi PORTB, L7

    pop R16                 ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                    ; Retorna da interrupção

; -------------------------------------------------
; Rotina de interrupção para o botão 2 (BOTAO2 - INT1)
; -------------------------------------------------
isr_int1:
    push R16                ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    ; Apaga todos os LEDs
    cbi PORTB, L0           ; Desliga todos os LEDs
    cbi PORTB, L1
    cbi PORTB, L2
    cbi PORTB, L3
    cbi PORTB, L4
    cbi PORTB, L5
    cbi PORTB, L6
    cbi PORTB, L7

    pop R16                 ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                    ; Retorna da interrupção
