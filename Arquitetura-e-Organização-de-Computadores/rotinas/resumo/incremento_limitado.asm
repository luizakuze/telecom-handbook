// O programa tem uma sub-rotina que incrementa a partir de um valor até outro em diferentes posições de memória.

.INCLUDE <m328Pdef.inc>

.DSEG
varA: .BYTE 4         ; Variáveis de 32 bits
varB: .BYTE 4  
varC: .BYTE 4  
    
v0: .BYTE 10	      ; 0x010C-0x0115
v1: .BYTE 10	      ; 0x0116-0x011F
vr: .BYTE 10	      ; 0x0120-0x0129
.CSEG
    
    

start_inc_sequence:
    ldi r16, 0x01          ; Valor inicial da sequência (1)
    ldi r17, 0x05          ; Número de valores (5)
    ldi xl, low(vr)        ; Ponteiro para o início do vetor `vr`
    ldi xh, high(vr)       
    rcall store_inc_sequence ; Chama a sub-rotina
 
// "Finalizando"
end:
    rjmp end
    
;------------------------------------------------------------------------
; SUB-ROTINA DE SEQUÊNCIA CRESCENTE
; Gera uma sequência de números crescentes a partir de um valor inicial
; e armazena no espaço de memória apontado por X.
; Parâmetros:
;   - R16: Valor inicial da sequência (incrementa a partir deste valor)
;   - R17: Número de valores a serem armazenados na sequência
;   - Registrador X: Ponteiro para a posição inicial da sequência.
;------------------------------------------------------------------------
store_inc_sequence:
    ; Salva o contexto
    push r16
    push r17
    push r18
    in r18, SREG
    push r18

    ; Loop para armazenar os valores
    seq_loop:
        st X+, r16         ; Armazena o valor atual no endereço apontado por X
        inc r16            ; Incrementa o valor de R16
        dec r17            ; Decrementa o contador
        brne seq_loop      ; Continua o loop enquanto R17 não for zero

    ; Restaura o contexto
    pop r18
    out SREG, r18
    pop r18
    pop r17
    pop r16

    ret                   ; Retorna para o programa principal