@ Simulação de Semáforo com Tempo Ajustável 
@ Verde → Amarelo → Vermelho → Verde
@ O botão + aumenta o tempo do verde.
@ O botão - diminui o tempo do verde.

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

    ; Inicializa o tempo do sinal verde
    ldi TEMPO_VERDE, 10  

    rjmp main  ; Pula para o loop principal

main:
    ; Verifica se o botão de aumento foi pressionado
    sbic PIND, BOTAO_AUMENTA  
    inc TEMPO_VERDE  

    ; Verifica se o botão de diminuição foi pressionado
    sbic PIND, BOTAO_DIMINUI  
    dec TEMPO_VERDE  

    ; Sequência de LEDs representando os sinais
    ldi AUX, 0b00000001  ; Acende o primeiro LED
    out PORTB, AUX  
    rcall delay  

    ldi AUX, 0b00000010  ; Acende o segundo LED
    out PORTB, AUX  
    rcall delay  

    ldi AUX, 0b00000100  ; Acende o terceiro LED
    out PORTB, AUX  
    rcall delay  

    rjmp main  ; Retorna ao início do loop principal

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