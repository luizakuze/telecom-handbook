@ Descrição:
@ Simule um sistema com 2 botões, BOTÃO AJUSTE (PD2) e BOTÃO RESET (PD3), e 8 LEDs (PB0 a PB7).

@ Comportamento:

@ Botão AJUSTE (PD2):
@ Quando o botão AJUSTE for pressionado, os LEDs devem acender um a um, do L0 (PB0) até L7 (PB7), com cada LED acendendo a cada 500ms, independentemente do estado atual dos LEDs.
@ Botão RESET (PD3):
@ Quando o botão RESET for pressionado, todos os LEDs devem ser apagados imediatamente.
@ Interrupções:

@ INT0 (BOTÃO AJUSTE) para acender os LEDs um a um.
@ INT1 (BOTÃO RESET) para apagar todos os LEDs.

.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO_AJUSTE = PD2   ; Botão ajuste no pino PD2 (INT0)
.equ BOTAO_RESET = PD3    ; Botão reset no pino PD3 (INT1)
.equ L0 = PB0             ; LED 0 no pino PB0
.equ L1 = PB1             ; LED 1 no pino PB1
.equ L2 = PB2             ; LED 2 no pino PB2
.equ L3 = PB3             ; LED 3 no pino PB3
.equ L4 = PB4             ; LED 4 no pino PB4
.equ L5 = PB5             ; LED 5 no pino PB5
.equ L6 = PB6             ; LED 6 no pino PB6
.equ L7 = PB7             ; LED 7 no pino PB7

.def AUX = R16            ; Registrador auxiliar
.def LED_COUNTER = R17    ; Contador para LEDs

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0xFF           ; Configura PB0-PB7 como saída para LEDs
    out DDRB, AUX
    ldi AUX, 0x00           ; Desliga todos os LEDs inicialmente
    out PORTB, AUX

    cbi DDRD, BOTAO_AJUSTE  ; Configura o botão ajuste como entrada
    cbi DDRD, BOTAO_RESET   ; Configura o botão reset como entrada
    sbi PORTD, BOTAO_AJUSTE ; Ativa o pull-up no pino do botão ajuste
    sbi PORTD, BOTAO_RESET  ; Ativa o pull-up no pino do botão reset

    ldi AUX, 0x03           ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX
    sbi EIMSK, INT0         ; Habilita interrupção INT0 (BOTÃO AJUSTE)
    sbi EIMSK, INT1         ; Habilita interrupção INT1 (BOTÃO RESET)

    sei                     ; Habilita as interrupções globais

    rjmp main               ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main               ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão AJUSTE (INT0)
; -------------------------------------------------
isr_int0:
    push R16                ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    ldi LED_COUNTER, 0      ; Reseta o contador de LEDs

acende_leds:
    cpi LED_COUNTER, 8      ; Verifica se todos os LEDs foram acesos
    brge fim_leds

    sbi PORTB, LED_COUNTER  ; Acende o LED correspondente
    ldi R19, 40             ; 500ms de atraso
    rcall delay
    cbi PORTB, LED_COUNTER  ; Desliga o LED
    inc LED_COUNTER         ; Incrementa o contador
    rjmp acende_leds

fim_leds:
    pop R16                 ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                    ; Retorna da interrupção

; -------------------------------------------------
; Rotina de interrupção para o botão RESET (INT1)
; -------------------------------------------------
isr_int1:
    push R16                ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    ldi AUX, 0x00           ; Apaga todos os LEDs
    out PORTB, AUX

    pop R16                 ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                    ; Retorna da interrupção

; -------------------------------------------------
; Sub-rotina de atraso programável
; -------------------------------------------------
delay:
    push r17 
    push r18 

    in r17, SREG 
    push r17 

    clr r17 
    clr r18 

loopdelay:
    dec r17 
    brne loopdelay 
    dec r18 
    brne loopdelay 
    dec R19 
    brne loopdelay 
    
    pop r17
    out SREG, r17

    pop r18 
    pop r17
    
    ret
