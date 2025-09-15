; Definição de constante para o botão
.equ BOTAO_CONTAR = PD2  ; Pino PD2 conectado ao botão de contagem

; Definição de registradores auxiliares
.def CONTADOR = R17  ; Registrador para armazenar o contador
.def AUX = R16       ; Registrador auxiliar para configuração

setup:
    ; Configuração dos pinos de saída
    ldi AUX, 0xFF      ; Configura todos os pinos do PORTB como saída
    out DDRB, AUX      ; Aplica a configuração
    ldi AUX, 0x00      ; Inicializa o PORTB com nível baixo (LEDs apagados)
    out PORTB, AUX     

    ; Configuração do botão como entrada com pull-up
    cbi DDRD, BOTAO_CONTAR  ; Configura PD2 como entrada
    sbi PORTD, BOTAO_CONTAR ; Habilita pull-up interno no botão de contagem

    ; Configuração de interrupções externas
    sei                 ; Habilita interrupções globais
    ldi AUX, 0x02 ; Configura INT0 para borda de descida (botão pressionado)
    sts EICRA, AUX
    ldi AUX, 0x01  ; Habilita interrupção externa INT0
    out EIMSK, AUX

    ; Inicializa o contador
    clr CONTADOR  ; Zera o contador

    rjmp main  ; Pula para o loop principal

main:
    ; Atualiza a saída do PORTB com o valor do contador
    out PORTB, CONTADOR  

    ; Aguarda um tempo antes de continuar
    ldi R20, 8          ; Define o tempo de atraso
    rcall delay         ; Chama a sub-rotina de atraso

    rjmp main           ; Retorna ao loop principal

; Sub-rotina de atraso para evitar incrementos muito rápidos
delay:
    push R21            ; Salva o registrador R21
    ldi R21, 255        ; Define um contador interno

delay_loop:
    dec R21             ; Decrementa o contador interno
    brne delay_loop     ; Continua o loop até atingir zero
    pop R21             ; Recupera o valor original de R21
    ret                 ; Retorna da sub-rotina

; Rotina de interrupção para o botão de contagem
isr_contador:
    inc CONTADOR  ; Incrementa o contador ao pressionar o botão
    reti          ; Retorna da interrupção
