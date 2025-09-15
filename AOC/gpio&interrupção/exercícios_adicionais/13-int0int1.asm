@ O sistema possui um botão em PD3 (INT1) e um LED em PB0.
@ Quando o botão for pressionado, o LED deve inverter o seu estado (se estiver aceso, apaga; se estiver apagado, acende).
@ Deve ser usado apenas INT1 para capturar a interrupção.

.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO = PD3   ; Botão no pino PD3 (INT1)
.equ LED = PB0     ; LED no pino PB0

.def AUX = R16     ; Registrador auxiliar

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0x01           ; Configura PB0 como saída (LED)
    out DDRB, AUX
    ldi AUX, 0x00           ; Desliga o LED inicialmente
    out PORTB, AUX

    cbi DDRD, BOTAO         ; Configura o botão como entrada
    sbi PORTD, BOTAO        ; Ativa pull-up no pino do botão

    ldi AUX, 0x0C           ; Configura INT1 para borda de descida (botão pressionado)
    sts EICRA, AUX
    sbi EIMSK, INT1         ; Habilita interrupção INT1 (BOTAO)

    sei                     ; Habilita as interrupções globais

    rjmp main               ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main               ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão (INT1)
; -------------------------------------------------
isr_int1:
    push R16                ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    sbi PINB, LED           ; Inverte o estado do LED

    pop R16                 ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                    ; Retorna da interrupção








//-----------------------------------------------------------------------
//-----------------------------------------------------------------------

@ Descrição:
@ O sistema possui um botão em PD2 (INT0) e um LED em PB1.
@ Quando o botão for pressionado, o LED deve piscar 3 vezes com um intervalo de 500ms entre cada mudança de estado.
@ Deve ser usado apenas INT0 para capturar a interrupção.

.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO = PD2   ; Botão no pino PD2 (INT0)
.equ LED = PB1     ; LED no pino PB1

.def AUX = R16     ; Registrador auxiliar

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0x02           ; Configura PB1 como saída (LED)
    out DDRB, AUX
    ldi AUX, 0x00           ; Desliga o LED inicialmente
    out PORTB, AUX

    cbi DDRD, BOTAO         ; Configura o botão como entrada
    sbi PORTD, BOTAO        ; Ativa pull-up no pino do botão

    ldi AUX, 0x02           ; Configura INT0 para borda de descida (botão pressionado)
    sts EICRA, AUX
    sbi EIMSK, INT0         ; Habilita interrupção INT0 (BOTAO)

    sei                     ; Habilita as interrupções globais

    rjmp main               ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main               ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão (INT0)
; -------------------------------------------------
isr_int0:
    push R16                ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    ldi AUX, 3              ; Define o número de piscadas

pisca_loop:
    sbi PORTB, LED          ; Liga o LED
    ldi R19, 40             ; 500ms de atraso
    rcall delay
    cbi PORTB, LED          ; Desliga o LED
    ldi R19, 40             ; 500ms de atraso
    rcall delay
    dec AUX
    brne pisca_loop         ; Continua piscando até completar 3 vezes

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
