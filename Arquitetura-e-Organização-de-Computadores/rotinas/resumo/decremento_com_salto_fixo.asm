// O programa tem uma sub-rotina que incrementa a partir de um valor até outro com uma posição vazia entre cada valor. 

.INCLUDE <m328Pdef.inc>

.DSEG
varA: .BYTE 4         ; Variáveis de 32 bits
varB: .BYTE 4  
varC: .BYTE 4  
    
v0: .BYTE 10	      ; 0x010C-0x0115
v1: .BYTE 10	      ; 0x0116-0x011F
vr: .BYTE 10	      ; 0x0120-0x0129
.CSEG
    
    

start_skip_sequence:
    ldi r16, 0x01          ; Valor inicial da sequência (1)
    ldi r17, 0x05          ; Número de valores a serem armazenados (5 valores úteis)
    ldi xl, low(vr)        ; Ponteiro para o início do vetor `vr`
    ldi xh, high(vr)       
    rcall store_inc_skip   ; Chama a sub-rotina
// "Finalizando"
end:
    rjmp end
;------------------------------------------------------------------------
; SUB-ROTINA DE SEQUÊNCIA CRESCENTE COM SALTO NA MEMÓRIA
; Gera uma sequência crescente e armazena os valores em memória,
; pulando uma posição (armazena uma sim, uma não).
; Parâmetros:
;   - R16: Valor inicial da sequência
;   - R17: Número de valores úteis a serem armazenados
;   - Registrador X: Ponteiro para a posição inicial da sequência
;------------------------------------------------------------------------
store_inc_skip:
    ; Salva o contexto
    push r16
    push r17
    push r18
    in r18, SREG
    push r18

    ; Loop para gerar a sequência
    seq_skip_loop:
        st X, r16          ; Armazena o valor atual no endereço apontado por X
        inc r16            ; Incrementa o valor de R16 (sequência crescente)
        adiw xl, 0x02      ; Incrementa o ponteiro X em 2 (pula uma posição)
        dec r17            ; Decrementa o contador de valores
        brne seq_skip_loop ; Continua o loop enquanto R17 não for zero

    ; Restaura o contexto
    pop r18
    out SREG, r18
    pop r18
    pop r17
    pop r16

    ret                   ; Retorna para o programa principalprograma principal