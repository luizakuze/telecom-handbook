; Definição de constantes para os botões
.equ BOTAO_AUMENTA = PD2  ; Pino PD2 para aumentar o tempo
.equ BOTAO_DIMINUI = PD3  ; Pino PD3 para diminuir o tempo

; Definição de registradores auxiliares
.def TEMPO_VERDE = R17  ; Registrador para armazenar o tempo do sinal verde
.def AUX = R16         ; Registrador auxiliar

setup:
    ; Configuração dos pinos de saída
    ldi AUX, 0xFF      ; Configura todos os pinos do PORTB como saída
    out DDRB, AUX      ; Aplica a configuração
    ldi AUX, 0x00      ; Inicializa o PORTB com nível baixo
    out PORTB, AUX     

    ; Configuração dos botões como entrada com pull-up
    cbi DDRD, BOTAO_AUMENTA  ; Configura PD2 como entrada
    cbi DDRD, BOTAO_DIMINUI  ; Configura PD3 como entrada
    sbi PORTD, BOTAO_AUMENTA ; Habilita pull-up interno para o botão de aumento
    sbi PORTD, BOTAO_DIMINUI ; Habilita pull-up interno para o botão de diminuição

    ; Configuração de interrupções externas
    sei                 ; Habilita interrupções globais
    ldi AUX, (1 << ISC01) ; Configura INT0 para borda de descida (botão AUMENTA pressionado)
    sts EICRA, AUX
    ldi AUX, (1 << ISC11) ; Configura INT1 para borda de descida (botão DIMINUI pressionado)
    sts EICRA+1, AUX
    ldi AUX, (1 << INT0) | (1 << INT1) ; Habilita interrupções externas INT0 e INT1
    out EIMSK, AUX

    ; Inicializa o tempo do sinal verde
    ldi TEMPO_VERDE, 10  

    rjmp main  ; Pula para o loop principal

main:
    ; Atualiza a saída do PORTB com o valor do contador
    out PORTB, TEMPO_VERDE  

    ; Aguarda um tempo antes de continuar
    ldi R20, 8          ; Define o tempo de atraso
    rcall delay         ; Chama a sub-rotina de atraso

    rjmp main           ; Retorna ao loop principal

; Sub-rotina de atraso
; Utiliza o TEMPO_VERDE para ajustar a duração do sinal
delay:
    push R21            ; Salva o registrador R21
    mov R21, TEMPO_VERDE ; Copia o tempo para R21

delay_loop:
    dec R21             ; Decrementa o contador interno
    brne delay_loop     ; Continua o loop até atingir zero
    pop R21             ; Recupera o valor original de R21
    ret                 ; Retorna da sub-rotina

; Rotina de interrupção para aumentar o tempo\isr_aumenta:
    inc TEMPO_VERDE  ; Incrementa o tempo do sinal verde
    reti          ; Retorna da interrupção

; Rotina de interrupção para diminuir o tempo
isr_diminui:
    dec TEMPO_VERDE  ; Decrementa o tempo do sinal verde
    reti          ; Retorna da interrupção
