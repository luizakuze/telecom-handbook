// Código inclui uma sub-rotina de soma de duas variáveis de 32 bits.

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
    ldi r16, 0x0FF ; LSB
    ldi r17, 0x0FF
    ldi r18, 0x0FF
    ldi r19, 0x0FF ; MSB
    
    ldi xl, low(varA)   
    ldi xh, high(varA)  
    
    rcall init_32bits

; Inicializando a variavel B de 32 bits    
init_varB:
    ldi r16, 0x0FF ; LSB
    ldi r17, 0x0FF
    ldi r18, 0x0FF
    ldi r19, 0x0FF ; MSB
    
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
    
    rcall add_32bits
    
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
;SUB-ROTINA DE ADICAO SEM LOOP
; Soma duas variaveis de 32 bits e armazena em uma terceira
; A implementaçao nao utiliza loop, ha repeticoes de codigo
; Parametros:
;   - Registrador X: Ponteiro para a posiçao inicial da primeira variavel.
;   - Registrador Y: Ponteiro para a posicao inicial da segunda variavel.
;   - Registrador Z: Ponteiro para a posicao inicial da terceira variavel.
;------------------------------------------------------------------------
add_32bits:
    ; Salva contexto
    push r16
    push r17
    push r18 
    in r16, SREG
    push r16
 
    
    ; Byte 0 (LSB)
    ld r16, X+         ; Carrega o primeiro byte de varA
    ld r17, Y+         ; Carrega o primeiro byte de varB
    add r16, r17       ; Soma r16 + r17
    st Z+, r16         ; Armazena o resultado no endereço apontado por Z

    ; Byte 1
    ld r16, X+         ; Carrega o segundo byte de varA
    ld r17, Y+         ; Carrega o segundo byte de varB
    adc r16, r17       ; Soma r16 + r17 + carry
    st Z+, r16         ; Armazena o resultado

    ; Byte 2
    ld r16, X+         ; Carrega o terceiro byte de varA
    ld r17, Y+         ; Carrega o terceiro byte de varB
    adc r16, r17       ; Soma r16 + r17 + carry
    st Z+, r16         ; Armazena o resultado

    ; Byte 3 (MSB)
    ld r16, X+         ; Carrega o quarto byte de varA
    ld r17, Y+         ; Carrega o quarto byte de varB
    adc r16, r17       ; Soma r16 + r17 + carry
    st Z+, r16         ; Armazena o resultado

    ; Restaura contexto
    pop r16
    out SREG, r16
    pop r18
    pop r17
    pop r16

    ret
     