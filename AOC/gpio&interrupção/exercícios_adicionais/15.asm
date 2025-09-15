@ Simule um sistema com dois botões, BOTÃO ON (PD2) e BOTÃO OFF (PD3), e 8 LEDs (PB0 a PB7). O comportamento será o seguinte:

@ BOTÃO ON (PD2):

@ Quando o botão ON for pressionado, todos os LEDs devem acender e começar a piscar a cada 1 segundo.
@ BOTÃO OFF (PD3):

@ Quando o botão OFF for pressionado, todos os LEDs devem apagar imediatamente, independentemente do estado atual dos LEDs.
@ Comportamento do Sistema:

@ O BOTÃO ON faz os LEDs piscarem a cada 1 segundo.
@ O BOTÃO OFF apaga os LEDs imediatamente.
@ As interrupções externas devem ser usadas para capturar o pressionamento dos botões.

.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO_ON = PD2    ; Botão ON no pino PD2 (INT0)
.equ BOTAO_OFF = PD3   ; Botão OFF no pino PD3 (INT1)
.equ L0 = PB0          ; LED 0 no pino PB0
.equ L1 = PB1          ; LED 1 no pino PB1
.equ L2 = PB2          ; LED 2 no pino PB2
.equ L3 = PB3          ; LED 3 no pino PB3
.equ L4 = PB4          ; LED 4 no pino PB4
.equ L5 = PB5          ; LED 5 no pino PB5
.equ L6 = PB6          ; LED 6 no pino PB6
.equ L7 = PB7          ; LED 7 no pino PB7

.def AUX = R16         ; Registrador auxiliar

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0xFF        ; Configura PB0-PB7 como saída para LEDs
    out DDRB, AUX
    ldi AUX, 0x00        ; Desliga todos os LEDs inicialmente
    out PORTB, AUX

    cbi DDRD, BOTAO_ON   ; Configura o botão ON como entrada
    cbi DDRD, BOTAO_OFF  ; Configura o botão OFF como entrada
    sbi PORTD, BOTAO_ON  ; Ativa o pull-up no pino do botão ON
    sbi PORTD, BOTAO_OFF ; Ativa o pull-up no pino do botão OFF

    ldi AUX, 0x03        ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX
    sbi EIMSK, INT0      ; Habilita interrupção INT0 (BOTÃO ON)
    sbi EIMSK, INT1      ; Habilita interrupção INT1 (BOTÃO OFF)

    sei                  ; Habilita as interrupções globais

    rjmp main            ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main            ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão ON (INT0)
; -------------------------------------------------
isr_int0:
    push R16             ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    sbi PORTB, L0        ; Liga todos os LEDs
    sbi PORTB, L1
    sbi PORTB, L2
    sbi PORTB, L3
    sbi PORTB, L4
    sbi PORTB, L5
    sbi PORTB, L6
    sbi PORTB, L7

    ldi AUX, 100         ; Aproximadamente 1 segundo de delay
    rcall delay

    cbi PORTB, L0        ; Desliga todos os LEDs
    cbi PORTB, L1
    cbi PORTB, L2
    cbi PORTB, L3
    cbi PORTB, L4
    cbi PORTB, L5
    cbi PORTB, L6
    cbi PORTB, L7

    pop R16              ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                 ; Retorna da interrupção

; -------------------------------------------------
; Rotina de interrupção para o botão OFF (INT1)
;
