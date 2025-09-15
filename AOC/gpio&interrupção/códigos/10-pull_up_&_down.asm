@ O que é Pull-up e Pull-down?
@@ Os resistores pull-up e pull-down são usados para garantir 
@@ que um pino tenha um estado definido (1 ou 0) quando não há 
@@ conexão direta com um botão ou outro circuito.

@ Pull-up: Mantém o pino em nível alto (1) quando o botão não está pressionado.
@ Pull-down: Mantém o pino em nível baixo (0) quando o botão não está pressionado.

// O PORTx é usado para configurar os pinos como pull-up ou pull-down quando configurado como entrada

//-----------------------------------------------------------------------------------------------------------


// LED acende quando o botão está em 1 (pull-up externo)

// - botão está conectado ao pino PD2 com um resistor de pull-down
// - quando o botão é pressionado, PD2 vai para nível alto (1)
// - comando sbis verifica se o botão está em nível alto. Se estiver, o LED no PB0 acende.
// - LED permanece aceso enquanto o botão estiver pressionado.




.include "m328pdef.inc"


; Configuração dos pinos
    sbi DDRB, PB0  ; Configura PB0 como saída (LED)
    cbi DDRD, PD2  ; Configura PD2 como entrada (Botão)
    cbi PORTD, PD2 ; Desativa pull-up no PD2 (pull-down)

main:
    sbis PIND, PD2 ; Pula a próxima instrução se PD2 estiver em nível baixo (botão não pressionado)
    rjmp main      ; Volta para main se o botão não estiver pressionado

    sbi PORTB, PB0 ; Acende o LED no PB0 (botão pressionado, nível alto)
    rcall delay    ; Chama a sub-rotina de delay
    cbi PORTB, PB0 ; Apaga o LED no PB0
    rjmp main      ; Volta para main

delay:
    ldi r16, 0xFF  ; Carrega o registrador r16 com 255
delay_loop:
    dec r16        ; Decrementa r16
    brne delay_loop; Repete até r16 ser zero
    ret            ; Retorna da sub-rotina




//-----------------------------------------------------------------------------------------------------------


// LED acende quando o botão está em 0 (pull-down externo)

// - O botão está conectado ao pino PD2 com um resistor de pull-up.
// - Quando o botão é pressionado, PD2 vai para nível baixo (0).
// - O comando sbic verifica se o botão está em nível baixo. Se estiver, o LED no PB0 acende.
// - O LED permanece aceso enquanto o botão estiver pressionado.


.include "m328pdef.inc"

; Configuração dos pinos
    sbi DDRB, PB0  ; Configura PB0 como saída (LED)
    cbi DDRD, PD2  ; Configura PD2 como entrada (Botão)
    sbi PORTD, PD2 ; Ativa pull-up no PD2 (pull-up interno)

main:
    sbic PIND, PD2 ; Pula a próxima instrução se PD2 estiver em nível alto (botão não pressionado)
    rjmp main      ; Volta para main se o botão não estiver pressionado

    sbi PORTB, PB0 ; Acende o LED no PB0 (botão pressionado, nível baixo)
    rcall delay    ; Chama a sub-rotina de delay
    cbi PORTB, PB0 ; Apaga o LED no PB0
    rjmp main      ; Volta para main

delay:
    ldi r16, 0xFF  ; Carrega o registrador r16 com 255
delay_loop:
    dec r16        ; Decrementa r16
    brne delay_loop; Repete até r16 ser zero
    ret            ; Retorna da sub-rotina