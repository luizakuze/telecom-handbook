; Definição de constantes para os botões
.equ BOTAO_RESET = PD2  ; Pino PD2 conectado ao botão de reset
.equ BOTAO_PAUSA = PD3  ; Pino PD3 conectado ao botão de pausa

; Definição de registradores auxiliares
.def CONTADOR = R17  ; Registrador para armazenar o contador
.def PAUSA = R18     ; Flag para indicar se o contador está pausado
.def AUX = R16       ; Registrador auxiliar para configuração de registradores

setup:
    ; Configuração dos pinos de saída
    ldi AUX, 0xFF      ; Carrega 0xFF (todos os bits em 1) no registrador auxiliar
    out DDRB, AUX      ; Define todos os pinos do PORTB como saída
    ldi AUX, 0x00      ; Carrega 0x00 no registrador auxiliar
    out PORTB, AUX     ; Inicializa o PORTB com nível baixo (LEDs apagados)

    ; Configuração dos botões como entrada com pull-up
    cbi DDRD, BOTAO_RESET  ; Configura PD2 como entrada
    cbi DDRD, BOTAO_PAUSA  ; Configura PD3 como entrada
    sbi PORTD, BOTAO_RESET ; Habilita pull-up interno para o botão de reset
    sbi PORTD, BOTAO_PAUSA ; Habilita pull-up interno para o botão de pausa

    ; Inicializa os registradores de controle
    clr CONTADOR  ; Zera o contador
    clr PAUSA     ; Inicializa a flag de pausa como 0

    rjmp main  ; Pula para a rotina principal

main:
    ; Verifica se o botão de reset foi pressionado
    sbic PIND, BOTAO_RESET  ; Se o botão não estiver pressionado, ignora a próxima instrução
    clr CONTADOR            ; Se pressionado, zera o contador

    ; Verifica se o botão de pausa foi pressionado
    sbic PIND, BOTAO_PAUSA  ; Se o botão não estiver pressionado, ignora a próxima instrução
    ldi R19, 1
    eor PAUSA, R19            ; Inverte o estado da flag de pausa

    ; Se estiver pausado, volta para o loop principal sem incrementar o contador
    tst PAUSA  ; Testa se a flag PAUSA é diferente de zero
    brne main  ; Se for diferente de zero, pula para main (não incrementa o contador)

    ; Atualiza o valor do PORTB com o valor do contador (para exibição em LEDs, por exemplo)
    out PORTB, CONTADOR  
    inc CONTADOR         ; Incrementa o contador

    ; Chama um pequeno atraso para controlar a velocidade da contagem
    ldi R20, 8          ; Define o tempo de atraso
    rcall delay         ; Chama a sub-rotina de atraso

    rjmp main           ; Retorna ao loop principal

; Rotina de atraso simples
; O tempo pode ser ajustado para controlar a velocidade da contagem

; Sub-rotina de atraso
; O valor carregado em R20 determina a duração do atraso

delay:
    push R21          ; Salva o registrador R21 na pilha
    ldi R21, 255      ; Define um contador interno

delay_loop:
    dec R21          ; Decrementa o contador interno
    brne delay_loop  ; Se não for zero, continua no loop
    pop R21          ; Recupera o valor original de R21
    ret              ; Retorna da sub-rotina
