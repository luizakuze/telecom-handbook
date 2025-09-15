// Programa soma 2 variaǘeis de 32 bits
.DSEG
A: .BYTE 4
B: .BYTE 4
C: .BYTE 4

.CSEG
start:
    LDI XH, HIGH(A)
    LDI XL, LOW(A)
    LDI YH, HIGH(B)
    LDI YL, LOW(B)
    LDI ZH, HIGH(C)
    LDI ZL, LOW(C)

    ; Chamando a sub-rotina
    RCALL soma_32bits

    RJMP start

;--------------------------------------------------------------
; SUB-ROTINA PARA SOMAR 2 VARIÁVEIS DE 32 BITS
;--------------------------------------------------------------
soma_32bits:
    ; Salva o contexto dos registradores usados
    PUSH r16
    PUSH r17
    PUSH r18
    PUSH r19

    CLR r16         

    ; Soma o primeiro byte  
    LD r17, X        
    LD r18, Y        
    ADD r17, r18     
    ST Z+, r17       
    CLR r19          
    ADC r19, r16     

    ; Soma o segundo byte
    LD r17, X+      
    LD r18, Y+      
    ADD r17, r18    
    ADC r17, r19    
    ST Z+, r17      
    CLR r19
    ADC r19, r16    

    ; Soma o terceiro byte
    LD r17, X+     
    LD r18, Y+     
    ADD r17, r18   
    ADC r17, r19   
    ST Z+, r17     
    CLR r19
    ADC r19, r16   

    ; Soma o quarto byte  
    LD r17, X+     
    LD r18, Y+     
    ADD r17, r18   
    ADC r17, r19   
    ST Z+, r17     
 
    POP r19
    POP r18
    POP r17
    POP r16

    RET