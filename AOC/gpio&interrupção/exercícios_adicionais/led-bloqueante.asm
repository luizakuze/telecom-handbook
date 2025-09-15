@ O objetivo é controlar a rotação de um único LED entre os 8 LEDs conectados à porta PB. A direção da rotação depende dos botões PD2 e PD3, onde:

@ Se PD2 for pressionado, a rotação ocorre para a direita.
@ Se PD3 for pressionado, a rotação ocorre para a esquerda.
@ A rotação do LED será bloqueante e ocorrerá a cada 1 segundo, utilizando uma sub-rotina de delay. Vamos ver as duas versões:
//


@ Versão a) Sem Interrupção Externa:

@ O programa verifica continuamente o estado dos botões e, dependendo do botão pressionado, rotaciona os LEDs para a direita ou para a esquerda.
@ O delay é utilizado para criar um intervalo de 1 segundo entre cada rotação.
@ Versão b) Com Interrupção Externa:

@ O programa agora usa interrupções externas para detectar os pressionamentos dos botões PD2 e PD3.
@ As interrupções INT0 e INT1 são configuradas para capturar os eventos de pressionamento dos botões, alternando os LEDs para a direita ou para a esquerda com base nos botões pressionados.


//Versão a) Sem Interrupção Externa
.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO_DIREITA = PD2    ; Botão para rotação para a direita (PD2)
.equ BOTAO_ESQUERDA = PD3   ; Botão para rotação para a esquerda (PD3)
.equ LED0 = PB0              ; LED 0 no pino PB0
.equ LED1 = PB1              ; LED 1 no pino PB1
.equ LED2 = PB2              ; LED 2 no pino PB2
.equ LED3 = PB3              ; LED 3 no pino PB3
.equ LED4 = PB4              ; LED 4 no pino PB4
.equ LED5 = PB5              ; LED 5 no pino PB5
.equ LED6 = PB6              ; LED 6 no pino PB6
.equ LED7 = PB7              ; LED 7 no pino PB7

.def AUX = R16               ; Registrador auxiliar
.def LED_POS = R17           ; Registrador para controlar a posição do LED

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0xFF            ; Configura PB0-PB7 como saída para LEDs
    out DDRB, AUX
    ldi AUX, 0x00            ; Desliga todos os LEDs inicialmente
    out PORTB, AUX

    cbi DDRD, BOTAO_DIREITA  ; Configura o botão direita como entrada
    cbi DDRD, BOTAO_ESQUERDA ; Configura o botão esquerda como entrada
    sbi PORTD, BOTAO_DIREITA ; Ativa pull-up no pino do botão direita
    sbi PORTD, BOTAO_ESQUERDA; Ativa pull-up no pino do botão esquerda

    ldi LED_POS, 0           ; Inicializa a posição do LED (começa no LED0)

    rjmp main                ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    ; Acende o LED atual
    out PORTB, (1 << LED_POS)
    
    ; Verifica se o botão da direita foi pressionado
    sbis PIND, BOTAO_DIREITA
    rjmp rotaciona_direita

    ; Verifica se o botão da esquerda foi pressionado
    sbis PIND, BOTAO_ESQUERDA
    rjmp rotaciona_esquerda

    ; Aguarda 1 segundo
    ldi AUX, 100
    rcall delay
    rjmp main

; -------------------------------------------------
; Rotaciona para a direita
; -------------------------------------------------
rotaciona_direita:
    ; Desliga o LED atual
    cbi PORTB, LED_POS
    
    ; Incrementa a posição do LED
    inc LED_POS
    cpi LED_POS, 8           ; Se chegar a 8, volta para 0
    brge reset_pos
    rjmp main

reset_pos:
    ldi LED_POS, 0
    rjmp main

; -------------------------------------------------
; Rotaciona para a esquerda
; -------------------------------------------------
rotaciona_esquerda:
    ; Desliga o LED atual
    cbi PORTB, LED_POS

    ; Decrementa a posição do LED
    dec LED_POS
    brmi pos_7               ; Se a posição for negativa, vai para o LED7
    rjmp main

pos_7:
    ldi LED_POS, 7           ; Caso contrário, vai para o LED7
    rjmp main

; -------------------------------------------------
; Sub-rotina de atraso programável (1 segundo)
; -------------------------------------------------
delay:
    push r17
    push r18

    ldi r17, 200            ; Ajuste de tempo (aproximadamente 1 segundo)
    ldi r18, 100

loop_delay:
    dec r17
    brne loop_delay
    dec r18
    brne loop_delay

    pop r18
    pop r17
    ret


// Versão b) Com Interrupção Externa
.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ BOTAO_DIREITA = PB0    ; Botão direita no pino PB0 (INT0)
.equ BOTAO_ESQUERDA = PB1   ; Botão esquerda no pino PB1 (INT1)
.equ L0 = PD0               ; LED 0 no pino PD0
.equ L1 = PD1               ; LED 1 no pino PD1
.equ L2 = PD2               ; LED 2 no pino PD2
.equ L3 = PD3               ; LED 3 no pino PD3
.equ L4 = PD4               ; LED 4 no pino PD4
.equ L5 = PD5               ; LED 5 no pino PD5
.equ L6 = PD6               ; LED 6 no pino PD6
.equ L7 = PD7               ; LED 7 no pino PD7

.def AUX = R16              ; Registrador auxiliar
.def LED_POS = R17          ; Registrador para controlar a posição do LED

; -------------------------------------------------
; Configuração inicial
; -------------------------------------------------
setup:
    ldi AUX, 0xFF            ; Configura PB0-PB7 como saída para LEDs
    out DDRD, AUX
    ldi AUX, 0x00            ; Desliga todos os LEDs inicialmente
    out PORTD, AUX

    cbi DDRB, BOTAO_DIREITA  ; Configura o botão direita como entrada
    cbi DDRB, BOTAO_ESQUERDA ; Configura o botão esquerda como entrada
    sbi PORTB, BOTAO_DIREITA ; Ativa pull-up no pino do botão direita
    sbi PORTB, BOTAO_ESQUERDA; Ativa pull-up no pino do botão esquerda

    ldi LED_POS, 0           ; Inicializa a posição do LED (começa no LED0)

    ldi AUX, 0x03            ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX
    sbi EIMSK, INT0          ; Habilita interrupção INT0 (BOTÃO DIREITA)
    sbi EIMSK, INT1          ; Habilita interrupção INT1 (BOTÃO ESQUERDA)

    sei                      ; Habilita as interrupções globais

    rjmp main                ; Entra no loop principal

; -------------------------------------------------
; Rotina principal
; -------------------------------------------------
main:
    rjmp main                ; Aguardar interrupções

; -------------------------------------------------
; Rotina de interrupção para o botão DIREITA (INT0)
; -------------------------------------------------
isr_int0:
    push R16                 ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    inc LED_POS              ; Incrementa a posição do LED
    cpi LED_POS, 8           ; Verifica se chegou ao LED7
    brge reset_pos
    rjmp main

reset_pos:
    ldi LED_POS, 0           ; Reseta a posição para LED0
    rjmp main

; -------------------------------------------------
; Rotina de interrupção para o botão ESQUERDA (INT1)
; -------------------------------------------------
isr_int1:
    push R16                 ; Salva o contexto (SREG)
    in R16, SREG
    push R16

    dec LED_POS              ; Decrementa a posição do LED
    brmi pos_7               ; Se for negativo, vai para LED7
    rjmp main

pos_7:
    ldi LED_POS, 7           ; Vai para LED7
    rjmp main

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
    dec R19 
    brne loopdelay 
    
    pop r17
    out SREG, r17

    pop r18 
    pop r17
    
    ret
