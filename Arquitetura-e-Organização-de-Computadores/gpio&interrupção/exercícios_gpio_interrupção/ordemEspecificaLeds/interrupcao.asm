.INCLUDE <m328Pdef.inc>  ; Inclui definições do ATmega328P

; ==========================
; Definições de pinos
; ==========================
.equ BOTAO_X = PD2  ; Botão que ativa sequência 1 (INT0)
.equ BOTAO_Y = PD3  ; Botão que ativa sequência 2 (INT1)

; ==========================
; Definição de registradores
; ==========================
.def AUX = R16       ; Registrador auxiliar
.def ESTADO = R17    ; Indica qual sequência está ativa (0 = nenhuma, 1 = seq1, 2 = seq2)

; ==========================
; Configuração inicial
; ==========================
setup:
    sei                   ; Habilita interrupções globais

    ldi AUX, 0xFF
    out DDRB, AUX         ; Configura PB0-PB7 como saída para LEDs
    ldi AUX, 0x00
    out PORTB, AUX        ; Apaga todos os LEDs no início

    cbi DDRD, BOTAO_X     ; Configura botões como entrada
    cbi DDRD, BOTAO_Y
    sbi PORTD, BOTAO_X    ; Ativa pull-up nos botões
    sbi PORTD, BOTAO_Y

    ; Configuração de interrupções externas
    ldi AUX, 0b00001010   ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX
    sbi EIMSK, INT0       ; Habilita INT0 (PD2)
    sbi EIMSK, INT1       ; Habilita INT1 (PD3)

    clr ESTADO            ; Nenhuma sequência ativa inicialmente

    rjmp main             ; Pula para o loop principal

; ==========================
; Loop principal
; ==========================
main:
    rjmp main             ; Fica em loop infinito

; ==========================
; Interrupção para ativar sequência 1 (INT0)
; ==========================
isr_seq1:
    push R16
    in R16, SREG
    push R16

    ldi ESTADO, 1         ; Ativa sequência 1

    pop R16
    out SREG, R16
    pop R16
    reti

; ==========================
; Interrupção para ativar sequência 2 (INT1)
; ==========================
isr_seq2:
    push R16
    in R16, SREG
    push R16

    ldi ESTADO, 2         ; Ativa sequência 2

    pop R16
    out SREG, R16
    pop R16
    reti

; ==========================
; Sequências de LEDs
; ==========================
executar_seq1:
    ; Mesma sequência de LEDs do primeiro código

executar_seq2:
    ; Mesma sequência de LEDs do primeiro código

; ==========================
; Rotina de atraso
; ==========================
delay:
    ; Mesma rotina de atraso do primeiro código
