@ BOTÃO INCREMENTAR (PB0):

@ Quando o BOTÃO INCREMENTAR for pressionado, os LEDs devem acender um por um, começando de PB0 até PB7, e quando todos os LEDs estiverem acesos, o contador reinicia e os LEDs são apagados.
@ BOTÃO DECREMENTAR (PB1):

@ Quando o BOTÃO DECREMENTAR for pressionado, os LEDs devem desacender um por um, começando de PB7 até PB0, e quando todos os LEDs estiverem apagados, o contador reinicia e os LEDs são acesos.


@ Interrupções:

@ INT0 (BOTÃO INCREMENTAR) para acender os LEDs.
@ INT1 (BOTÃO DECREMENTAR) para apagar os LEDs.

.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO_INCREMENTAR = PB0  ; Botão incrementar no pino PB0 (INT0)
.equ BOTAO_DECREMENTAR = PB1  ; Botão decrementar no pino PB1 (INT1)
.equ L0 = PD0                  ; LED 0 no pino PD0
.equ L1 = PD1                  ; LED 1 no pino PD1
.equ L2 = PD2                  ; LED 2 no pino PD2
.equ L3 = PD3                  ; LED 3 no pino PD3
.equ L4 = PD4                  ; LED 4 no pino PD4
.equ L5 = PD5                  ; LED 5 no pino PD5
.equ L6 = PD6                  ; LED 6 no pino PD6
.equ L7 = PD7                  ; LED 7 no pino PD7

.def AUX = R16                 ; Registrador auxiliar
.def LED_COUNTER = R17         ; Contador para LEDs acesos

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0xFF               ; Configura PB0-PB7 como saída para LEDs
    out DDRD, AUX
    ldi AUX, 0x00               ; Desliga todos os LEDs inicialmente
    out PORTD, AUX

    cbi DDRB, BOTAO_INCREMENTAR ; Configura o botão incrementar como entrada
    cbi DDRB, BOTAO_DECREMENTAR ; Configura o botão decrementar como entrada
    sbi PORTB, BOTAO_INCREMENTAR; Ativa o pull-up no pino do botão incrementar
    sbi PORTB, BOTAO_DECREMENTAR; Ativa o pull-up no pino do botão decrementar

    ldi AUX, 0x03               ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX
    sbi EIMSK, INT0             ; Habilita interrupção INT0 (BOTÃO INCREMENTAR)
    sbi EIMSK, INT1             ; Habilita interrupção INT1 (BOTÃO DECREMENTAR)

    sei                         ; Habilita as interrupções globais

    rjmp main                   ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main                   ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão INCREMENTAR (INT0)
; -------------------------------------------------
isr_int0:
    push R16                    ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    inc LED_COUNTER             ; Incrementa o contador de LEDs acesos
    cpi LED_COUNTER, 8          ; Verifica se atingiu 8 LEDs
    brge reset_leds             ; Se sim, reinicia

    sbi PORTD, LED_COUNTER      ; Liga o LED correspondente

    pop R16                     ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                        ; Retorna da interrupção

reset_leds:
    ldi LED_COUNTER, 0          ; Reseta o contador para 0
    out PORTD, AUX              ; Apaga todos os LEDs
    rjmp isr_int0               ; Continua o ciclo

; -------------------------------------------------
; Rotina de interrupção para o botão DECREMENTAR (INT1)
; -------------------------------------------------
isr_int1:
    push R16                    ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    dec LED_COUNTER             ; Decrementa o contador de LEDs acesos
    cpi LED_COUNTER, -1         ; Verifica se atingiu -1
    brlt all_on                 ; Se sim, liga todos os LEDs

    cbi PORTD, LED_COUNTER      ; Desliga o LED correspondente

    pop R16                     ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                        ; Retorna da interrupção

all_on:
    ldi LED_COUNTER, 7          ; Reseta o contador para acender todos os LEDs
    out PORTD, AUX              ; Liga todos os LEDs
    rjmp isr_int1               ; Continua o ciclo
