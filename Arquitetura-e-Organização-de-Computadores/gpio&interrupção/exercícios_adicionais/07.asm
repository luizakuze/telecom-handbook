@ Descrição: Simule um sistema que controle dois LEDs (L0 em PB0 e L1 em PB1) com base no pressionamento de um botão (em PD2). O comportamento será o seguinte:

@ Botão Pressionado:

@ Quando o botão for pressionado, o LED L0 (PB0) deve acender e permanecer aceso enquanto o botão estiver pressionado.
@ Quando o botão for solto, o LED L0 deve apagar e o LED L1 (PB1) deve acender, indicando que o botão foi solto.
@ Comportamento do Sistema:

@ O LED L0 (PB0) deve ser aceso quando o botão for pressionado e apagado quando o botão for solto.
@ O LED L1 (PB1) deve ser aceso sempre que o botão for solto.


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
    ldi AUX, 0x00          ; Desliga ambos os LEDs
    out PORTB, AUX

    cbi DDRD, BOTAO        ; Configura PD2 como entrada para o botão
    sbi PORTD, BOTAO       ; Ativa o pull-up no PD2

    ldi AUX, 0x03          ; Configura INT0 para borda de subida
    sts EICRA, AUX
    sbi EIMSK, INT0        ; Habilita interrupção INT0 (botão pressionado)
    
    sei                    ; Habilita interrupções globais

    rjmp main              ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main              ; O loop principal não faz nada, aguardando interrupções

; -------------------------------------------------
; Rotina de interrupção para borda de descida (botão pressionado)
; -------------------------------------------------
isr_int0_press:
    push R16               ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    cbi PORTB, L0          ; Desliga o LED L0
    sbi PORTB, L1          ; Liga o LED L1 (botão foi solto)

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

    sbi PORTB, L0          ; Liga o LED L0
    cbi PORTB, L1          ; Desliga o LED L1 (botão foi pressionado)

    pop R16                ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                   ; Retorna da interrupção
