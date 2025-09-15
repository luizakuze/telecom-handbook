// Código inclui uma sub-rotina de subtração de duas variáveis de 32 bits.

.INCLUDE <m328Pdef.inc>

.DSEG
varA: .BYTE 4         ; Variáveis de 32 bits
varB: .BYTE 4  
varC: .BYTE 4  
    
v0: .BYTE 10	      ; 0x010C-0x0115
v1: .BYTE 10	      ; 0x0116-0x011F
vr: .BYTE 10	      ; 0x0120-0x0129
.CSEG
    
    
start:
    
;Inicializando a variavel A de 32 bits    
init_varA:     
    ldi r16, 0x02 ; LSB
    ldi r17, 0x02
    ldi r18, 0x02
    ldi r19, 0x02 ; MSB
    
    ldi xl, low(varA)   
    ldi xh, high(varA)  
    
    rcall init_32bits

; Inicializando a variavel B de 32 bits    
init_varB:
    ldi r16, 0x03 ; LSB
    ldi r17, 0x03
    ldi r18, 0x03
    ldi r19, 0x03 ; MSB
    
    ldi xl, low(varB)   
    ldi xh, high(varB)  
    
    rcall init_32bits

; Inicializando sub-rotina de subtracao: A-B=C
init_sub_AB:
    ldi xl, low(varA)   
    ldi xh, high(varA)  
    ldi yl, low(varB)    
    ldi yh, high(varB) 
    ldi zl, low(varC)   
    ldi zh, high(varC)  
    
    rcall sub_32bits
    
    rjmp end

; "Finalizando" o programa
end:
    rjmp end
    
;------------------------------------------------------------------------
; SUB-ROTINA DE INICIALIZAÇÃO
; Inicializa uma variável de 32 bits
; Parâmetros:
;   - R16, R17, R18, e R19: Valor que deve ser utilizado na inicialização
;   - Registrador X: Ponteiro para a posição
;------------------------------------------------------------------------
init_32bits:
    ; Armazena na SRAM o endereço apontado por X que está no registrador
    st X+, r16         ; Armazena o byte menos significativo
    st X+, r17         ; Armazena o próximo byte
    st X+, r18         ; Armazena o próximo byte
    st X+, r19          ; Armazena o byte mais significativo (sem incrementar o ponteiro)

    ret                ; Retorna para o programa principal
    
;------------------------------------------------------------------------
;SUB-ROTINA DE SUBTRACAO COM LOOP
; Subtrai duas variáveis de 32 bits e armazena em uma terceira
; A implementação utiliza um loop
; Parâmetros:
;   - Registrador X: Ponteiro para a posição inicial da primeira variável.
;   - Registrador Y: Ponteiro para a posição inicial da segunda variável.
;   - Registrador Z: Ponteiro para a posição inicial da terceira variável.
;------------------------------------------------------------------------
sub_32bits:
    ; Salva contexto
    push r16
    push r17
    push r18
    in r0, SREG
    push r0

    ; Inicializa o contador e garante carry zerado
    ldi r16, 4         ; Número de bytes (4 para 32 bits)
    clr r18            ; Garante que o carry inicial está zerado

loop_sub:
    ld r17, X+         ; Carrega o próximo byte de varA
    ld r18, Y+         ; Carrega o próximo byte de varB
    sbc r17, r18       ; Subtrai r18 de r17 (carry é automaticamente tratado)
    st Z+, r17         ; Armazena o resultado no endereço apontado por Z

    dec r16            ; Decrementa o contador de bytes
    brne loop_sub      ; Continua o loop enquanto ainda houver bytes

    ; Restaura contexto 
    pop r0
    out SREG, r0
    pop r18
    pop r17
    pop r16

    ret
