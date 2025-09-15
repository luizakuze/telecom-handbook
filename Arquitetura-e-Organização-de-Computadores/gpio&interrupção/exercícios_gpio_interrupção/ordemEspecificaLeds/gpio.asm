@ O botão X (PD2) ativa a sequência 1 de LEDs.
@ O botão Y (PD3) ativa a sequência 2 de LEDs.
@ Se nenhum botão for pressionado, os LEDs ficam apagados.

.INCLUDE <m328Pdef.inc>  ; Inclui definições do ATmega328P

; ==========================
; Definições de pinos
; ==========================
.equ BOTAO_X = PD2  ; Botão para ativar sequência 1 (PD2)
.equ BOTAO_Y = PD3  ; Botão para ativar sequência 2 (PD3)

; ==========================
; Definição de registradores
; ==========================
.def AUX = R16       ; Registrador auxiliar
.def ESTADO = R17    ; Armazena qual sequência está ativa (0 = nenhuma, 1 = seq1, 2 = seq2)

; ==========================
; Configuração inicial
; ==========================
setup:
    ldi AUX, 0xFF          ; Carrega 0xFF para configurar PB0-PB7 como saída
    out DDRB, AUX          ; Define os pinos PB0-PB7 como saída para os LEDs
    ldi AUX, 0x00          ; Garante que todos os LEDs estão apagados no início
    out PORTB, AUX

    cbi DDRD, BOTAO_X      ; Configura PD2 como entrada (botão X)
    cbi DDRD, BOTAO_Y      ; Configura PD3 como entrada (botão Y)
    sbi PORTD, BOTAO_X     ; Ativa pull-up interno no botão X
    sbi PORTD, BOTAO_Y     ; Ativa pull-up interno no botão Y

    clr ESTADO             ; Inicializa sem nenhuma sequência ativa

    rjmp main              ; Vai para o loop principal

; ==========================
; Loop principal
; ==========================
main:
    sbic PIND, BOTAO_X      ; Verifica se o botão X NÃO foi pressionado
    rjmp verifica_botao_y   ; Se não foi pressionado, verifica o outro botão

    ldi ESTADO, 1           ; Define a sequência 1 como ativa
    rjmp executar_seq       ; Pula para executar a sequência

verifica_botao_y:
    sbic PIND, BOTAO_Y      ; Verifica se o botão Y NÃO foi pressionado
    rjmp apagar_leds        ; Se nenhum botão foi pressionado, apaga os LEDs

    ldi ESTADO, 2           ; Define a sequência 2 como ativa

executar_seq:
    cpi ESTADO, 1           ; Compara se ESTADO == 1
    brne executar_seq2      ; Se não for, executa sequência 2

    ; Sequência 1 - LEDs acendem um de cada vez
    ldi AUX, 0b00000001
    out PORTB, AUX
    rcall delay
    ldi AUX, 0b00000010
    out PORTB, AUX
    rcall delay
    ldi AUX, 0b00000100
    out PORTB, AUX
    rcall delay
    ldi AUX, 0b00001000
    out PORTB, AUX
    rcall delay
    rjmp main

executar_seq2:
    ; Sequência 2 - LEDs acendem simetricamente
    ldi AUX, 0b10000001
    out PORTB, AUX
    rcall delay
    ldi AUX, 0b01000010
    out PORTB, AUX
    rcall delay
    ldi AUX, 0b00100100
    out PORTB, AUX
    rcall delay
    ldi AUX, 0b00011000
    out PORTB, AUX
    rcall delay
    rjmp main

apagar_leds:
    ldi AUX, 0x00          ; Define todos os LEDs como apagados
    out PORTB, AUX
    rjmp main              ; Retorna ao loop principal

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

    pop R18
    pop R17
    ret
