// Código inclui uma sub-rotina que armazena multiplicações nas próximas posições de memória até limitado valor.

.INCLUDE <m328Pdef.inc>

.DSEG
varA: .BYTE 4         ; Variáveis de 32 bits
varB: .BYTE 4  
varC: .BYTE 4  
    
v0: .BYTE 10	      ; 0x010C-0x0115
v1: .BYTE 10	      ; 0x0116-0x011F
vr: .BYTE 10	      ; 0x0120-0x0129
.CSEG
    
start_mul_sequence:
    ldi r16, 0x01          ; Valor inicial da sequência (1)
    ldi r17, 0x02          ; Fator de multiplicação (2)
    ldi r18, 0x05          ; Número de valores (5)
    ldi xl, low(vr)        ; Ponteiro para o início do vetor `vr`
    ldi xh, high(vr)       
    rcall store_mul_sequence ; Chama a sub-rotina
    rjmp end
 
// "Finalizando"
end:
    rjmp end
    
;------------------------------------------------------------------------
; SUB-ROTINA DE SEQUÊNCIA CRESCENTE COM MULTIPLICAÇÃO
; Gera uma sequência de números crescentes, multiplicando o valor inicial
; por um fator em cada iteração, e armazena no espaço de memória apontado por X.
; Parâmetros:
;   - R16: Valor inicial da sequência
;   - R17: Fator de multiplicação
;   - R18: Número de valores a serem armazenados
;   - Registrador X: Ponteiro para a posição inicial da sequência
;------------------------------------------------------------------------
store_mul_sequence:
    ; Salva o contexto
    push r16
    push r17
    push r18
    push r19
    in r19, SREG
    push r19

    ; Loop para gerar e armazenar a sequência
    seq_mul_loop:
        st X+, r16         ; Armazena o valor atual no endereço apontado por X
        
        mov r19, r16       ; Copia o valor atual para r19
        mul r19, r17       ; Multiplica o valor atual pelo fator (R17)
        mov r16, r0        ; Armazena o resultado (parte baixa do produto) em R16

        dec r18            ; Decrementa o contador de valores
        brne seq_mul_loop  ; Continua o loop enquanto R18 não for zero

    ; Restaura o contexto
    pop r19
    out SREG, r19
    pop r19
    pop r18
    pop r17
    pop r16

    ret                   ; Retorna para o programa principal