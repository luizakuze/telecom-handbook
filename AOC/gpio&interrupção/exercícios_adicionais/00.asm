@ Quando o botão PB0 é pressionado, todos os LEDs acendem.
@ Quando o botão PB1 é pressionado, os LEDs PD0 a PD3 se apagam, mas os LEDs PD4 a PD7 permanecem acesos.
@ Quando o botão PB2 é pressionado, os LEDs PD4 a PD7 se apagam, mas os LEDs PD0 a PD3 permanecem acesos.

; Definições de pinos e registradores
.equ botao_1 = pb0         ; Botão PB0
.equ botao_2 = pb1         ; Botão PB1
.equ botao_3 = pb2         ; Botão PB2

; Definição dos LEDs
.equ led_0 = pd0           ; LED PD0
.equ led_1 = pd1           ; LED PD1
.equ led_2 = pd2           ; LED PD2
.equ led_3 = pd3           ; LED PD3
.equ led_4 = pd4           ; LED PD4
.equ led_5 = pd5           ; LED PD5
.equ led_6 = pd6           ; LED PD6
.equ led_7 = pd7           ; LED PD7

.def aux = r16             ; Registrador auxiliar

; Laço de setup
setup:
    ; Configura PB0, PB1 e PB2 como entradas (botões)
    ldi aux, 0b00000111     ; Configura PB0, PB1 e PB2 como entrada
    out DDRB, aux

    ; Configura PD0 a PD7 como saída (LEDs)
    ldi aux, 0b11111111     ; Configura todos os pinos do PORTD como saída
    out DDRD, aux

    ; Habilita pull-up para os botões
    ldi aux, 0b00000111     ; Ativa pull-up para PB0, PB1 e PB2
    out PORTB, aux

    rjmp loop               ; Vai para o laço principal

; Laço principal
loop:
    ; Verifica o estado dos botões
    in aux, PINB            ; Lê o estado dos botões

    ; Se PB0 for pressionado (PB0 em nível baixo)
    sbic PINB, botao_1      ; Se PB0 não for pressionado, vai para próxima instrução
    rjmp acende_todos_leds   ; Se PB0 for pressionado, liga todos os LEDs

    ; Se PB1 for pressionado (PB1 em nível baixo)
    sbic PINB, botao_2      ; Se PB1 não for pressionado, vai para próxima instrução
    rjmp apaga_menos_significativos

    ; Se PB2 for pressionado (PB2 em nível baixo)
    sbic PINB, botao_3      ; Se PB2 não for pressionado, vai para próxima instrução
    rjmp apaga_mais_significativos

    rjmp loop               ; Repete o loop

; Sub-rotina para acender todos os LEDs
acende_todos_leds:
    cbi PORTD, led_0        ; Liga o LED PD0
    cbi PORTD, led_1        ; Liga o LED PD1
    cbi PORTD, led_2        ; Liga o LED PD2
    cbi PORTD, led_3        ; Liga o LED PD3
    cbi PORTD, led_4        ; Liga o LED PD4
    cbi PORTD, led_5        ; Liga o LED PD5
    cbi PORTD, led_6        ; Liga o LED PD6
    cbi PORTD, led_7        ; Liga o LED PD7
    rjmp loop

; Sub-rotina para apagar LEDs menos significativos (PD0 a PD3)
apaga_menos_significativos:
    sbi PORTD, led_0        ; Desliga o LED PD0
    sbi PORTD, led_1        ; Desliga o LED PD1
    sbi PORTD, led_2        ; Desliga o LED PD2
    sbi PORTD, led_3        ; Desliga o LED PD3
    rjmp loop

; Sub-rotina para apagar LEDs mais significativos (PD4 a PD7)
apaga_mais_significativos:
    sbi PORTD, led_4        ; Desliga o LED PD4
    sbi PORTD, led_5        ; Desliga o LED PD5
    sbi PORTD, led_6        ; Desliga o LED PD6
    sbi PORTD, led_7        ; Desliga o LED PD7
    rjmp loop