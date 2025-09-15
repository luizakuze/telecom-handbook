// Código inclui uma sub-rotina de zera uma variável 32 bits.


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
 
; Zerando variável A 
zera_A:
    ldi xl, low(varA)   
    ldi xh, high(varA)  
    
    rcall zera_32bits
    
    
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
;SUB-ROTINA DE INICIALIZAÇAO ZERO
; Inicializa uma variavel de 32 bits com zero 
; Parametros: 
;   - Registrador X: Ponteiro para a posiçao
;------------------------------------------------------------------------    
zera_32bits:
    push r16
    in r1, SREG
    push r1      
    
    ; Deixa o registrador r0 com 0x00
    ldi r16, 0x00
    
    ; Salva r0 (zero) na variavel de 32 bits
    st X+, r0         
    st X+, r0          
    st X+, r0          
    st X, r0   
    
    ; Restaura contexto 
    pop r1
    out SREG, r1
    pop r16
    ret
    