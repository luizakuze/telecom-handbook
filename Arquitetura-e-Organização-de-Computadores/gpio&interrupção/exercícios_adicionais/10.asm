@ Descrição: Simule um sistema com dois botões e dois LEDs. O comportamento será o seguinte:

@ Botões:

@ BOTAO1 (PD2): Quando pressionado, inverte a função entre os dois LEDs. Inicialmente, o LED L0 (PB0) estará aceso e o LED L1 (PB1) estará apagado. Depois de pressionar o BOTAO1, o LED L1 deve acender e o LED L0 deve apagar.
@ BOTAO2 (PD3): Quando pressionado, inverte novamente a função dos LEDs. Se o LED L0 estava apagado e o LED L1 estava aceso, ao pressionar o BOTAO2, o LED L0 acende novamente e o LED L1 apaga.

.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO1 = PD2   ; Botão 1 no pino PD2 (INT0)
.equ BOTAO2 = PD3   ; Botão 2 no pino PD3 (INT1)
.equ L0 = PB0       ; LED 0 no pino PB0
.equ L1 = PB1       ; LED 1 no pino PB1

.def AUX = R16      ; Registrador auxiliar

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0x03         ; Configura PB0 e PB1 como saída para LEDs
    out DDRB, AUX
    ldi AUX, 0x00         ; Desliga ambos os LEDs inicialmente
    out PORTB, AUX

    cbi DDRD, BOTAO1      ; Configura o botão 1 como entrada
    cbi DDRD, BOTAO2      ; Configura o botão 2 como entrada
    sbi PORTD, BOTAO1     ; Ativa o pull-up no pino do botão 1
    sbi PORTD, BOTAO2     ; Ativa o pull-up no pino do botão 2

    ldi AUX, 0x03         ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX
    sbi EIMSK, INT0       ; Habilita interrupção INT0 (BOTAO1)
    sbi EIMSK, INT1       ; Habilita interrupção INT1 (BOTAO2)

    sei                   ; Habilita as interrupções globais

    rjmp main             ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main             ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão 1 (BOTAO1 - INT0)
; -------------------------------------------------
isr_int0_press:
    push R16              ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    ; Inverte os LEDs
    sbic PORTB, L0        ; Se L0 está aceso
    rjmp inverte_leds

    cbi PORTB, L0         ; Desliga L0
    sbi PORTB, L1         ; Liga L1
    rjmp fim_isr

inverte_leds:
    sbi PORTB, L0         ; Liga L0
    cbi PORTB, L1         ; Desliga L1

fim_isr:
    pop R16               ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                  ; Retorna da interrupção

; -------------------------------------------------
; Rotina de interrupção para o botão 2 (BOTAO2 - INT1)
; -------------------------------------------------
isr_int1_press:
    push R16              ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    ; Inverte os LEDs novamente
    sbic PORTB, L0        ; Se L0 está aceso
    rjmp inverte_leds_2

    cbi PORTB, L0         ; Desliga L0
    sbi PORTB, L1         ; Liga L1
    rjmp fim_isr_2

inverte_leds_2:
    sbi PORTB, L0         ; Liga L0
    cbi PORTB, L1         ; Desliga L1

fim_isr_2:
    pop R16               ; Restaura o contexto (SREG)
    out SREG, R16
    pop R16
    reti                  ; Retorna da interrupção
