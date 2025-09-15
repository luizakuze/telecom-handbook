@ BOTÃO INICIAR (PB0):

@ Quando o BOTÃO INICIAR for pressionado, os LEDs devem piscar a cada 500ms. Os LEDs começam a piscar alternando entre aceso e apagado, começando pelo LED PB0 e seguindo até PB7.
@ BOTÃO PARAR (PB1):

@ Quando o BOTÃO PARAR for pressionado, todos os LEDs devem parar de piscar e permanecer apagados até a próxima ação do BOTÃO INICIAR.

.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO_INICIAR = PB0   ; Botão iniciar no pino PB0 (INT0)
.equ BOTAO_PARAR = PB1     ; Botão parar no pino PB1 (INT1)
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
    ldi AUX, 0xFF           ; Configura PB0-PB7 como saída para LEDs
    out DDRD, AUX
    ldi AUX, 0x00           ; Desliga todos os LEDs inicialmente
    out PORTD, AUX

    cbi DDRB, BOTAO_INICIAR ; Configura o botão iniciar como entrada
    cbi DDRB, BOTAO_PARAR   ; Configura o botão parar como entrada
    sbi PORTB, BOTAO_INICIAR; Ativa o pull-up no pino do botão iniciar
    sbi PORTB, BOTAO_PARAR  ; Ativa o pull-up no pino do botão parar

    ldi AUX, 0x03           ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX
    sbi EIMSK, INT0         ; Habilita interrupção INT0 (BOTÃO INICIAR)
    sbi EIMSK, INT1         ; Habilita interrupção INT1 (BOTÃO PARAR)

    sei                     ; Habilita as interrupções globais

    rjmp main               ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main               ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão INICIAR (INT0)
; -------------------------------------------------
isr_int0:
    push R16                ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    ; Pisca os LEDs alternadamente
    eor PORTD, 0xFF         ; Inverte todos os LEDs (acende ou apaga)
    ldi R19, 40             ; Aproximadamente 500ms de atraso
    rcall delay

    pop R16                 ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                    ; Retorna da interrupção

; -------------------------------------------------
; Rotina de interrupção para o botão PARAR (INT1)
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
