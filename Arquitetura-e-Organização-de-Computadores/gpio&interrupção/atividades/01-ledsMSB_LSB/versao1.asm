@ Considerando o circuito abaixo, faça um fluxograma e um programa com o seguinte comportamento:

@ Os 4 LEDs menos significativos devem apagar quando o botão ajuste estiver pressionado.
@ Os 4 LEDs mais significativos devem apagar quando o botão seleção estiver pressionado.
@ Os 8 LEDs devem ligar quando nenhum botão estiver pressionado.

; nomeia os pinos destinados aos botões
.equ botao_ajuste = pb0  
.equ botao_selecao = pb1
    
; define o registrador r16 com o nome de aux
.def aux = r16 
   
; nomeia os pinos destinados aos leds como "porta"
.equ porta0 = pd0
.equ porta1 = pd1
.equ porta2 = pd2
.equ porta3 = pd3
.equ porta4 = pd4
.equ porta5 = pd5
.equ porta6 = pd6
.equ porta7 = pd7

; laço de setup
setup:
    ; configura botões como entrada
    ldi aux, 0b00000000 
    out ddrb, aux

    ; configura os pinos dos leds como saída
    ldi aux, 0b11111111  ; 0b11111111 para configurar todos os pinos do PORTD como saída
    out ddrd, aux

    ; habilita o pull-up para os botões
    ldi aux, 0b00000011 
    out portb, aux  
 

; laço principal
loop:
    ; verifica se nenhum botão está pressionado (PB0 e PB1 em nível alto)
    in aux, pinb
    cpi aux, 0b00000011 ; se PB0 e PB1 estão em pull-up (1) (nenhum pressionado = 1 do pull up)
    breq liga_todos ; entao liga todos os leds

    ; verifica se o botão ajuste foi pressionado (PB0 em nível baixo)
    sbic pinb, botao_ajuste ; salta se botao ajuste for pressionado
    rjmp apaga_menos_significativos

    ; verifica se o botão seleção foi pressionado (PB1 em nível baixo)
    sbic pinb, botao_selecao ; salta de botao selecao for pressionado
    rjmp apaga_mais_significativos

    rjmp loop

;--------------------------------------------------------------------------------
; SUB-ROTINA LIGA_TODOS
; Liga todos os leds (pd0 a pd7)
;--------------------------------------------------------------------------------
liga_todos:
    cbi portd, porta0
    cbi portd, porta1
    cbi portd, porta2
    cbi portd, porta3
    cbi portd, porta4
    cbi portd, porta5
    cbi portd, porta6
    cbi portd, porta7
    ldi R19, 16 ; Ajusta o atraso (~200ms)
    rcall delay
    rjmp loop

;--------------------------------------------------------------------------------
; SUB-ROTINA APAGA_MENOS_SIGNIFICATIVOS
; Apaga os leds menos significativos (pd0 a pd3)
;--------------------------------------------------------------------------------
apaga_menos_significativos:
    sbi portd, porta0
    sbi portd, porta1
    sbi portd, porta2
    sbi portd, porta3
    ldi R19, 16 ; Ajusta o atraso (~200ms)
    rcall delay
    rjmp loop

;--------------------------------------------------------------------------------
; SUB-ROTINA APAGA_MAIS_SIGNIFICATIVOS
; Apaga os leds mais significativos (pd4 a pd7)
;--------------------------------------------------------------------------------
apaga_mais_significativos:
    sbi portd, porta4
    sbi portd, porta5
    sbi portd, porta6
    sbi portd, porta7
    ldi R19, 16 ; Ajusta o atraso (~200ms)
    rcall delay
    rjmp loop

;--------------------------------------------------------------------------------
; SUB-ROTINA DE ATRASO Programável
; 
; Essa sub-rotina gera um atraso proporcional ao valor carregado em R19.
; Exemplo:
;   - R19 = 16 --> Atraso de ~200ms
;   - R19 = 80 --> Atraso de ~1s
; 
; O tempo real do atraso depende do clock do microcontrolador.
;--------------------------------------------------------------------------------
delay:
    push r17              ; Salva o valor original de R17 na pilha
    push r18              ; Salva o valor original de R18 na pilha
    in r17, SREG          ; Salva o registrador de status (SREG) para restaurá-lo depois
    push r17

    clr r17               ; Zera R17 (contador interno do loop)
    clr r18               ; Zera r18 (contador interno do loop)

loop_delay:
    dec R17               ; Decrementa R17
    brne loop_delay       ; Se R17 não for zero, continua no loop
    dec R18               ; Quando R17 chega a zero, decrementa R18
    brne loop_delay       ; Se R18 não for zero, continua no loop
    dec R19               ; Quando R18 chega a zero, decrementa R19
    brne loop_delay       ; Se R19 não for zero, continua no loop

    pop r17               ; Restaura o valor original do SREG
    out SREG, r17
    pop r18               ; Restaura r18
    pop r17               ; Restaura r17

    ret                   ; Retorna à rotina principal
