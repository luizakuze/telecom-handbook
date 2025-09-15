 
.INCLUDE <m328Pdef.inc>  ; Inclui o arquivo de definição para o ATmega328P

start:
    sbi DDRB, PB5         ; Configura o pino PB5 (PORTB5) como saída

main:
    sbi PORTB, PB5        ; Define PB5 como nível alto (5V), ligando um LED, por exemplo

    ; Configura um atraso de aproximadamente 200ms
    ldi R19, 16           ; Carrega o valor 16 em R19 (parâmetro da rotina de atraso)
    rcall delay           ; Chama a sub-rotina de atraso

    cbi PORTB, PB5        ; Define PB5 como nível baixo (0V), desligando o LED

    ; Configura um atraso de aproximadamente 200ms
    ldi R19, 16           ; Carrega o valor 16 em R19 novamente
    rcall delay           ; Chama a sub-rotina de atraso

    rjmp main             ; Retorna ao início do loop principal para repetir o processo

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
 