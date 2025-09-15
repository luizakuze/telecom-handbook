@ Usamos uma tabela para definir os pulos dos LEDs.
@ O LED não segue um padrão linear (PB0 → PB1 → PB2, etc.), mas sim saltos maiores.
@ O botão + muda o padrão de salto, e o botão - volta para o padrão original.

.INCLUDE <m328Pdef.inc>  ; Inclui definições do ATmega328P

; ==========================
; Definições de pinos
; ==========================
.equ BOTAO_AUMENTAR = PD2   ; Botão + (altera padrão de salto)
.equ BOTAO_DIMINUIR = PD3   ; Botão - (volta ao padrão anterior)

; ==========================
; Definição de registradores
; ==========================
.def AUX = R16        ; Registrador auxiliar
.def LED_INDEX = R17  ; Índice do LED atual
.def PADRAO = R18     ; Define o padrão de pulos (0 = normal, 1 = pulos maiores)
.def DIRECAO = R19    ; 0 = esquerda para direita, 1 = direita para esquerda

; ==========================
; Tabela de pulos dos LEDs
; ==========================
.ORG 0x100              ; Define onde os padrões serão armazenados na memória Flash
SALTO_NORMAL:           ; Padrão de avanço normal
    .DB 1, 1, 1, 1, 1, 1, 1  ; LEDs se movem 1 a 1
SALTO_ALTERNATIVO:      ; Padrão de avanço alternativo (salta LEDs)
    .DB 2, 1, 3, 2, 1, 2, 3  ; LEDs pulam de forma diferente

; ==========================
; Configuração inicial
; ==========================
setup:
    ldi AUX, 0xFF
    out DDRB, AUX       ; Configura PB0-PB7 como saída para LEDs
    ldi AUX, 0x00
    out PORTB, AUX      ; Apaga todos os LEDs

    ; Configura botões como entrada com pull-up ativado
    cbi DDRD, BOTAO_AUMENTAR
    cbi DDRD, BOTAO_DIMINUIR
    sbi PORTD, BOTAO_AUMENTAR
    sbi PORTD, BOTAO_DIMINUIR

    clr LED_INDEX       ; Começa no primeiro LED (PB0)
    clr DIRECAO         ; Define a direção inicial (PB0 → PB7)
    clr PADRAO          ; Começa com o padrão normal

    rjmp main           ; Pula para o loop principal

; ==========================
; Loop principal
; ==========================
main:
    clr AUX                     ; Limpa o registrador auxiliar
    ldi R20, 1                  ; Inicia com 0b00000001 no R20 (LED no PB0)
    
    mov R21, LED_INDEX          ; Copia LED_INDEX para R21 (contador de shifts)
loop_shift:  
    cpi R21, 0                  ; Se LED_INDEX for 0, já está na posição correta
    breq led_setado             ; Se sim, pula para próxima etapa
    lsl R20                     ; Desloca bit para a esquerda
    dec R21                     ; Decrementa contador de shifts
    rjmp loop_shift             ; Continua deslocando até alcançar LED_INDEX

led_setado:
    mov AUX, R20                ; Copia valor final para AUX
    out PORTB, AUX              ; Atualiza LEDs no PORTB

    ldi R20, 8
    rcall delay                 ; Chama a rotina de atraso

    ; Verifica botões para trocar padrão de salto
    sbic PIND, BOTAO_AUMENTAR    ; Se botão + for pressionado, troca para o outro padrão
    ldi PADRAO, 1
    sbic PIND, BOTAO_DIMINUIR    ; Se botão - for pressionado, volta para o padrão original
    clr PADRAO

    ; Determina o próximo pulo de LED baseado no PADRAO selecionado
    ldi ZL, LOW(SALTO_NORMAL)  
    ldi ZH, HIGH(SALTO_NORMAL)
    tst PADRAO                   ; Se PADRAO = 1, muda para tabela alternativa
    breq usa_padrao_normal
    ldi ZL, LOW(SALTO_ALTERNATIVO)  
    ldi ZH, HIGH(SALTO_ALTERNATIVO)

usa_padrao_normal:
    add ZL, LED_INDEX            ; Adiciona índice do LED ao ponteiro da tabela
    lpm AUX, Z                   ; Carrega o valor do pulo do LED
    tst DIRECAO                  ; Verifica direção
    breq mover_direita            
    rjmp mover_esquerda           

mover_direita:
    add LED_INDEX, AUX           ; Incrementa o LED de acordo com a tabela
    cpi LED_INDEX, 8
    brlt main                    
    ldi LED_INDEX, 6             ; Se chegou ao final, troca a direção
    ldi DIRECAO, 1
    rjmp main

mover_esquerda:
    sub LED_INDEX, AUX           ; Decrementa o LED de acordo com a tabela
    brpl main                    
    clr LED_INDEX                ; Se chegou ao início, troca a direção
    clr DIRECAO
    rjmp main

; ==========================
; Rotina de atraso
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
