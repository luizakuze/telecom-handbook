@ Descrição: Simule um sistema com 3 LEDs (L0, L1, L2) e um botão (PD2). O comportamento será o seguinte:

@ Comportamento do Botão:

@ Quando o botão (PD2) for pressionado, o LED L0 (PB0) deve acender, o LED L1 (PB1) deve apagar e o LED L2 (PB2) deve piscar a cada 1 segundo.
@ Quando o botão for solto, o LED L0 deve apagar, o LED L1 deve acender e o LED L2 deve parar de piscar.


.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO = PD2   ; Botão no pino PD2 (INT0)
.equ L0 = PB0      ; LED 0 no pino PB0
.equ L1 = PB1      ; LED 1 no pino PB1
.equ L2 = PB2      ; LED 2 no pino PB2

.def AUX = R16     ; Registrador auxiliar

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0x07          ; Configura PB0, PB1 e PB2 como saída para LEDs
    out DDRB, AUX
    ldi AUX, 0x00          ; Desliga os LEDs inicialmente
    out PORTB, AUX

    cbi DDRD, BOTAO        ; Configura o botão como entrada
    sbi PORTD, BOTAO       ; Ativa o pull-up no pino do botão

    ldi AUX, 0x03          ; Configura INT0 para borda de descida (botão pressionado)
    sts EICRA, AUX
    sbi EIMSK, INT0        ; Habilita interrupção INT0 (botão pressionado)

    sei                    ; Habilita as interrupções globais

    rjmp main              ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main              ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para borda de descida (botão pressionado)
; -------------------------------------------------
isr_int0_press:
    push R16               ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    sbi PORTB, L0          ; Liga L0
    cbi PORTB, L1          ; Desliga L1
    sbi PORTB, L2          ; Liga L2 (começa a piscar)
    
    ; Pisca L2 a cada 1 segundo
    ldi AUX, 80            ; 1 segundo de atraso (aproximadamente)
    rcall delay            ; Chama a rotina de delay para piscar L2
    cbi PORTB, L2          ; Desliga L2
    rcall delay            ; Outro atraso de 1 segundo
    sbi PORTB, L2          ; Liga L2 novamente

    pop R16                ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                   ; Retorna da interrupção

; -------------------------------------------------
; Rotina de interrupção para borda de subida (botão solto)
; -------------------------------------------------
isr_int0_release:
    push R16               ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    cbi PORTB, L0          ; Desliga L0
    sbi PORTB, L1          ; Liga L1
    cbi PORTB, L2          ; Desliga L2 (para de piscar)

    pop R16                ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                   ; Retorna da interrupção

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
    dec r19 
    brne loopdelay 
    
    pop r17
    out SREG, r17

    pop r18 
    pop r17
    
    ret
