// O programa abaixo representa um led piscando com atraso de 200ms utilizando pilha.
// O registrado R19 é utilizado para controlar o tempo de atraso.
// São 3 implementações diferentes de sub-rotinas com uma estrutura inicial padrão para elas:
 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ESTRUTURA INICIAL PADRÃO PARA AS SUB-ROTINAS
.equ LED = PB5 ;LED PB5  
start:
    sbi DDRB, LED ;LED saída
main:

    sbi PORTB, LED ;LED 5V (acende o LED)
    rcall delay ;chama sub-rotina que representa um atraso de 200ms 
    
    
    cbi PORTB, LED ;coloca o pino PB5 em 0V (apaga o LED)
    rcall delay  


    rjmp main ;volta para main 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////









//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Primeira implementação: Sem salvar contexto e utilizar registradores como parâmetros
// .equ LED = PB5 ;LED PB5  
// start:
//     sbi DDRB, LED ;LED saída
// main:
// 
//     sbi PORTB, LED ;LED 5V (acende o LED)
//     rcall delay ;chama sub-rotina que representa um atraso de 200ms 
//     
//     
//     cbi PORTB, LED ;coloca o pino PB5 em 0V (apaga o LED)
//     rcall delay  
// 
// 
//     rjmp main ;volta para main  
// DELAY é uma sub-rotina que tem loop como rótulo!
;--------------------------------------------------------------
;SUB-ROTINA DE ATRASO  
;--------------------------------------------------------------
delay:  
    ldi R19,16
loop:
    dec R17 ;decrementa R17, começa com 0x00
    brne loop ;enquanto R17 > 0 fica decrementando R17
    dec R18 ;decrementa R18, começa com 0x00
    brne loop ;enquanto R18 > 0 volta decrementar R18
    dec R19 ;decrementa R19
    brne loop ;enquanto R19 > 0 vai para volta
    ret
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   






//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Segunda implementação: Salvando contexto dos registradores modificados
// .equ LED = PB5 ;LED PB5  
// start:
//     sbi DDRB, LED ;LED saída
// main:
// 
//     sbi PORTB, LED ;LED 5V (acende o LED)
//     rcall delay ;chama sub-rotina que representa um atraso de 200ms 
//     
//     
//     cbi PORTB, LED ;coloca o pino PB5 em 0V (apaga o LED)
//     rcall delay  
// 
// 
//     rjmp main ;volta para main  
// DELAY é uma sub-rotina que tem loop como rótulo!
;--------------------------------------------------------------
;SUB-ROTINA DE ATRASO  
;--------------------------------------------------------------
delay: ;atraso de aprox. 200ms
    // Salva os valores de r17, r18, r16...
    push r17  
    push r18  
    push r19  
    // .. e SREG na pilha
    in r17,SREG 
    push r17 
    
    // Executando sub-rotina
    clr r17
    clr r18
    ldi R19,16
    
loop:
    dec R17 ;decrementa R17, começa com 0x00
    brne loop ;enquanto R17 > 0 fica decrementando R17
    dec R18 ;decrementa R18, começa com 0x00
    brne loop ;enquanto R18 > 0 volta decrementar R18
    dec R19 ;decrementa R19
    brne loop ;enquanto R19 > 0 vai para volta
    
    pop r17
    out SREG, r17 ; Restaura os valores de SREG,
    pop r19 ; ... r19
    pop r18 ; ... r18
    pop r17 ; ... r17 da pilha
    
    ret
////////////////////////////////////////////////////////////////////////////////////////////////////////////////







//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Terceira implementação: Usando os registradores para passar parâmetro
// Somente foi removida a linha: ldi R19,16
// A pessoa que estiver executando deve ser responsável por carregar o valor de R19 antes de chamar a sub-rotina!
// .equ LED = PB5 ;LED PB5  
// start:
//     sbi DDRB, LED ;LED saída
// main:
// 
//     sbi PORTB, LED ;LED 5V (acende o LED)
//     rcall delay ;chama sub-rotina que representa um atraso de 200ms 
//     
//     
//     cbi PORTB, LED ;coloca o pino PB5 em 0V (apaga o LED)
//     rcall delay  
// 
// 
//     rjmp main ;volta para main  
// DELAY é uma sub-rotina que tem loop como rótulo!
;--------------------------------------------------------------
;SUB-ROTINA DE ATRASO Programável
; Depende do valor de R19 carregado antes da chamada.
; Ex.: - R19 = 16 --> 200ms
; - R19 = 80 --> 1s
;--------------------------------------------------------------
delay:
    push r17 ; Salva os valores de r17,
    push r18 ; ... r18,
    in r17,SREG ; ...
    push r17 ; ... e SREG na pilha.
    
    ; Executa sub-rotina :
    clr r17
    clr r18
loop:
    dec R17 ;decrementa R17, come¸ca com 0x00
    brne loop ;enquanto R17 > 0 fica decrementando R17
    dec R18 ;decrementa R18, come¸ca com 0x00
    brne loop ;enquanto R18 > 0 volta decrementar R18
    dec R19 ;decrementa R19
    brne loop ;enquanto R19 > 0 vai para volta
    
    pop r17
    out SREG, r17 ; Restaura os valores de SREG,
    pop r18 ; ... r18
    pop r17 ; ... r17 da pilha
    
    ret
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////