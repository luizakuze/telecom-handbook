.include "/opt/microchip/mplabx/v6.15/packs/Microchip/ATmega_DFP/3.0.158/avrasm/inc/m328Pdef.inc" ; Inclui as definições específicas do ATMEGA328P

.cseg                   ; Início da seção de código
    rjmp start          ; Salta para o rótulo 'start' (início do programa)

start:
    ldi r16, 0xFF       ; Configura todos os pinos do PORTD como saída (PD0-PD7 para os LEDs) -> 11111111
    out DDRD, r16       ; DDRD = 0xFF (todos os pinos como saída)
    ldi r16, 0x00       ; Configura PB0 e PB1 como entrada (botões)
    out DDRB, r16       ; DDRB = 0x00 (PB0 e PB1 como entrada, outros como entrada (mas sem uso)) -> 00000000

test_sequence:
    ; Passo 1: Todos os LEDs acesos
    ldi r16, 0xFF
    out PORTD, r16
    ldi r19, 40
    rcall delay

    ; Passo 2: Verifica se o botão ajuste (PB0) foi pressionado (PB0 = 0)
    in r16, PINB         ; Lê o valor de PB0 e PB1
    sbrs r16, 0          ; Se PB0 não foi pressionado, vai para o próximo passo
    rcall ajuste_pressed ; Caso PB0 pressionado, chama a rotina ajuste_pressed

    ; Passo 3: Verifica se o botão seleção (PB1) foi pressionado (PB1 = 0)
    in r16, PINB         ; Lê o valor de PB0 e PB1
    sbrs r16, 1          ; Se PB1 não foi pressionado, vai para o próximo passo
    rcall selecao_pressed ; Caso PB1 pressionado, chama a rotina selecao_pressed

    ; Passo 4: Nenhum botão pressionado, todos os LEDs acesos novamente
    ldi r16, 0xFF
    out PORTD, r16
    ldi r19, 40
    rcall delay

    rjmp test_sequence  ; Repete a sequência

;--------------------------------------------------------------------------------
; SUB-ROTINA: ajuste_pressed
;
; Apaga os 4 LEDs menos significativos (PD0-PD3) e mantém os 4 LEDs mais
; significativos (PD4-PD7) ligados. Após a operação, aplica um atraso de 500ms.
;--------------------------------------------------------------------------------
ajuste_pressed:
    ldi r16, 0xF0       ; Apaga os 4 LEDs menos significativos (PD0-PD3) e mantém PD4-PD7 ligados
    out PORTD, r16      ; PORTD = 0xF0 (PD4-PD7 ligados, PD0-PD3 apagados)
    ldi r19, 40         ; Configura o atraso para ~500ms
    rcall delay         ; Chama a sub-rotina de atraso
    rjmp test_sequence      ; Retorna ao início do loop principal

;--------------------------------------------------------------------------------
; SUB-ROTINA: selecao_pressed
;
; Apaga os 4 LEDs mais significativos (PD4-PD7) e mantém os 4 LEDs menos
; significativos (PD0-PD3) ligados. Após a operação, aplica um atraso de 500ms.
;--------------------------------------------------------------------------------
selecao_pressed:
    ldi r16, 0x0F       ; Apaga os 4 LEDs mais significativos (PD4-PD7) e mantém PD0-PD3 ligados
    out PORTD, r16      ; PORTD = 0x0F (PD0-PD3 ligados, PD4-PD7 apagados)
    ldi r19, 40         ; Configura o atraso para ~500ms
    rcall delay         ; Chama a sub-rotina de atraso
    rjmp test_sequence      ; Retorna ao início do loop principal

;--------------------------------------------------------------------------------
; SUB-ROTINA DE ATRASO Programável
; 
; Essa sub-rotina gera um atraso proporcional ao valor carregado em R19.
; Exemplo:
;   - R19 = 16 --> Atraso de ~200ms
;   - R19 = 80 --> Atraso de ~1s
; 
; O tempo real do atraso depende do clock do microcontrolador.
;--------------------------------------------------------------------------------
delay:
    push r17              ; Salva o valor original de R17 na pilha
    push r18              ; Salva o valor original de R18 na pilha
    in r17, SREG          ; Salva o registrador de status (SREG) para restaurá-lo depois
    push r17

    clr r17               ; Zera R17 (contador interno do loop)
    clr r18               ; Zera R18 (contador interno do loop)

loop:
    dec r17               ; Decrementa R17
    brne loop             ; Se R17 não for zero, continua no loop
    dec r18               ; Quando R17 chega a zero, decrementa R18
    brne loop             ; Se R18 não for zero, continua no loop
    dec r19               ; Quando R18 chega a zero, decrementa R19
    brne loop             ; Se R19 não for zero, continua no loop

    pop r17               ; Restaura o valor original do SREG
    out SREG, r17
    pop r18               ; Restaura R18
    pop r17               ; Restaura R17

    ret                   ; Retorna à rotina principal
