@ Descrição: Simule um sistema com 8 LEDs (PB0 a PB7) e um botão (PD2). A cada vez que o botão for pressionado, os LEDs devem seguir um padrão específico:

@ Na primeira pressão do botão, o LED L0 (PB0) acende.
@ Na segunda pressão, o LED L1 (PB1) acende.
@ Na terceira pressão, os LEDs L0 e L1 devem piscar alternadamente a cada 1 segundo.
@ Na quarta pressão, os LEDs L2 (PB2) e L3 (PB3) devem acender.
@ Nas próximas pressões, os LEDs devem piscar alternadamente entre L0 a L3.

.INCLUDE <m328Pdef.inc>

.DSEG
.ORG SRAM_START
    LED_PATTERN: .BYTE 4 ; vetor com 4 padrões para os LEDs
.CSEG

.def AUX = R16
.equ BOTAO = PD2
.equ L0 = PB0
.equ L1 = PB1
.equ L2 = PB2
.equ L3 = PB3
.equ L4 = PB4
.equ L5 = PB5
.equ L6 = PB6
.equ L7 = PB7

setup:
    ldi AUX, 0xFF          ; configura PB0-PB7 como saída para LEDs
    out DDRB, AUX
    ldi AUX, 0x00          ; desliga todos os LEDs
    out PORTB, AUX

    cbi DDRD, BOTAO        ; configura o botão como entrada
    sbi PORTD, BOTAO       ; ativa pull-up para o botão

    ldi AUX, 0x02          ; configuração da interrupção na borda de descida (botão pressionado)
    sts EICRA, AUX
    sbi EIMSK, INT0        ; habilita interrupção externa INT0

    sei                    ; habilita as interrupções globais

    ldi R17, 0             ; inicializa o contador de pressões
    rjmp main

main:
    rjmp main              ; mantém o sistema esperando as interrupções

isr_int0:
    push R16               ; salva o contexto
    in R16, SREG
    push R16

    inc R17                ; incrementa o contador de pressões
    cpi R17, 4             ; se o contador chegar a 4, reinicia o ciclo
    breq reset_count

    ; Definir padrão de LEDs dependendo da pressão
    ldi YH, HIGH(LED_PATTERN)
    ldi YL, LOW(LED_PATTERN)
    ld R18, Y+             ; carrega o próximo padrão
    out PORTB, R18         ; aplica o padrão de LEDs

    rjmp fim_isr

reset_count:
    ldi R17, 0             ; reseta o contador de pressões
    rjmp fim_isr

fim_isr:
    pop R16                ; restaura o contexto
    out SREG, R16
    pop R16
    reti                   ; retorna da interrupção

