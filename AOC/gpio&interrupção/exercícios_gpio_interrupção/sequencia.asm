@ 8 leds devem ligar quando os dois botoes estiverem pressionados.
@ 4 leds menos significativos devem ligar quando botao ajuste estiver pressionado
@ 4 leds mais significativos devem ligar quando o botao selecao estiver pressioncado
@ 8 leds devem apagar quando nenhum botao estiver pressionado
@  botao selsecao é pb1, botao ajuste é pb0;
@ utilizar leds pd0 a pd7

@ Interrupções:

@ INT0 (BOTÃO AJUSTE - PB0)
@ INT1 (BOTÃO SELEÇÃO - PB1)


.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO_AJUSTE = PB0    ; Botão ajuste no pino PB0 (INT0)
.equ BOTAO_SELECAO = PB1   ; Botão seleção no pino PB1 (INT1)
.equ L0 = PD0              ; LED 0 no pino PD0
.equ L1 = PD1              ; LED 1 no pino PD1
.equ L2 = PD2              ; LED 2 no pino PD2
.equ L3 = PD3              ; LED 3 no pino PD3
.equ L4 = PD4              ; LED 4 no pino PD4
.equ L5 = PD5              ; LED 5 no pino PD5
.equ L6 = PD6              ; LED 6 no pino PD6
.equ L7 = PD7              ; LED 7 no pino PD7

.def AUX = R16             ; Registrador auxiliar
.def LED_PATTERN = R17     ; Registrador para controlar os LEDs

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0xFF           ; Configura PD0-PD7 como saída para LEDs
    out DDRD, AUX
    ldi AUX, 0x00           ; Desliga todos os LEDs inicialmente
    out PORTD, AUX

    cbi DDRB, BOTAO_AJUSTE  ; Configura o botão ajuste como entrada
    cbi DDRB, BOTAO_SELECAO ; Configura o botão seleção como entrada
    sbi PORTB, BOTAO_AJUSTE ; Ativa pull-up no pino do botão ajuste
    sbi PORTB, BOTAO_SELECAO; Ativa pull-up no pino do botão seleção

    ldi AUX, 0x03           ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX
    sbi EIMSK, INT0         ; Habilita interrupção INT0 (BOTÃO AJUSTE)
    sbi EIMSK, INT1         ; Habilita interrupção INT1 (BOTÃO SELECAO)

    sei                     ; Habilita as interrupções globais

    rjmp main               ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main               ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão AJUSTE (PB0 - INT0)
; -------------------------------------------------
isr_int0:
    push R16                ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    ; Se ambos os botões estiverem pressionados, liga todos os LEDs
    sbis PINB, BOTAO_SELECAO
    rjmp ajuste_leds

    ; Caso contrário, liga os 4 LEDs menos significativos
ajuste_leds:
    sbi PORTD, L0           ; Liga os 4 LEDs menos significativos
    sbi PORTD, L1
    sbi PORTD, L2
    sbi PORTD, L3
    cbi PORTD, L4           ; Desliga os 4 LEDs mais significativos
    cbi PORTD, L5
    cbi PORTD, L6
    cbi PORTD, L7

    pop R16                 ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                    ; Retorna da interrupção

; -------------------------------------------------
; Rotina de interrupção para o botão SELECAO (PB1 - INT1)
; -------------------------------------------------
isr_int1:
    push R16                ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    ; Se ambos os botões estiverem pressionados, liga todos os LEDs
    sbis PINB, BOTAO_AJUSTE
    rjmp selecao_leds

    ; Caso contrário, liga os 4 LEDs mais significativos
selecao_leds:
    sbi PORTD, L4           ; Liga os 4 LEDs mais significativos
    sbi PORTD, L5
    sbi PORTD, L6
    sbi PORTD, L7
    cbi PORTD, L0           ; Desliga os 4 LEDs menos significativos
    cbi PORTD, L1
    cbi PORTD, L2
    cbi PORTD, L3

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
