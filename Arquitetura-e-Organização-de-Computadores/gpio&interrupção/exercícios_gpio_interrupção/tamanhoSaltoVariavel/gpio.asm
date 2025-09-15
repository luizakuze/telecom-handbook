@ O LED corre de PB0 a PB7 e volta, mas agora pula posições de acordo com a escolha do usuário.
@ O botão + (PD2 - INT0) aumenta o tamanho do salto (2 → 3 → 4).
@ O botão - (PD3 - INT1) diminui o tamanho do salto (4 → 3 → 2).

.INCLUDE <m328Pdef.inc>  ; Inclui definições do ATmega328P

; ==========================
; Definições de pinos
; ==========================
.equ BOTAO_AUMENTAR = PD2   ; Botão + (aumenta o tamanho do salto)
.equ BOTAO_DIMINUIR = PD3   ; Botão - (diminui o tamanho do salto)

; ==========================
; Definição de registradores
; ==========================
.def AUX = R16        ; Registrador auxiliar
.def LED_INDEX = R17  ; Índice do LED atual
.def SALTO = R18      ; Define o tamanho do salto do LED
.def DIRECAO = R19    ; 0 = esquerda para direita, 1 = direita para esquerda

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
    ldi SALTO, 2        ; Começa com um salto de 2 LEDs

    rjmp main           ; Pula para o loop principal

; ==========================
; Loop principal (Movimento do LED)
; ==========================
main:
    clr AUX                     ; Limpa o registrador auxiliar
    ldi R20, 1                  ; Inicia com 0b00000001 no R20 (LED no PB0)
    
    mov R21, LED_INDEX          ; Copia LED_INDEX para R21 (contador de shifts)
loop_shift:  
    cpi R21, 0                  
    breq led_setado             
    lsl R20                     
    dec R21                     
    rjmp loop_shift             

led_setado:
    mov AUX, R20                
    out PORTB, AUX              

    ldi R20, 8
    rcall delay                 

    ; Verifica botões para modificar o tamanho do salto
    sbic PIND, BOTAO_AUMENTAR    
    rcall aumentar_salto

    sbic PIND, BOTAO_DIMINUIR    
    rcall diminuir_salto

    tst DIRECAO                  
    breq mover_direita            
    rjmp mover_esquerda           

mover_direita:
    add LED_INDEX, SALTO        
    cpi LED_INDEX, 8
    brlt main                    
    ldi LED_INDEX, 6             
    ldi DIRECAO, 1
    rjmp main

mover_esquerda:
    sub LED_INDEX, SALTO        
    brpl main                    
    clr LED_INDEX                
    clr DIRECAO
    rjmp main

; ==========================
; Rotina para aumentar o tamanho do salto
; ==========================
aumentar_salto:
    cpi SALTO, 4                 ; Se SALTO == 4, não aumenta mais
    breq fim_aumentar
    inc SALTO                    ; Aumenta o tamanho do salto
fim_aumentar:
    ret

; ==========================
; Rotina para diminuir o tamanho do salto
; ==========================
diminuir_salto:
    cpi SALTO, 2                 ; Se SALTO == 2, não diminui mais
    breq fim_diminuir
    dec SALTO                    ; Diminui o tamanho do salto
fim_diminuir:
    ret

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
