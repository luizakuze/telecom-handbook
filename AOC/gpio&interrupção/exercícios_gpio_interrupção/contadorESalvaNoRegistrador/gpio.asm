@O sistema usa um botão para incrementar o contador, e quando chega a 9, ele reseta para 0 automaticamente.

.INCLUDE <m328Pdef.inc>

; ==========================
; Definições de pinos
; ==========================
.equ BOTAO_INCREMENTO = PD2  ; Botão para incrementar contador

; ==========================
; Definição de registradores
; ==========================
.def AUX = R16        ; Registrador auxiliar
.def CONTADOR = R17   ; Armazena o valor atual do contador (0 a 9)
.def ESTADO_BOTAO = R18  ; Armazena o último estado do botão (para debounce)

; ==========================
; Configuração inicial
; ==========================
setup:
    ldi AUX, 0x0F
    out DDRB, AUX       ; Configura PB0-PB3 como saída para mostrar o número em binário
    ldi AUX, 0x00
    out PORTB, AUX      ; Apaga todos os LEDs no início

    cbi DDRD, BOTAO_INCREMENTO  ; Configura PD2 como entrada (botão)
    sbi PORTD, BOTAO_INCREMENTO ; Ativa pull-up interno no botão (PD2)

    clr CONTADOR        ; Inicializa o contador em 0
    clr ESTADO_BOTAO    ; Define estado inicial do botão

    rjmp main           ; Pula para o loop principal

; ==========================
; Loop principal
; ==========================
main:
    sbic PIND, BOTAO_INCREMENTO  ; Se o botão NÃO foi pressionado, pula a próxima instrução
    rjmp nao_incrementa          ; Evita somar múltiplas vezes com um único toque

    ; Debounce - Pequeno atraso para evitar ruído mecânico do botão
    ldi R20, 5
    rcall delay

    sbic PIND, BOTAO_INCREMENTO  ; Se o botão ainda estiver pressionado, não altera
    rjmp nao_incrementa

    inc CONTADOR                ; Incrementa contador
    cpi CONTADOR, 10            ; Se contador == 10, precisa resetar para 0
    brlt atualizar_display       ; Se for menor que 10, apenas atualiza display
    clr CONTADOR                ; Se for igual a 10, reseta para 0

atualizar_display:
    out PORTB, CONTADOR         ; Exibe valor nos LEDs PB0-PB3

nao_incrementa:
    rjmp main                   ; Retorna ao loop principal

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
