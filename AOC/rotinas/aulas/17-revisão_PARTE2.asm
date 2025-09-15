; Parte 2 – Manipulação de vetores
; 
; Este código declara e manipula três vetores de 10 posições de 8 bits (V0, V1 e VR).
; 
; - V0 é inicializado com valores de 10 a 19.
; - V1 é inicializado com valores de 20 a 29.
; - Os vetores V0 e V1 são somados e o resultado é armazenado em VR.
; - Após a soma, os vetores V0 e V1 são zerados.
; 
; Diretivas utilizadas:
; - .DSEG: Define a seção de dados.
; - .BYTE: Aloca espaço para variáveis de 8 bits.
; 
; Inclui o arquivo de definição do microcontrolador ATmega328P.
 
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
   
// PRIMEIRO: INICIALIZAR VETORES
ldi r20, 0          
 
ldi xl, low(v0)
ldi xh, high(v0)
 
ldi r16, 10         
ldi r17, 11 
ldi r18, 12
ldi r19, 13
 
; Loop para inicializar V0 e V1 
loop_v0_v1:
    rcall init_32bits 
    subi r16, -4      ; -(-4) = +4
    subi r17, -4      
    subi r18, -4       
    subi r19, -4        
    inc r20           
    cpi r20, 5        
    brne loop_v0_v1       

// SEGUNDO: SOMAR VETORES 
     
    ldi xl, low(v0)
    ldi xh, high(v0) 
    ldi yl, low(v1)
    ldi yh, high(v1) 
    ldi zl, low(vr)
    ldi zh, high(vr)
    
; Soma os vetores V0 e V1 e armazena o resultado em VR

    ldi xl, low(v0)      
    ldi xh, high(v0)
    ldi yl, low(v1)     
    ldi yh, high(v1)
    ldi zl, low(vr)     
    ldi zh, high(vr)

    ldi r20, 0 ;Contador 20 posiçoes totais (V0 e V1)
    
somar_v0_v1:
    rcall add_32bits_loop 
    inc r20          
    cpi r20, 4       ; Verifica se inicializou 20 posições
    brne somar_v0_v1     
    

    ldi r20, 0          ; Reinicia o contador 
    ldi xl, low(v0)      
    ldi xh, high(v0)

// TECEIRO: ZERAR V0 E V1
zerar_v0_v1:
    rcall zera_32bits 
    inc r20          
    cpi r20, 5       ; Verifica se inicializou 20 posições
    brne zerar_v0_v1     
    
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
    st X+, r16          
    st X+, r17        
    st X+, r18         
    st X+, r19          

    ret               
;------------------------------------------------------------------------
;SUB-ROTINA DE INICIALIZAÇAO ZERO
; Inicializa uma variavel de 32 bits com zero 
; Parametros: 
;   - Registrador X: Ponteiro para a posiçao
;------------------------------------------------------------------------    
zera_32bits:
    push r16          ; Salva o contexto
    in r1, SREG
    push r1      
    
    ; Prepara o registrador R0 com 0x00
    ldi r16, 0x00
    
    ; Salva 0 em 4 bytes consecutivos apontados por X
    st X+, r16         
    st X+, r16          
    st X+, r16          
    st X+, r16   
    
    ; Restaura o contexto
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
    ldi r16, 4         ; Contador 
    clr r18            ; Garante que o carry inicial está zerado

loop_sub:
    ld r17, X+         ; Carrega o próximo byte de varA
    ld r18, Y+         ; Carrega o próximo byte de varB
    sbc r17, r18       ; Subtrai r18 de r17 (carry é automaticamente tratado)
    st Z+, r17         ; Armazena o resultado no endereço apontado por Z

    dec r16            ; Decrementa o contador 
    brne loop_sub      

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
    ; Salva contexto essencial
    push r17
    push r18
    in r0, SREG
    push r0

    ; Inicializa o contador e garante carry zerado
    ldi r16, 4         
    clr r18              

loop_add:
    ld r17, X+         ; Carrega o próximo byte de varA
    ld r18, Y+         ; Carrega o próximo byte de varB
    adc r17, r18       ; Soma r17 + r18 + carry
    st Z+, r17         ; Armazena o resultado no endereço apontado por Z

    dec r16            ; Decrementa o contador de bytes
    brne loop_add      ; Continua o loop enquanto ainda houver bytes

    ; Restaura contexto essencial
    pop r0
    out SREG, r0
    pop r18
    pop r17
    ret

 