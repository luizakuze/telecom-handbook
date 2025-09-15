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
    
start_skip_sequence:
    ldi r16, 0x01         ; Valor inicial da sequência (1)
    ldi r17, 0x05         ; Número de valores úteis a serem armazenados
    ldi r18, 0x03         ; Tamanho do salto (exemplo: pular 3 posições)
    ldi zl, low(vr)       ; Ponteiro para o início do vetor `vr` (parte baixa)
    ldi zh, high(vr)      ; Ponteiro para o início do vetor `vr` (parte alta)
    rcall store_inc_skip  ; Chama a sub-rotina
    rjmp end

end:
    rjmp end

;------------------------------------------------------------------------
; SUB-ROTINA DE SEQUÊNCIA CRESCENTE COM SALTO PERSONALIZÁVEL
; Armazena valores crescentes em memória, pulando posições de forma configurável.
; Parâmetros:
;   - R16: Valor inicial da sequência
;   - R17: Número de valores úteis a serem armazenados
;   - R18: Tamanho do salto (número de posições a serem puladas)
;   - Registrador Z: Ponteiro para o início do vetor
;------------------------------------------------------------------------
store_inc_skip:
    ; Salva o contexto
    push r16
    push r17
    push r18
    in r19, SREG
    push r19

seq_skip_loop:
    st Z+, r16           ; Armazena o valor atual no endereço apontado por Z e incrementa Z
    dec r17              ; Decrementa o contador de valores
    brne skip_increment  ; Verifica se o loop deve continuar
    rjmp skip_end        ; Sai do loop se R17 for zero

skip_increment:
    ; Incrementa o ponteiro Z pelo tamanho do salto
    add zl, r18          ; Adiciona o valor do salto à parte baixa do ponteiro Z
    brcc no_carry        ; Se não houve carry, salta a próxima instrução
    inc zh               ; Incrementa a parte alta do ponteiro Z em caso de carry

no_carry:
    inc r16              ; Incrementa o valor da sequência
    rjmp seq_skip_loop   ; Continua o loop

skip_end:
    ; Restaura o contexto
    pop r19
    out SREG, r19
    pop r18
    pop r17
    pop r16

    ret                  ; Retorna para o programa principal