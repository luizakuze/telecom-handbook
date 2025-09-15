;------------------------------------------------------------------------
; Parte 1 – Crie as seguintes sub-rotinas:
;------------------------------------------------------------------------

;------------------------------------------------------------------------
; init_32bits
; Inicializa ugma variável de 32 bits apontada por X com os valores passados em R16, R17, R18 e R19
; Parâmetros:
;   - R16, R17, R18, R19 : Valor que deve ser utilizado na inicialização. 
;     Sendo o R16 o byte menos significativo e o R19 o mais.
;   - Registrador X: Ponteiro para a posição inicial da variável. 
;     Considere o byte menos significativo armazenado no menor endereço.
;------------------------------------------------------------------------

;------------------------------------------------------------------------
; zera_32bits
; Inicializa uma variável de 32 bits com zero.
; Parâmetros:
;   - Registrador X : Ponteiro para a posição inicial da variável.
;------------------------------------------------------------------------

;------------------------------------------------------------------------
; sub_32bits
; Subtrai duas variáveis de 32 bits e guarda em uma terceira variável.
; Parâmetros:
;   - Registrador X : Ponteiro para a posição inicial da primeira variável.
;   - Registrador Y : Ponteiro para a posição inicial da segunda variável, 
;     a qual será subtraída da primeira.
;   - Registrador Z : Ponteiro para a posição inicial da terceira variável.
; Observações:
;   - Salve o contexto adequadamente.
;   - Utilize modos de endereçamento adequados para cada caso e laços de repetição, se for o caso.
;------------------------------------------------------------------------


.INCLUDE <m328Pdef.inc>

.DSEG
varA: .BYTE 4         ; Variáveis de 32 bits
varB: .BYTE 4  
varC: .BYTE 4  
    
v0: .BYTE 10	      ; 0x010C-0x0115
v1: .BYTE 10	      ; 0x0116-0x011F
vr: .BYTE 10	      ; 0x0120-0x0129
.CSEG
    
// LDI: Loads an 8-bit constant directly to register 16 to 31.    
    
    
start: 
   
 ////////////////////////////// / PARTE 1 SUB-ROTINAS ///////////////////
    ; Carregar valores nos registradores para teste da sub-rotina init_32bits
    ldi r16, 0x01 ; LSB
    ldi r17, 0x01
    ldi r18, 0x01
    ldi r19, 0x01 ; MSB
    
    ; Ponteiro X aponta para varA
    ldi xl, low(varA)    
    ldi xh, high(varA)   
    
    rcall init_32bits  ; Chama a sub-rotina para inicializar a variável
    
    ///////////////////// PARTE 2
    ; Ponteiro X aponta para varA
    ldi xl, low(varA)    
    ldi xh, high(varA)   
    
    
    rcall zera_32bits  ; Chama a sub-rotina para zerar a variável
    
    ///////////////////// PARTE 3
    ; Carregar valores nos registradores para teste da sub-rotina sub_32bits
    ; Ponteiro X aponta para varA
    ldi xl, low(varA)   
    ldi xh, high(varA)  
    
    rcall init_32bits ; inicializando primeira variavel com tudo 1
    
    
    ; Ponteiro X aponta para varA
    ldi xl, low(varB)   
    ldi xh, high(varB)  
    
    ldi r16, 0x02 ; LSB
    ldi r17, 0x02
    ldi r18, 0x02
    ldi r19, 0x02 ; MSB
    
    
    rcall init_32bits ; inicializando segunda variavel com tudo 2
    
    ; Ponteiro X aponta para varA
    ldi xl, low(varA)   
    ldi xh, high(varA)  
    ; Ponteiro Y aponta para varB
    ldi yl, low(varB)    
    ldi yh, high(varB) 
    ; Ponteiro Z aponta para varC
    ldi zl, low(varC)   
    ldi zh, high(varC)  
    
    rcall sub_32bits_loop
    

rjmp end
 
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
    
;------------------------------------------------------------------------
;SUB-ROTINA DE SUBTRACAO COM LOOP
; Subtrai duas variáveis de 32 bits e armazena em uma terceira
; A implementação utiliza um loop
; Parâmetros:
;   - Registrador X: Ponteiro para a posição inicial da primeira variável.
;   - Registrador Y: Ponteiro para a posição inicial da segunda variável.
;   - Registrador Z: Ponteiro para a posição inicial da terceira variável.
;------------------------------------------------------------------------
sub_32bits_loop:
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

    
;------------------------------------------------------------------------
;SUB-ROTINA DE ADICAO COM LOOP
; Soma duas variaveis de 32 bits e armazena em uma terceira
; A implementaçao utiliza um loop
; Parametros:
;   - Registrador X: Ponteiro para a posiçao inicial da primeira variavel.
;   - Registrador Y: Ponteiro para a posicao inicial da segunda variavel.
;   - Registrador Z: Ponteiro para a posicao inicial da terceira variavel.
;------------------------------------------------------------------------
add_32bits_loop:
    ; Salva contexto
    push r16
    push r17
    push r18
    push r0
    in r0, SREG
    push r0
 
    
    ; Inicializa o contador e garante carry zerado
    ldi r16, 4         ; Número de bytes (4 para 32 bits)
    clr r18            ; Garante que o carry inicial está zerado (adc usa este valor)

loop_add:
    ld r17, X+         ; Carrega o próximo byte de varA
    ld r18, Y+         ; Carrega o próximo byte de varB
    adc r17, r18       ; Soma r17 + r18 + carry
    st Z+, r17         ; Armazena o resultado no endereço apontado por Z

    dec r16            ; Decrementa o contador de bytes
    brne loop_add      ; Continua o loop enquanto ainda houver bytes

    ; Restaura contexto
    pop r0
    out SREG, r0
    pop r18
    pop r17
    pop r16

    ret
    
;------------------------------------------------------------------------
;SUB-ROTINA DE ADICAO SEM LOOP
; Soma duas variaveis de 32 bits e armazena em uma terceira
; A implementaçao nao utiliza loop, ha repeticoes de codigo
; Parametros:
;   - Registrador X: Ponteiro para a posiçao inicial da primeira variavel.
;   - Registrador Y: Ponteiro para a posicao inicial da segunda variavel.
;   - Registrador Z: Ponteiro para a posicao inicial da terceira variavel.
;------------------------------------------------------------------------
add_32bits_simples:
    ; Salva contexto
    push r16
    push r17
    push r18
    push r0
    in r0, SREG
    push r0
 
    
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
    pop r0
    out SREG, r0
    pop r18
    pop r17
    pop r16

    ret
    
    
;------------------------------------------------------------------------
;SUB-ROTINA DE SUBTRACAO SEM LOOP
; Subtrai duas variaveis de 32 bits e armazena em uma terceira
; A implementaçao nao utiliza loop, ha repeticoes de codigo
; Parametros:
;   - Registrador X: Ponteiro para a posiçao inicial da primeira variavel.
;   - Registrador Y: Ponteiro para a posicao inicial da segunda variavel.
;   - Registrador Z: Ponteiro para a posicao inicial da terceira variavel.
;------------------------------------------------------------------------
sub_32bits_simples:
    ; Salva contexto
    push r16
    push r17
    push r18
    push r0
    in r0, SREG
    push r0
 
    
    ; Byte 0 (LSB)
    ld r16, X+         ; Carrega o primeiro byte de varA
    ld r17, Y+         ; Carrega o primeiro byte de varB
    sub r16, r17       ; Subtrai r17 de r16
    st Z+, r16         ; Armazena o resultado no endereço apontado por Z

    ; Byte 1
    ld r16, X+         ; Carrega o segundo byte de varA
    ld r17, Y+         ; Carrega o segundo byte de varB
    sbc r16, r17       ; Subtrai r17 de r16 considerando o carry
    st Z+, r16         ; Armazena o resultado

    ; Byte 2
    ld r16, X+         ; Carrega o terceiro byte de varA
    ld r17, Y+         ; Carrega o terceiro byte de varB
    sbc r16, r17       ; Subtrai r17 de r16 considerando o carry
    st Z+, r16         ; Armazena o resultado

    ; Byte 3 (MSB)
    ld r16, X+         ; Carrega o quarto byte de varA
    ld r17, Y+         ; Carrega o quarto byte de varB
    sbc r16, r17       ; Subtrai r17 de r16 considerando o carry
    st Z+, r16         ; Armazena o resultado

    ; Restaura contexto
    pop r0
    out SREG, r0
    pop r18
    pop r17
    pop r16

    ret

 