.INCLUDE <m328Pdef.inc>  ; Inclui definições do ATmega328P

; ==========================
; Definições de pinos
; ==========================
.equ SENSOR_TOQUE = PD2   ; Define PD2 para sensor de toque

; ==========================
; Definição de registradores
; ==========================
.def AUX = R16        ; Registrador auxiliar
.def ESTADO = R17     ; Estado do sistema (0 = desligado, 1 = ligado)

; ==========================
; Configuração inicial
; ==========================
setup:
    ldi AUX, 0xFF        ; Configura PB0-PB7 como saída
    out DDRB, AUX        

    ldi AUX, 0x00        ; Apaga todos os LEDs
    out PORTB, AUX       

    cbi DDRD, SENSOR_TOQUE  ; Configura PD2 como entrada
    sbi PORTD, SENSOR_TOQUE ; Ativa pull-up interno

    ; Configura interrupção externa INT0
    ldi AUX, 0b00000010   
    sts EICRA, AUX        ; Configura interrupção para detectar borda de descida
    sbi EIMSK, INT0       ; Habilita interrupção INT0

    sei                   ; Habilita interrupções globais

    clr ESTADO            ; Inicializa estado como "desligado"

    rjmp main             ; Vai para o loop principal

; ==========================
; Loop principal
; ==========================
main:
    tst ESTADO
    breq desligar_leds

    ; Efeito onda
    ldi AUX, 0b00000001
onda:
    out PORTB, AUX        
    ldi R20, 10
    rcall delay

    lsl AUX               
    cpi AUX, 0b00000000   
    breq main             
    rjmp onda             

desligar_leds:
    ldi AUX, 0b10000000
desligando:
    out PORTB, AUX
    ldi R20, 10
    rcall delay

    lsr AUX               
    cpi AUX, 0b00000000   
    breq apagar_tudo
    rjmp desligando       

apagar_tudo:
    clr AUX
    out PORTB, AUX
    rjmp main             

; ==========================
; Interrupção do sensor
; ==========================
isr_sensor:
    push R16
    in R16, SREG
    push R16

    tst ESTADO
    brne desligar

    ldi ESTADO, 1
    rjmp isr_done

desligar:
    clr ESTADO

isr_done:
    pop R16
    out SREG, R16
    pop R16
    reti
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