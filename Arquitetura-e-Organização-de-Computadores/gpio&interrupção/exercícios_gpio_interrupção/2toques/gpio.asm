@ Um toque → LEDs ligam em efeito onda (PB0 → PB7).
@ Outro toque → LEDs desligam um por um (PB7 → PB0).
@ Dois toques rápidos → LEDs piscam três vezes antes de iniciar o efeito normal.

.INCLUDE <m328Pdef.inc>  ; Inclui definições do ATmega328P

; ==========================
; Definições de pinos
; ==========================
.equ SENSOR_TOQUE = PD2   ; Define o pino PD2 como entrada para o sensor de toque

; ==========================
; Definição de registradores
; ==========================
.def AUX = R16        ; Registrador auxiliar para operações temporárias
.def ESTADO = R17     ; Guarda o estado do sistema (0 = desligado, 1 = ligado)
.def TOQUE_CONT = R18 ; Contador de toques rápidos

; ==========================
; Configuração inicial
; ==========================
setup:
    ldi AUX, 0xFF        ; Define PB0-PB7 como saída para LEDs
    out DDRB, AUX        

    ldi AUX, 0x00        ; Garante que os LEDs iniciam apagados
    out PORTB, AUX       

    cbi DDRD, SENSOR_TOQUE  ; Configura PD2 como entrada (sensor de toque)
    sbi PORTD, SENSOR_TOQUE ; Ativa pull-up interno no sensor

    clr ESTADO           ; Inicializa o estado do sistema como "desligado"
    clr TOQUE_CONT       ; Zera o contador de toques rápidos

    rjmp main            ; Vai para o loop principal

; ==========================
; Loop principal
; ==========================
main:
    sbic PIND, SENSOR_TOQUE   ; Se o sensor não for pressionado, pula a próxima instrução
    rcall tratar_toque        ; Se pressionado, chama a rotina para processar o toque

    tst ESTADO
    breq desligar_leds        ; Se ESTADO = 0, chama a rotina para desligar LEDs

    ; Se ESTADO = 1, inicia o efeito "onda" (acender LEDs um a um)
    ldi AUX, 0b00000001       ; Começa com o primeiro LED aceso
onda:
    out PORTB, AUX            ; Atualiza LEDs

    ldi R20, 10               ; Define tempo de espera
    rcall delay               ; Aguarda um tempo para efeito

    lsl AUX                   ; Desloca bit para a esquerda (acendendo o próximo LED)
    cpi AUX, 0b00000000       ; Se todos os LEDs já acenderam, reinicia
    breq main                 
    rjmp onda                 ; Continua o efeito onda

; ==========================
; Rotina para desligar LEDs um por um
; ==========================
desligar_leds:
    ldi AUX, 0b10000000       ; Começa desligando do último LED (PB7)
desligando:
    out PORTB, AUX            ; Atualiza LEDs

    ldi R20, 10
    rcall delay               ; Aguarda um tempo antes de apagar o próximo LED

    lsr AUX                   ; Move o LED aceso para a direita
    cpi AUX, 0b00000000       ; Se todos os LEDs apagaram, volta ao loop principal
    breq apagar_tudo
    rjmp desligando           

apagar_tudo:
    clr AUX                   ; Garante que todos os LEDs estão apagados
    out PORTB, AUX
    rjmp main                 ; Retorna ao loop principal

; ==========================
; Rotina para processar toque
; ==========================
tratar_toque:
    inc TOQUE_CONT            ; Incrementa contador de toques rápidos
    cpi TOQUE_CONT, 2
    brne mudar_estado         ; Se não for o segundo toque rápido, muda estado normalmente

    ; Se houver dois toques rápidos, pisca LEDs 3 vezes
    ldi R19, 3
flash:
    ldi AUX, 0xFF
    out PORTB, AUX            ; Acende todos os LEDs
    ldi R20, 15
    rcall delay

    ldi AUX, 0x00
    out PORTB, AUX            ; Apaga todos os LEDs
    ldi R20, 15
    rcall delay

    dec R19
    brne flash

    clr TOQUE_CONT
    clr ESTADO
    rjmp main

mudar_estado:
    tst ESTADO                ; Verifica se ESTADO é 0 ou 1
    brne desliga_sistema      ; Se for diferente de 0, desliga

    ldi ESTADO, 1             ; Define ESTADO como "ligado"
    rjmp main                 

desliga_sistema:
    clr ESTADO                ; Define ESTADO como "desligado"
    rjmp main                 

; ==========================
; Rotina de atraso (delay)
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
