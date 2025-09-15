// O programa é uma estrutura básica de utilização de pilha.
// - Declara uma variável de 32 bits.
// - Chama a sub-rotina "init_32bits"
// - Salva o contexto da sub-rotina
// - Restaura o contexto da sub-rotina

.INCLUDE <m328Pdef.inc>

.DSEG
varA: .BYTE 4          ; Variável de 32 bits
 
.CSEG
start: 
    rcall init_32bits
 
    rjmp start

init_32bits:
    ; Salva contexto
    push r16
    push r17
    push r18
    push r19
    push r20
    in r16, SREG
    push r16

 
sum_loop:
    ; faz alguma coisa...
    
    
    ; Restaura contexto
    pop r16
    out SREG, r16
    pop r20
    pop r19
    pop r18
    pop r17
    pop r16

    ret             ; Retorna