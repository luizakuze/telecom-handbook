// O programa utiliza endereçamento com pré-decremento para armazenar uma sequência de números crescentes em um vetor.

.INCLUDE <m328Pdef.inc>

.DSEG
varA: .BYTE 4         ; Variáveis de 32 bits
varB: .BYTE 4  
varC: .BYTE 4  
    
v0: .BYTE 10	      ; 0x010C-0x0115
v1: .BYTE 10	      ; 0x0116-0x011F
vr: .BYTE 10	      ; 0x0120-0x0129
.CSEG
    
 start_reverse_sequence:
    ldi r16, 0x01          ; Valor inicial da sequência (1)
    ldi r17, 0x05          ; Número de valores a serem armazenados (5)
    ldi xl, low(vr + 10)   ; Ponteiro para a última posição do vetor `vr`
    ldi xh, high(vr + 10)  
    rcall store_reverse    ; Chama a sub-rotina
    rjmp end
 
 
// "Finalizando"
end:
    rjmp end
 
;------------------------------------------------------------------------
; SUB-ROTINA DE ARMAZENAMENTO DE TRÁS PARA FRENTE
; Armazena uma sequência de valores positivos de trás para frente,
; decrementando o ponteiro antes de cada operação de armazenamento.
; Parâmetros:
;   - R16: Valor inicial da sequência
;   - R17: Número de valores a serem armazenados
;   - Registrador X: Ponteiro para a última posição do vetor
;------------------------------------------------------------------------
store_reverse:
    ; Salva o contexto
    push r16
    push r17
    push r18
    in r18, SREG
    push r18

    ; Loop para armazenar os valores
    reverse_loop:
        st -X, r16         ; Decrementa o ponteiro e armazena o valor em memória
        inc r16            ; Incrementa o valor da sequência
        dec r17            ; Decrementa o contador de valores
        brne reverse_loop  ; Continua o loop enquanto R17 não for zero

    ; Restaura o contexto
    pop r18
    out SREG, r18
    pop r18
    pop r17
    pop r16

    ret                   ; Retorna para o programa principal