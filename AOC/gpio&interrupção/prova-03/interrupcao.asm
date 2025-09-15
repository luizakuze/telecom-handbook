@ Converta o código acima para que os botões + e – funcionem com as interrupções externas.

@ Configure e habilite adequadamente a INT0 e a INT1.

;------------------------------------------------------------
; QUESTÃO 1: GPIO - Animação de LEDs com Interrupções Externas
;------------------------------------------------------------

.equ PLUS_BUTTON = 2     ; PD2 - Botão + (conectado à interrupção INT0)
.equ MINUS_BUTTON = 3    ; PD3 - Botão - (conectado à interrupção INT1)
.equ LED_PORT = PORTC    ; LEDs conectados ao PORTC

.def AUX = R16           ; Registrador auxiliar para operações temporárias
.def POINTER = R17       ; Ponteiro do vetor de LEDs
.def DIRECTION = R18     ; 0 = crescente, 1 = decrescente

.ORG SRAM_START
LED_ANIMATION: .DB 0b00000001, 0b00000010, 0b00000100, 0b00001000, 0b00010000, 0b00100000, 0b01000000, 0b10000000

;------------------------------------------------------------
; CONFIGURAÇÃO DOS PINOS GPIO E INTERRUPÇÕES
;------------------------------------------------------------
SETUP:
    ; Configura PORTC como saída para os LEDs
    LDI AUX, 0xFF       ; Define todos os bits como saída (PORTC)
    OUT DDRC, AUX       ; Aplica a configuração no registrador de direção DDRC

    ; Configura botões como entrada com pull-up ativado
    LDI AUX, 0x00       ; Define AUX como 0 (pinos de entrada)
    OUT DDRD, AUX       ; Aplica configuração para os pinos de PORTD serem entrada
    LDI AUX, 0b00001100 ; Ativa pull-ups internos para os botões (PD2 e PD3)
    OUT PORTD, AUX      ; Aplica a configuração ao registrador de saída PORTD

    ; Configuração inicial do sistema
    LDI POINTER, 0      ; Inicializa o ponteiro apontando para o primeiro LED
    LDI DIRECTION, 0    ; Começa no modo crescente (LEDs acendendo da esquerda para a direita)

    ; Configuração das Interrupções Externas
    LDI AUX, 0b00000011 ; Configura INT0 e INT1 para detecção na borda de subida
    STS EICRA, AUX      ; Aplica ao registrador EICRA

    LDI AUX, 0b00000011 ; Habilita as interrupções INT0 e INT1
    STS EIMSK, AUX      ; Aplica ao registrador EIMSK

    SEI                 ; Habilita interrupções globais

;------------------------------------------------------------
; LOOP PRINCIPAL PARA CONTROLE DA ANIMAÇÃO
;------------------------------------------------------------
START:
    ; Seleciona LED do vetor e exibe no PORTC
    LDI ZH, HIGH(LED_ANIMATION)  
    LDI ZL, LOW(LED_ANIMATION)   
    ADD ZL, POINTER              ; Adiciona o ponteiro ao endereço do vetor
    LPM AUX, Z                   ; Carrega o valor do vetor na posição do ponteiro
    OUT LED_PORT, AUX            ; Atualiza os LEDs

    ; Aguarda 200ms antes de acender o próximo LED
    LDI AUX, 16                 
    RCALL DELAY

    ; Atualiza ponteiro conforme a direção atual
    CPI DIRECTION, 0  ; Verifica se a direção é crescente
    BREQ INCREMENT    ; Se for crescente, chama a rotina de incremento
    DEC POINTER       ; Se for decrescente, decrementa o ponteiro
    RJMP CHECK_RESET  ; Verifica se chegou ao fim da animação

INCREMENT:
    INC POINTER       ; Incrementa o ponteiro para avançar ao próximo LED

CHECK_RESET:
    CPI POINTER, 8    ; Verifica se o ponteiro ultrapassou o último LED
    BRNE CHECK_UNDERFLOW  ; Se não ultrapassou, continua
    LDI POINTER, 0    ; Se ultrapassou, reinicia a animação do primeiro LED

CHECK_UNDERFLOW:
    CPI POINTER, 255  ; Verifica se o ponteiro ficou negativo (underflow)
    BRNE START        ; Se não, continua a execução
    LDI POINTER, 7    ; Se sim, reinicia a animação do último LED

    RJMP START        ; Retorna ao início do loop para continuar a animação

;------------------------------------------------------------
; ROTINA DE INTERRUPÇÃO PARA O BOTÃO +
;------------------------------------------------------------
INT0_ISR:
    LDI DIRECTION, 0   ; Define a direção como crescente
    RETI               ; Retorna da interrupção

;------------------------------------------------------------
; ROTINA DE INTERRUPÇÃO PARA O BOTÃO -
;------------------------------------------------------------
INT1_ISR:
    LDI DIRECTION, 1   ; Define a direção como decrescente
    RETI               ; Retorna da interrupção

;------------------------------------------------------------
; SUBROTINA DE ATRASO (200ms)
;------------------------------------------------------------
DELAY:
    PUSH R17          ; Salva o registrador R17 na pilha
    PUSH R18          ; Salva o registrador R18 na pilha
    LDI R17, 16       ; Define o número de iterações para o atraso

DELAY_LOOP:
    DEC R17          ; Decrementa o contador de atraso
    BRNE DELAY_LOOP  ; Se ainda não chegou a zero, continua decrementando

    POP R18          ; Restaura o valor original de R18
    POP R17          ; Restaura o valor original de R17
    RET              ; Retorna da sub-rotina
