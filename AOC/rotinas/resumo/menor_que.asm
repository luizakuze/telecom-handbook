;------------------------------------------------------------------------
; verifica_menor_que
; Verifica se o valor em R0 é menor que o valor em R1.
; Retorna:
;   - R2 = 1 se R0 < R1 (verdadeiro)
;   - R2 = 0 se R0 >= R1 (falso)
; Parâmetros:
;   - R0 : Primeiro valor a ser comparado
;   - R1 : Segundo valor a ser comparado
;------------------------------------------------------------------------

verifica_menor_que:
    CMP R0, R1        ; Compara R0 com R1
    JL MENOR_QUE      ; Se R0 < R1, salta para MENOR_QUE
    MOV R2, #0        ; Caso R0 >= R1, coloca 0 em R2 (falso)
    JMP FIM           ; Salta para o fim

MENOR_QUE:
    MOV R2, #1        ; Caso R0 < R1, coloca 1 em R2 (verdadeiro)

FIM:
    ; Aqui, o valor de R2 será 1 se R0 < R1, ou 0 se R0 >= R1