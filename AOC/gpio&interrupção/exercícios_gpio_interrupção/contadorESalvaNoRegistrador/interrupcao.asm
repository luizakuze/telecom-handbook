.INCLUDE <m328Pdef.inc>

; ==========================
; Definições de pinos
; ==========================
.equ BOTAO_INCREMENTO = PD2  ; Botão para incrementar contador (ligado à interrupção INT0)

; ==========================
; Definição de registradores
; ==========================
.def AUX = R16        ; Registrador auxiliar
.def CONTADOR = R17   ; Armazena o valor atual do contador (0 a 9)

; ==========================
; Configuração inicial
; ==========================
setup:
    sei                   ; Habilita interrupções globais

    ldi AUX, 0x0F
    out DDRB, AUX         ; Configura PB0-PB3 como saída para mostrar o número em binário
    ldi AUX, 0x00
    out PORTB, AUX        ; Apaga todos os LEDs no início

    cbi DDRD, BOTAO_INCREMENTO  ; Configura PD2 como entrada (botão)
    sbi PORTD, BOTAO_INCREMENTO ; Ativa pull-up interno no botão (PD2)

    ; Configuração da interrupção externa INT0 (PD2)
    ldi AUX, 0b00000010   ; Configura INT0 para ser acionada na borda de descida (botão pressionado)
    sts EICRA, AUX        ; Atualiza registrador de controle da interrupção externa
    sbi EIMSK, INT0       ; Habilita interrupção externa INT0

    clr CONTADOR          ; Inicializa o contador em 0

    rjmp main             ; Pula para o loop principal

; ==========================
; Loop principal (Apenas mantém a CPU ativa)
; ==========================
main:
    rjmp main             ; Fica em loop infinito esperando interrupções

; ==========================
; Rotina de interrupção para incrementar o contador (INT0)
; ==========================
isr_incremento:
    push R16
    in R16, SREG
    push R16

    inc CONTADOR           ; Incrementa contador
    cpi CONTADOR, 10       ; Se contador == 10, precisa resetar para 0
    brlt atualizar_display ; Se for menor que 10, apenas atualiza display
    clr CONTADOR           ; Se for igual a 10, reseta para 0

atualizar_display:
    out PORTB, CONTADOR    ; Exibe valor nos LEDs PB0-PB3

    ; Pequeno atraso para debounce dentro da interrupção
    ldi R20, 5
    rcall delay

    pop R16
    out SREG, R16
    pop R16
    reti                  ; Retorna da interrupção

; ==========================
; Rotina de atraso (debounce)
; ==========================
delay:
    push R17
    push R18
    clr R17
    clr R18

loopdelay:
    dec R17
    brne loopdelay
    dec R18
    brne loopdelay
    dec R20
    brne loopdelay

    pop R18
    pop R17
    ret
