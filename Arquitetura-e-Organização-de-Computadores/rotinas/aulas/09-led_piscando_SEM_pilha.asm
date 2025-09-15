// O programa faz um led piscar utilizando loops
// Os loops servem para definir o tempo que o led fica aceso e apagado (aproximadamente 200ms)
// Esse código não utiliza pilha, o que é uma prática ruim pois há duplicação de código!


.equ LED = PB5 ;LED é o substituto de PB5

start:
    sbi DDRB, LED ;configura pino LED como saída

main:
    sbi PORTB, LED ;coloca o pino PB5 em 5V

    // ATRASO de 200ms, led está ligado
    ldi R19,16
    
loop:
    dec R17 ;decrementa R17, começa com 0x00
    brne loop ;se R17>0 fica decrementando R17
    dec R18 ;decrementa R18, começa com 0x00
    brne loop ;se R18>0 volta decrementar R18
    dec R19 ;decrementa R19
    brne loop ;se R19>0 vai para volta

    cbi PORTB, LED ;coloca o pino PB5 em 0V

    // ATRASO de 200ms, led está desligado
    ldi R19,16

loop2:
    dec R17 ;decrementa R17, começa com 0x00
    brne loop2 ;se R17>0 fica decrementando R17
    dec R18 ;decrementa R18, começa com 0x00
    brne loop2 ;se R18>0 volta decrementar R18
    dec R19 ;decrementa R19
    brne loop2 ;se R19>0 vai para volta

    // Vai ligar e desligar o led indefinidamente
    rjmp main 
