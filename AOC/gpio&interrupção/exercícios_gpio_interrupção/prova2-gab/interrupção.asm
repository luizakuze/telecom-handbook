.INCLUDE <m328Pdef.inc>    ; Inclui o arquivo de definições do microcontrolador ATmega328P

; -------------------- Definições de pinos --------------------
.equ BOTAO_AUMENTAR = PD2   ; Botão de aumento conectado ao pino PD2 (INT0)
.equ BOTAO_DIMINUIR = PD3   ; Botão de diminuição conectado ao pino PD3 (INT1)

; Definição dos LEDs conectados às portas do PORTB
.equ L0 = PB0               
.equ L1 = PB1
.equ L2 = PB2
.equ L3 = PB3
.equ L4 = PB4
.equ L5 = PB5
.equ L6 = PB6
.equ L7 = PB7

; -------------------- Definição de registradores --------------------
.def AUX = R16              ; Registrador auxiliar para operações temporárias
.def LED_INDEX = R17        ; Índice que controla qual LED está aceso
.def DIRECAO = R18          ; Direção da animação (0 = direita, 1 = esquerda)

; -------------------- Vetor com os padrões de LEDs --------------------
.ORG 0x100                  ; Define um endereço fixo na memória para armazenar o vetor de LEDs
LED_PATTERN: 
    .DB 0b00000001, 0b00000010, 0b00000100, 0b00001000
    .DB 0b00010000, 0b00100000, 0b01000000, 0b10000000

; -------------------- Configuração inicial --------------------
setup:
    ldi AUX, 0xFF           ; Carrega 0xFF no registrador AUX (define PB0-PB7 como saída)
    out DDRB, AUX           ; Configura todas as portas do PORTB como saída

    ldi AUX, 0x00           ; Carrega 0x00 no AUX para desligar todos os LEDs
    out PORTB, AUX          ; Apaga todos os LEDs no início

    cbi DDRD, BOTAO_AUMENTAR ; Configura BOTAO_AUMENTAR (PD2) como entrada
    cbi DDRD, BOTAO_DIMINUIR ; Configura BOTAO_DIMINUIR (PD3) como entrada

    sbi PORTD, BOTAO_AUMENTAR ; Ativa resistor pull-up interno no botão de aumentar
    sbi PORTD, BOTAO_DIMINUIR ; Ativa resistor pull-up interno no botão de diminuir

    ; Configura as interrupções externas
    ldi AUX, 0b0000_1010    ; Configura INT0 e INT1 para borda de descida
    sts EICRA, AUX          ; Salva configuração no registrador de controle de interrupções externas

    sbi EIMSK, INT0         ; Habilita interrupção externa INT0 (botão de aumentar)
    sbi EIMSK, INT1         ; Habilita interrupção externa INT1 (botão de diminuir)

    sei                     ; Habilita interrupções globais

    clr DIRECAO             ; Define direção inicial para direita (DIRECAO = 0)
    clr LED_INDEX           ; Começa no primeiro LED (LED_INDEX = 0)

    rjmp main               ; Pula para o loop principal

; -------------------- Loop principal --------------------
main:
    ; Lê o padrão de LED correspondente ao índice atual
    ldi ZL, LOW(LED_PATTERN) ; Define parte baixa do endereço do vetor de LEDs
    ldi ZH, HIGH(LED_PATTERN); Define parte alta do endereço do vetor de LEDs
    add ZL, LED_INDEX        ; Ajusta o ponteiro Z para o índice do LED atual
    lpm AUX, Z               ; Carrega o valor do vetor para AUX
    out PORTB, AUX           ; Atualiza os LEDs no PORTB

    ; Aguarda 200ms
    ldi R19, 16              ; Carrega 16 em R19 (usado no delay)
    rcall delay              ; Chama a rotina de delay

    ; Verifica a direção do LED e movimenta na direção correta
    tst DIRECAO              ; Testa se DIRECAO é 0 (movimento para direita)
    breq mover_direita       ; Se DIRECAO = 0, vai para mover_direita
    rjmp mover_esquerda      ; Se DIRECAO = 1, vai para mover_esquerda

mover_direita:
    inc LED_INDEX            ; Incrementa o índice do LED
    cpi LED_INDEX, 8         ; Compara se LED_INDEX chegou a 8 (fora dos limites)
    brlt main                ; Se for menor que 8, continua no loop principal
    clr LED_INDEX            ; Se chegou ao limite, reseta para 0
    rjmp main                ; Volta ao início do loop

mover_esquerda:
    dec LED_INDEX            ; Decrementa o índice do LED
    brpl main                ; Se LED_INDEX >= 0, continua no loop principal
    ldi LED_INDEX, 7         ; Se LED_INDEX < 0, redefine para 7 (último LED)
    rjmp main                ; Volta ao início do loop

; -------------------- Interrupção para o botão + (INT0) --------------------
isr_int0:
    push R16                 ; Salva o registrador R16
    in R16, SREG             ; Salva o status do processador (SREG)
    push R16                 ; Guarda na pilha

    clr DIRECAO              ; Define DIRECAO como 0 (movimento para direita)

    pop R16                  ; Restaura o status do processador (SREG)
    out SREG, R16            ; Aplica o valor restaurado
    pop R16                  ; Restaura o registrador R16
    reti                     ; Retorna da interrupção

; -------------------- Interrupção para o botão - (INT1) --------------------
isr_int1:
    push R16                 ; Salva o registrador R16
    in R16, SREG             ; Salva o status do processador (SREG)
    push R16                 ; Guarda na pilha

    ldi DIRECAO, 1           ; Define DIRECAO como 1 (movimento para esquerda)

    pop R16                  ; Restaura o status do processador (SREG)
    out SREG, R16            ; Aplica o valor restaurado
    pop R16                  ; Restaura o registrador R16
    reti                     ; Retorna da interrupção

; -------------------- Rotina de atraso --------------------
delay:
    push R17                 ; Salva R17 na pilha
    push R18                 ; Salva R18 na pilha
    clr R17                  ; Limpa R17
    clr R18                  ; Limpa R18

loopdelay:
    dec R17                  ; Decrementa R17
    brne loopdelay           ; Se R17 não for zero, continua no loop
    dec R18                  ; Decrementa R18
    brne loopdelay           ; Se R18 não for zero, continua no loop
    dec R19                  ; Decrementa R19
    brne loopdelay           ; Se R19 não for zero, continua no loop

    pop R18                  ; Restaura R18 da pilha
    pop R17                  ; Restaura R17 da pilha
    ret                      ; Retorna da sub-rotina
