@ Quando os dois botões não estão pressionados:
@ Todos os LEDs estão apagados.
@ Quando ambos os botões são pressionados:
@ Todos os LEDs acendem.
@ Se pelo menos um dos botões for solto enquanto o outro estiver pressionado:
@ Os LEDs se apagam novamente.

.INCLUDE <m328Pdef.inc>
    
.equ LED = PD0
.equ LED2 = PD1
.equ LED3 = PD2 
.equ LED4 = PD3
.equ LED5 = PD4
.equ LED6 = PD5
.equ LED7 = PD6
.equ LED8 = PD7
    
.equ BOTAO = PB0 
.equ BOTAO2 = PB1
    
.def AUX = R16 

setup:
    LDI AUX,0b11111111
    
    OUT DDRD, AUX 
    OUT DDRB, AUX
    
    OUT PORTD, AUX
    OUT PORTB, AUX

naoPress: 
    ; Desliga os LED's
    sbi PORTD,LED 
    sbi PORTD,LED2
    sbi PORTD,LED3
    sbi PORTD,LED4
    sbi PORTD,LED5
    sbi PORTD,LED6
    sbi PORTD,LED7
    sbi PORTD,LED8
    
    ; Verifica se ambos os LED's estao pressionados
    sbic PINB,BOTAO 
    rjmp naoPress
    sbic PINB,BOTAO2	
    rjmp naoPress 

press: 
    ; Liga os LED's
    cbi PORTD,LED 
    cbi PORTD,LED2
    cbi PORTD,LED3
    cbi PORTD,LED4
    cbi PORTD,LED5
    cbi PORTD,LED6
    cbi PORTD,LED7
    cbi PORTD,LED8
    
    ; Verifica se os botoes permanecem pressionados
    sbic PINB,BOTAO
    rjmp naoPress
    sbis PINB,BOTAO2
    rjmp press 

    rjmp naoPress 





----------------------------------------------------
MELHORANDOOOOO

.INCLUDE <m328Pdef.inc>

; Definições de pinos
.equ LED_MASK = 0xFF    ; Máscara para os LEDs (PD0 a PD7)
.equ BOTAO = PB0
.equ BOTAO2 = PB1

.def AUX = R16 

setup:
    ; Configura os pinos PD0 a PD7 como saída para LEDs
    LDI AUX, LED_MASK
    OUT DDRD, AUX

    ; Configura PB0 e PB1 como entrada para os botões, com pull-up
    LDI AUX, 0x00
    OUT DDRB, AUX
    LDI AUX, 0x03      ; Ativa pull-up nos pinos PB0 e PB1
    OUT PORTB, AUX

    RJMP naoPress      ; Vai para a rotina principal

naoPress:
    ; Desliga todos os LEDs (PORTD = 0)
    OUT PORTD, R16     ; Como R16 é 0, todos os LEDs serão desligados

    ; Verifica se ambos os botões estão pressionados
    SBIC PINB, BOTAO   ; Se BOTAO não for pressionado, continua em naoPress
    RJMP naoPress
    SBIC PINB, BOTAO2  ; Se BOTAO2 não for pressionado, continua em naoPress
    RJMP naoPress

press:
    ; Liga todos os LEDs (PORTD = 0xFF)
    LDI AUX, LED_MASK  ; Carrega 0xFF em AUX para ligar todos os LEDs
    OUT PORTD, AUX

    ; Verifica se ambos os botões permanecem pressionados
    SBIC PINB, BOTAO   ; Se BOTAO não for pressionado, vai para naoPress
    RJMP naoPress
    SBIS PINB, BOTAO2  ; Se BOTAO2 não for pressionado, vai para press
    RJMP press

    RJMP naoPress      ; Caso contrário, volta para naoPress
