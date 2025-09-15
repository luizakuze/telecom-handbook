@ Descrição: Simule um circuito com dois botões, MODE (PD2) e RESET (PD3), e 8 LEDs (PB0 a PB7). O comportamento será o seguinte:

@ Botão MODE (PD2):

@ Quando o botão MODE for pressionado, os LEDs devem seguir um padrão cíclico:
@ Na primeira pressão, todos os LEDs devem acender.
@ Na segunda pressão, os LEDs devem piscar a cada 500ms.
@ Na terceira pressão, os LEDs devem acender alternadamente, começando com L0 e L1, depois L2 e L3, e assim por diante.
@ Quando o botão MODE for pressionado pela quarta vez, o padrão deve reiniciar.
@ Botão RESET (PD3):

@ Quando o botão RESET for pressionado, todos os LEDs devem apagar imediatamente, independentemente do padrão de MODE.
.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ MODE = PD2       ; Botão MODE no pino PD2 (INT0)
.equ RESET = PD3      ; Botão RESET no pino PD3 (INT1)
.equ L0 = PB0         ; LED 0 no pino PB0
.equ L1 = PB1         ; LED 1 no pino PB1
.equ L2 = PB2         ; LED 2 no pino PB2
.equ L3 = PB3         ; LED 3 no pino PB3
.equ L4 = PB4         ; LED 4 no pino PB4
.equ L5 = PB5         ; LED 5 no pino PB5
.equ L6 = PB6         ; LED 6 no pino PB6
.equ L7 = PB7         ; LED 7 no pino PB7

.def AUX = R16        ; Registrador auxiliar
.def LED_PATTERN = R17 ; Registrador para controlar o padrão dos LEDs

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0xFF           ; Configura PB0-PB7 como saída para LEDs
    out DDRB, AUX
    ldi AUX, 0x00           ; Desliga todos os LEDs inicialmente
    out PORTB, AUX

    cbi DDRD, MODE          ; Configura o botão MODE como entrada
    cbi DDRD, RESET         ; Configura o botão RESET como entrada
    sbi PORTD, MODE         ; Ativa pull-up no pino do botão MODE
    sbi PORTD, RESET        ; Ativa pull-up no pino do botão RESET

    ldi AUX, 0x03           ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX
    sbi EIMSK, INT0         ; Habilita interrupção INT0 (MODE)
    sbi EIMSK, INT1         ; Habilita interrupção INT1 (RESET)

    sei                     ; Habilita as interrupções globais

    rjmp main               ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main               ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão MODE (INT0)
; -------------------------------------------------
isr_int0:
    push R16                ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    ; Incrementa o padrão dos LEDs
    inc LED_PATTERN         ; Incrementa o padrão dos LEDs
    cpi LED_PATTERN, 4      ; Se já chegou a 4 padrões, reinicia
    brge reset_pattern

    ; Ação baseada no padrão
    rcall change_leds       ; Altera os LEDs de acordo com o padrão

    pop R16                 ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                    ; Retorna da interrupção

reset_pattern:
    ldi LED_PATTERN, 0      ; Reseta o padrão para 0 (todos os LEDs acesos)
    rjmp change_leds        ; Altera os LEDs para o padrão inicial

; -------------------------------------------------
; Rotina de interrupção para o botão RESET (INT1)
; -------------------------------------------------
isr_int1:
    push R16                ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    ; Apaga todos os LEDs
    ldi AUX, 0x00
    out PORTB, AUX

    pop R16                 ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                    ; Retorna da interrupção

; -------------------------------------------------
; Sub-rotina para mudar os LEDs conforme o padrão
; -------------------------------------------------
change_leds:
    ; Se o padrão for 0, todos os LEDs devem acender
    cpi LED_PATTERN, 0
    breq all_on

    ; Se o padrão for 1, os LEDs devem piscar a cada 500ms
    cpi LED_PATTERN, 1
    breq blink

    ; Se o padrão for 2, os LEDs devem acender alternadamente
    cpi LED_PATTERN, 2
    breq alternate

    rjmp all_on             ; Caso contrário, acende todos os LEDs

all_on:
    sbi PORTB, L0           ; Liga todos os LEDs
    sbi PORTB, L1
    sbi PORTB, L2
    sbi PORTB, L3
    sbi PORTB, L4
    sbi PORTB, L5
    sbi PORTB, L6
    sbi PORTB, L7
    rjmp finish_leds

blink:
    sbi PORTB, L0           ; Liga o LED L0
    rcall delay
    cbi PORTB, L0           ; Desliga o LED L0
    rcall delay
    sbi PORTB, L0           ; Liga o LED L0
    rjmp finish_leds

alternate:
    sbi PORTB, L0           ; Liga L0
    cbi PORTB, L1           ; Desliga L1
    sbi PORTB, L2           ; Liga L2
    cbi PORTB, L3           ; Desliga L3
    sbi PORTB, L4           ; Liga L4
    cbi PORTB, L5           ; Desliga L5
    rjmp finish_leds

finish_leds:
    ret                     ; Retorna da sub-rotina

; -------------------------------------------------
; Sub-rotina de atraso programável (500ms)
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
    dec r19 
    brne loopdelay 
    
    pop r17
    out SREG, r17

    pop r18 
    pop r17
    
    ret
