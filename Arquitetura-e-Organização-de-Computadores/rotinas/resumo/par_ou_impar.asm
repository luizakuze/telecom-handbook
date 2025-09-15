;------------------------------------------------------------------------
; verifica_par_impar
; Verifica se o número em R0 é par ou ímpar.
; Retorna:
;   - R2 = 1 se o número for par
;   - R2 = 0 se o número for ímpar
; Parâmetro:
;   - R0 : Número a ser verificado
;------------------------------------------------------------------------

verifica_par_impar:
    AND R0, #1         ; Realiza uma operação AND com o número e 1
    CMP R0, #0         ; Compara o resultado com 0
    JE PAR             ; Se o resultado for 0 (par), salta para PAR
    MOV R2, #0         ; Caso contrário, é ímpar, coloca 0 em R2
    JMP FIM            ; Salta para o fim

PAR:
    MOV R2, #1         ; Se o número for par, coloca 1 em R2

FIM:
    ; Aqui, o valor de R2 será 1 se o número for par, ou 0 se for ímpar