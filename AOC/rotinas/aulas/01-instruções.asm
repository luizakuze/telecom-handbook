start: 
;    ldi r16, 0x14    
;    ldi r17, 25 
;    subi r16, -1 //"add 1"
;
;    inc r0
;    clr r0
;    ser r16
    
    inc r0
    mov r1, r0
    inc r0
    movw r2, r0
    
    ;add r1, r0 ;guarda valor q está na esquerda
    
    rjmp start    