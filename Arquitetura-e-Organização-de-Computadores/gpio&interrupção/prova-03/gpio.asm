@ Questão 1: GPIO
@ Inicialize os GPIOs adequadamente. Altere somente os bits associados aos pinos utilizados.

@ A cada 200ms um dos LEDs deve acender.

@ Se o botão + for pressionado, o LED acesso deve ir na direção do pino mais significativo. Se o botão – for pressionado o LED acesso deve ir na direção do pino menos significativo. O estado inicial do sistema deve ser a direção do pino mais significativo.

@ Quando chegar no último LED, a animação deve começar novamente.

@ Dica: Utilize um vetor para guardar todos valores da animação, um registrador como ponteiro desse vetor e outro registrador para guardar o estado (+ = 0 ou – = 1). Os botões alteram o registrador de estado, que por sua vez é verificado para definir se o ponteiro deve incrementar ou decrementar para escolher qual valor do vetor mostrar .

;------------------------------------------------------------
; QUESTÃO 1: GPIO - Animação de LEDs
;------------------------------------------------------------
.equ PLUS_BUTTON = PD2  ; Define o botão + no pino PD2
.equ MINUS_BUTTON = PD3  ; Define o botão - no pino PD3
.equ LED_PORT = PORTC   ; LEDs conectados ao PORTC
.def AUX = R16  ; Registrador auxiliar para operações temporárias
.def POINTER = R17  ; Ponteiro do vetor de LEDs
.def DIRECTION = R18  ; 0 = crescente, 1 = decrescente

; Vetor de padrões de LEDs (PC0 a PC7)
.ORG SRAM_START
LED_ANIMATION: .DB 0b00000001, 0b00000010, 0b00000100, 0b00001000, 0b00010000, 0b00100000, 0b01000000, 0b10000000

;------------------------------------------------------------
; CONFIGURAÇÃO DOS PINOS GPIO
;------------------------------------------------------------
SETUP:
; Configura PORTC como saída para os LEDs
LDI AUX, 0xFF  ; Define todos os bits de AUX como 1 (configura todos os pinos como saída)
OUT DDRC, AUX  ; Aplica a configuração ao registrador de direção DDRC
  
; Configura botões como entrada com pull-up ativado
LDI AUX, 0x00  ; Define AUX como 0 (configura os pinos como entrada)
OUT DDRD, AUX  ; Aplica a configuração ao registrador de direção DDRD
LDI AUX, 0xFF  ; Ativa pull-ups internos para evitar estados flutuantes
OUT PORTD, AUX  ; Aplica a configuração ao registrador de saída PORTD

; Configuração inicial do sistema
LDI POINTER, 0  ; Inicializa o ponteiro apontando para o primeiro LED
LDI DIRECTION, 0  ; Começa no modo crescente (LEDs acendendo da esquerda para a direita)

;------------------------------------------------------------
; LOOP PRINCIPAL PARA CONTROLE DA ANIMAÇÃO
;------------------------------------------------------------
START:
  ; Seleciona LED do vetor e exibe no PORTC
  LDI ZH, HIGH(LED_ANIMATION)  ; Carrega a parte alta do endereço do vetor
  LDI ZL, LOW(LED_ANIMATION)   ; Carrega a parte baixa do endereço do vetor
  ADD ZL, POINTER  ; Adiciona o ponteiro ao endereço para acessar o elemento correto do vetor
  LPM AUX, Z  ; Carrega o valor do vetor correspondente à posição do ponteiro
  OUT LED_PORT, AUX  ; Atualiza os LEDs de acordo com o padrão carregado

  ; Aguarda 200ms antes de acender o próximo LED
  LDI AUX, 16  ; Configura um atraso equivalente a 200ms
  RCALL DELAY  ; Chama a sub-rotina de atraso

  ; Verifica se o botão + foi pressionado
  SBIC PIND, PLUS_BUTTON  ; Verifica se o pino PD2 está em nível baixo (botão pressionado)
  RJMP CHECK_MINUS_BUTTON  ; Se não estiver pressionado, verifica o outro botão
  LDI DIRECTION, 0  ; Define a direção como crescente

CHECK_MINUS_BUTTON:
  SBIC PIND, MINUS_BUTTON  ; Verifica se o botão - foi pressionado
  RJMP UPDATE_POINTER  ; Se não estiver pressionado, continua a execução
  LDI DIRECTION, 1  ; Define a direção como decrescente

UPDATE_POINTER:
  CPI DIRECTION, 0  ; Verifica a direção atual da animação
  BREQ INCREMENT  ; Se for crescente, incrementa o ponteiro
  DEC POINTER  ; Se for decrescente, decrementa o ponteiro
  RJMP CHECK_RESET  ; Verifica se chegou ao final

INCREMENT:
  INC POINTER  ; Incrementa o ponteiro para avançar ao próximo LED

CHECK_RESET:
  CPI POINTER, 8  ; Verifica se o ponteiro ultrapassou o último LED
  BRNE CHECK_UNDERFLOW  ; Se não, continua
  LDI POINTER, 0  ; Se sim, reinicia a animação do primeiro LED

CHECK_UNDERFLOW:
  CPI POINTER, 255  ; Verifica se o ponteiro ficou negativo (underflow)
  BRNE START  ; Se não, continua a execução
  LDI POINTER, 7  ; Se sim, reinicia a animação do último LED

  RJMP START  ; Retorna ao início do loop para continuar a animação

;------------------------------------------------------------
; SUBROTINA DE ATRASO (200ms)
;------------------------------------------------------------
DELAY:
  PUSH R17  ; Salva o registrador R17 na pilha
  PUSH R18  ; Salva o registrador R18 na pilha
  LDI R17, 16  ; Define o número de iterações para o atraso
DELAY_LOOP:
  DEC R17  ; Decrementa o contador de atraso
  BRNE DELAY_LOOP  ; Se ainda não chegou a zero, continua decrementando
  POP R18  ; Restaura o valor original de R18
  POP R17  ; Restaura o valor original de R17
  RET  ; Retorna da sub-rotina
