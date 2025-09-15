// Depois que um botão é pressionado, um LED pisca 5 vezes a cada 1s e para.

.INCLUDE <m328Pdef.inc>   

start:
    sbi DDRB, PB7         ; Configura PB7 como saída (LED1)
    cbi PORTB, PB7        ; Garante que o LED inicie desligado
    
    cbi DDRB, PB3         ; Configura PB3 como entrada (Botão)
    sbi PORTB, PB3        ; Ativa pull-up interno no PB3

    clr r16               ; Inicializa contador = 0

loop_5x:
    sbis PINB, PB3        ; Verifica se o botão está pressionado (nível baixo)
    rjmp loop_5x          ; Se não estiver pressionado, continua verificando

    sbi PORTB, PB7        ; Liga LED
    ldi R19, 40
    rcall delay           ; Espera 500ms

    cbi PORTB, PB7        ; Desliga LED
    ldi R19, 40
    rcall delay           ; Espera 500ms

    inc r16               ; Incrementa contador
    cpi r16, 5            ; Verifica se contador == 5
    brne loop_5x             ; Se não for 5, volta ao loop principal

    clr r16               ; Se chegou a 5, reseta contador
    rjmp loop_5x             ; Volta ao loop principal

 
;--------------------------------------------------------------------------------
; SUB-ROTINA DE ATRASO Programável
; 
; Essa sub-rotina gera um atraso proporcional ao valor carregado em R19.
; Exemplo:
;   - R19 = 16 --> Atraso de ~200ms
;   - R19 = 80 --> Atraso de ~1s
; 
;--------------------------------------------------------------------------------
delay:
    push r17              ; Salva o valor original de R17 na pilha
    push r18              ; Salva o valor original de R18 na pilha
    in r17, SREG          ; Salva o registrador de status (SREG) para restaurá-lo depois
    push r17

    clr r17               ; Zera R17 (contador interno do loop)
    clr r18               ; Zera R18 (contador interno do loop)

loop:
    dec R17               ; Decrementa R17
    brne loop             ; Se R17 não for zero, continua no loop
    dec R18               ; Quando R17 chega a zero, decrementa R18
    brne loop             ; Se R18 não for zero, continua no loop
    dec R19               ; Quando R18 chega a zero, decrementa R19
    brne loop             ; Se R19 não for zero, continua no loop

    pop r17               ; Restaura o valor original do SREG
    out SREG, r17
    pop r18               ; Restaura R18
    pop r17               ; Restaura R17

    ret                   ; Retorna à rotina principal
 