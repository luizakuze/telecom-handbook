@ Simule um sistema com 2 botões, BOTÃO AUMENTAR (PD2) e BOTÃO DIMINUIR (PD3), e 8 LEDs (PB0 a PB7). O comportamento será o seguinte:

@ BOTÃO AUMENTAR (PD2):

@ Quando o BOTÃO AUMENTAR for pressionado, o número de LEDs acesos aumenta.
@ Se todos os LEDs já estiverem acesos (PB0 a PB7), o sistema volta para o estado inicial, onde nenhum LED está aceso.
@ BOTÃO DIMINUIR (PD3):

@ Quando o BOTÃO DIMINUIR for pressionado, o número de LEDs acesos diminui.
@ Se nenhum LED estiver aceso, o sistema volta para o estado onde todos os LEDs estão acesos.
@ Comportamento do Sistema:

@ O BOTÃO AUMENTAR vai ligando os LEDs de forma sequencial, começando de PB0 até PB7.
@ O BOTÃO DIMINUIR vai desligando os LEDs de forma sequencial, começando de PB7 até PB0.
@ Interrupções:

@ INT0 (BOTÃO AUMENTAR) para aumentar o número de LEDs acesos.
@ INT1 (BOTÃO DIMINUIR) para diminuir o número de LEDs acesos.

.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO_AUMENTAR = PD2   ; Botão aumentar no pino PD2 (INT0)
.equ BOTAO_DIMINUIR = PD3   ; Botão diminuir no pino PD3 (INT1)
.equ L0 = PB0               ; LED 0 no pino PB0
.equ L1 = PB1               ; LED 1 no pino PB1
.equ L2 = PB2               ; LED 2 no pino PB2
.equ L3 = PB3               ; LED 3 no pino PB3
.equ L4 = PB4               ; LED 4 no pino PB4
.equ L5 = PB5               ; LED 5 no pino PB5
.equ L6 = PB6               ; LED 6 no pino PB6
.equ L7 = PB7               ; LED 7 no pino PB7

.def AUX = R16              ; Registrador auxiliar
.def LED_COUNTER = R17      ; Contador para LEDs acesos

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0xFF            ; Configura PB0-PB7 como saída para LEDs
    out DDRB, AUX
    ldi AUX, 0x00            ; Desliga todos os LEDs inicialmente
    out PORTB, AUX

    cbi DDRD, BOTAO_AUMENTAR ; Configura o botão aumentar como entrada
    cbi DDRD, BOTAO_DIMINUIR ; Configura o botão diminuir como entrada
    sbi PORTD, BOTAO_AUMENTAR; Ativa pull-up no pino do botão aumentar
    sbi PORTD, BOTAO_DIMINUIR; Ativa pull-up no pino do botão diminuir

    ldi AUX, 0x03            ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX
    sbi EIMSK, INT0          ; Habilita interrupção INT0 (BOTÃO AUMENTAR)
    sbi EIMSK, INT1          ; Habilita interrupção INT1 (BOTÃO DIMINUIR)

    sei                      ; Habilita as interrupções globais

    rjmp main                ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main                ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão AUMENTAR (INT0)
; -------------------------------------------------
isr_int0:
    push R16                 ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    inc LED_COUNTER          ; Incrementa o contador de LEDs acesos
    cpi LED_COUNTER, 9       ; Verifica se o contador atingiu 8 LEDs
    brge reset_leds          ; Se sim, reinicia a contagem

    ; Acende os LEDs conforme o contador
    sbi PORTB, LED_COUNTER   ; Liga o LED correspondente

    pop R16                  ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                     ; Retorna da interrupção

reset_leds:
    ldi LED_COUNTER, 0       ; Reseta o contador para 0
    out PORTB, AUX           ; Apaga todos os LEDs
    rjmp isr_int0            ; Continua o ciclo

; -------------------------------------------------
; Rotina de interrupção para o botão DIMINUIR (INT1)
; -------------------------------------------------
isr_int1:
    push R16                 ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    dec LED_COUNTER          ; Decrementa o contador de LEDs acesos
    cpi LED_COUNTER, -1      ; Verifica se o contador atingiu -1
    brlt all_on              ; Se sim, acende todos os LEDs

    ; Apaga o LED correspondente
    cbi PORTB, LED_COUNTER

    pop R16                  ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                     ; Retorna da interrupção

all_on:
    ldi LED_COUNTER, 7       ; Reseta o contador para acender todos os LEDs
    out PORTB, AUX           ; Liga todos os LEDs
    rjmp isr_int1            ; Continua o ciclo
