@ Descrição: Simule um sistema que controle dois LEDs (L0 e L1) com base no pressionamento de um botão (em PD2). O comportamento será o seguinte:

@ Pressionamento do Botão:

@ Quando o botão for pressionado, o LED L0 (PB0) deve acender, e o LED L1 (PB1) deve piscar a cada 500ms.
@ Quando o botão for solto, o LED L0 deve apagar e o LED L1 deve parar de piscar.

.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO = PD2   ; Botão no pino PD2 (INT0)
.equ L0 = PB0      ; LED 0 no pino PB0
.equ L1 = PB1      ; LED 1 no pino PB1

.def AUX = R16     ; Registrador auxiliar

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0x03          ; Configura PB0 e PB1 como saída para LEDs
    out DDRB, AUX
    ldi AUX, 0x00          ; Desliga ambos os LEDs inicialmente
    out PORTB, AUX

    cbi DDRD, BOTAO        ; Configura o botão como entrada
    sbi PORTD, BOTAO       ; Ativa o pull-up no pino do botão

    ldi AUX, 0x02          ; Configura INT0 para borda de descida (botão pressionado)
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
    rjmp pisca_L1          ; Chama rotina para piscar L1

pisca_L1:
    sbi PORTB, L1          ; Liga L1
    ldi AUX, 40            ; Aproximadamente 500ms de delay
    rcall delay            ; Chama a rotina de delay para fazer L1 piscar
    cbi PORTB, L1          ; Desliga L1
    rcall delay            ; Atraso de 500ms
    sbis PIND, BOTAO       ; Se o botão não foi pressionado, termina a interrupção
    rjmp pisca_L1          ; Caso contrário, continua piscando L1

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
    cbi PORTB, L1          ; Desliga L1 (para de piscar)

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
