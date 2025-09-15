INCLUDE <m328Pdef.inc>

start:
    ; Exemplo in/out
    inc R0		
    out GPIOR0, R0; escreve no GPIORO  
    in R1, GPIOR0 ; lê do GPIORO 

    ; Exemplo sbi/cbi
    sbi DDRB, 5	  ; seta o bit 5 no registrador DDRB
    cbi DDRB, 5	  ; Reseta o bit 5 do registrador DDRB

; Exemplo sbis/sbic
waitUM:
    sbis PIND,7   ; Salta para próxima instrição se o bit 7 é UM
    rjmp waitUM   ; Bit 7 do PIND não setado. Salta para wait.
waitZERO:
    sbic PIND,7	  ; Salta para próxima instrução de o bit é ZERO.
    rjmp waitZERO ; Se não, aguarda.
    nop		  ;

rjmp start
