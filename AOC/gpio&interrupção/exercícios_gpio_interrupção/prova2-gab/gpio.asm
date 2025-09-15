.INCLUDE <m328Pdef.inc>  ; Inclui o arquivo de definições do ATmega328P para acessar os registradores e pinos

; ==============================
; DEFINIÇÃO DOS PINOS
; ==============================
.equ BOTAO_AUMENTAR = PD2   ; Define o botão de aumentar na porta PD2
.equ BOTAO_DIMINUIR = PD3   ; Define o botão de diminuir na porta PD3

; Definição dos pinos dos LEDs na porta B (PORTB)
.equ L0 = PB0              
.equ L1 = PB1
.equ L2 = PB2
.equ L3 = PB3
.equ L4 = PB4
.equ L5 = PB5
.equ L6 = PB6
.equ L7 = PB7

; ==============================
; DEFINIÇÃO DOS REGISTRADORES
; ==============================
.def AUX = R16              ; Registrador auxiliar para operações temporárias
.def LED_INDEX = R17        ; Índice do LED atual (qual LED está aceso)
.def DIRECAO = R18          ; Direção do movimento dos LEDs (0 = direita, 1 = esquerda)

; ==============================
; VETOR COM OS PADRÕES DE LEDS
; ==============================
.ORG 0x100                  ; Define um endereço fixo na memória para armazenar os padrões de LEDs
LED_PATTERN: 
    .DB 0b00000001, 0b00000010, 0b00000100, 0b00001000  ; LEDs acesos um por vez
    .DB 0b00010000, 0b00100000, 0b01000000, 0b10000000  ; Continuando a sequência até o último LED

; ==============================
; CONFIGURAÇÃO INICIAL
; ==============================
setup:
    ldi AUX, 0xFF            ; Carrega 0xFF no registrador AUX (1111 1111)
    out DDRB, AUX            ; Configura todos os pinos PB0-PB7 como saída (LEDs)

    ldi AUX, 0x00            ; Carrega 0x00 no AUX (0000 0000) para desligar os LEDs
    out PORTB, AUX           ; Garante que todos os LEDs começam apagados

    cbi DDRD, BOTAO_AUMENTAR ; Configura PD2 (botão +) como entrada
    cbi DDRD, BOTAO_DIMINUIR ; Configura PD3 (botão -) como entrada

    sbi PORTD, BOTAO_AUMENTAR ; Ativa resistor pull-up no botão de aumentar (PD2)
    sbi PORTD, BOTAO_DIMINUIR ; Ativa resistor pull-up no botão de diminuir (PD3)

    ldi LED_INDEX, 0         ; Inicia com o primeiro LED aceso
    clr DIRECAO              ; Define a direção inicial para direita (DIRECAO = 0)

    rjmp main                ; Pula para o loop principal

; ==============================
; LOOP PRINCIPAL
; ==============================
main:
    ; ==============================
    ; Acende o LED correspondente ao índice atual
    ; ==============================
    ldi ZL, LOW(LED_PATTERN) ; Carrega a parte baixa do endereço do vetor de LEDs
    ldi ZH, HIGH(LED_PATTERN); Carrega a parte alta do endereço do vetor de LEDs
    add ZL, LED_INDEX        ; Soma o índice do LED ao ponteiro Z para acessar o LED correto
    lpm AUX, Z               ; Carrega o padrão do LED correspondente do vetor para AUX
    out PORTB, AUX           ; Escreve o valor no PORTB para acender o LED correspondente

    ; ==============================
    ; Aguarda 200ms antes de mudar para o próximo LED
    ; ==============================
    ldi R19, 16              ; Carrega 16 no registrador R19 para controle do delay
    rcall delay              ; Chama a rotina de atraso (delay)

    ; ==============================
    ; Verifica se os botões foram pressionados
    ; ==============================
    sbic PIND, BOTAO_AUMENTAR ; Se o botão de aumentar não foi pressionado, pula a próxima linha
    rcall mudar_direcao_direita ; Se pressionado, chama a função para mudar a direção para direita

    sbic PIND, BOTAO_DIMINUIR ; Se o botão de diminuir não foi pressionado, pula a próxima linha
    rcall mudar_direcao_esquerda ; Se pressionado, chama a função para mudar a direção para esquerda

    ; ==============================
    ; Atualiza o índice do LED conforme a direção escolhida
    ; ==============================
    tst DIRECAO              ; Testa se a direção é 0 (direita)
    breq mover_direita       ; Se for 0 (direita), pula para a função mover_direita
    rjmp mover_esquerda      ; Se não, pula para a função mover_esquerda

; ==============================
; MOVIMENTAÇÃO DOS LEDs PARA A DIREITA
; ==============================
mover_direita:
    inc LED_INDEX            ; Incrementa o índice do LED
    cpi LED_INDEX, 8         ; Compara se o índice chegou a 8 (limite máximo)
    brlt main                ; Se ainda for menor que 8, volta para o loop principal
    clr LED_INDEX            ; Se chegou a 8, reinicia a contagem para 0
    rjmp main                ; Retorna ao início do loop

; ==============================
; MOVIMENTAÇÃO DOS LEDs PARA A ESQUERDA
; ==============================
mover_esquerda:
    dec LED_INDEX            ; Decrementa o índice do LED
    brpl main                ; Se LED_INDEX for maior ou igual a 0, continua no loop principal
    ldi LED_INDEX, 7         ; Se for menor que 0, redefine para 7 (último LED)
    rjmp main                ; Retorna ao início do loop

; ==============================
; ALTERA DIREÇÃO PARA DIREITA (BOTÃO +)
; ==============================
mudar_direcao_direita:
    clr DIRECAO              ; Define DIRECAO = 0 (mover para direita)
    ret                      ; Retorna para o loop principal

; ==============================
; ALTERA DIREÇÃO PARA ESQUERDA (BOTÃO -)
; ==============================
mudar_direcao_esquerda:
    ldi DIRECAO, 1           ; Define DIRECAO = 1 (mover para esquerda)
    ret                      ; Retorna para o loop principal

; ==============================
; ROTINA DE ATRASO (APPROX 100MS)
; ==============================
delay:
    push R17                 ; Salva o valor de R17 na pilha
    push R18                 ; Salva o valor de R18 na pilha
    clr R17                  ; Zera o registrador R17
    clr R18                  ; Zera o registrador R18

loopdelay:
    dec R17                  ; Decrementa R17
    brne loopdelay           ; Se R17 não for zero, continua no loop
    dec R18                  ; Decrementa R18
    brne loopdelay           ; Se R18 não for zero, continua no loop
    dec R19                  ; Decrementa R19
    brne loopdelay           ; Se R19 não for zero, continua no loop

    pop R18                  ; Restaura o valor original de R18
    pop R17                  ; Restaura o valor original de R17
    ret                      ; Retorna para a função que chamou o delay
