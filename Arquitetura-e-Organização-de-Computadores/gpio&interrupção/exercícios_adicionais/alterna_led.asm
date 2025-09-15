@ Simule um sistema com dois botões, BOTÃO AÇÃO (PB0) e BOTÃO RESET (PB1), e 8 LEDs (PD0 a PD7). O comportamento será o seguinte:

@ BOTÃO AÇÃO (PB0):

@ Quando o BOTÃO AÇÃO for pressionado, todos os LEDs devem alternar entre acesos e apagados. Ou seja, se os LEDs estão todos apagados, devem ser acesos. Se estiverem acesos, devem ser apagados.
@ BOTÃO RESET (PB1):

@ Quando o BOTÃO RESET for pressionado, todos os LEDs devem ser apagados imediatamente, independentemente do estado atual.
@ Interrupções:

@ INT0 (BOTÃO AÇÃO) para alternar os LEDs.
@ INT1 (BOTÃO RESET) para apagar todos os LEDs.


.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO_ACAO = PB0    ; Botão ação no pino PB0 (INT0)
.equ BOTAO_RESET = PB1   ; Botão reset no pino PB1 (INT1)
.equ L0 = PD0            ; LED 0 no pino PD0
.equ L1 = PD1            ; LED 1 no pino PD1
.equ L2 = PD2            ; LED 2 no pino PD2
.equ L3 = PD3            ; LED 3 no pino PD3
.equ L4 = PD4            ; LED 4 no pino PD4
.equ L5 = PD5            ; LED 5 no pino PD5
.equ L6 = PD6            ; LED 6 no pino PD6
.equ L7 = PD7            ; LED 7 no pino PD7

.def AUX = R16           ; Registrador auxiliar

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0xFF         ; Configura PB0-PB7 como saída para LEDs
    out DDRD, AUX
    ldi AUX, 0x00         ; Desliga todos os LEDs inicialmente
    out PORTD, AUX

    cbi DDRB, BOTAO_ACAO  ; Configura o botão ação como entrada
    cbi DDRB, BOTAO_RESET ; Configura o botão reset como entrada
    sbi PORTB, BOTAO_ACAO ; Ativa o pull-up no pino do botão ação
    sbi PORTB, BOTAO_RESET; Ativa o pull-up no pino do botão reset

    ldi AUX, 0x03         ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX
    sbi EIMSK, INT0       ; Habilita interrupção INT0 (BOTÃO AÇÃO)
    sbi EIMSK, INT1       ; Habilita interrupção INT1 (BOTÃO RESET)

    sei                   ; Habilita as interrupções globais

    rjmp main             ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main             ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão AÇÃO (INT0)
; -------------------------------------------------
isr_int0:
    push R16              ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    ; Alterna os LEDs
    eor PORTD, 0xFF       ; Inverte todos os LEDs (acende ou apaga)

    pop R16               ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                  ; Retorna da interrupção

; -------------------------------------------------
; Rotina de interrupção para o botão RESET (INT1)
; -------------------------------------------------
isr_int1:
    push R16              ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    cbi PORTD, L0         ; Apaga todos os LEDs
    cbi PORTD, L1
    cbi PORTD, L2
    cbi PORTD, L3
    cbi PORTD, L4
    cbi PORTD, L5
    cbi PORTD, L6
    cbi PORTD, L7

    pop R16               ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                  ; Retorna da interrupção
