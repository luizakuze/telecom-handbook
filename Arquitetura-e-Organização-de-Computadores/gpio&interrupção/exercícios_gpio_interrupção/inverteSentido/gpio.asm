.INCLUDE <m328Pdef.inc>  ; Inclui o arquivo com definições para o ATmega328P

; ==========================
; Definições de pinos
; ==========================
.equ BOTAO_INVERTE = PD2  ; Define o botão de inversão no pino PD2

; ==========================
; Definição de registradores
; ==========================
.def AUX = R16        ; Registrador auxiliar
.def LED_INDEX = R17  ; Índice do LED aceso atualmente
.def DIRECAO = R18    ; 0 = LED se move para direita, 1 = LED se move para esquerda
.def TEMP = R19       ; Registrador auxiliar para operações lógicas

; ==========================
; Configuração inicial
; ==========================
setup:
    ldi AUX, 0xFF         ; Carrega 0xFF no registrador auxiliar (todos os bits em 1)
    out DDRB, AUX         ; Configura os pinos PB0-PB7 como saída (LEDs)

    ldi AUX, 0x00         ; Carrega 0x00 para garantir que todos os LEDs comecem apagados
    out PORTB, AUX        ; Apaga todos os LEDs

    cbi DDRD, BOTAO_INVERTE  ; Configura o pino PD2 como entrada (botão)
    sbi PORTD, BOTAO_INVERTE ; Ativa o resistor pull-up no botão (PD2)

    clr LED_INDEX         ; Inicializa o LED na posição 0 (PB0)
    clr DIRECAO           ; Define direção inicial como "para direita" (0)

    rjmp main             ; Pula para o loop principal

; ==========================
; Loop principal (movimentação do LED)
; ==========================
main:
    clr AUX               ; Limpa o registrador auxiliar
    ldi R20, 1            ; Define um LED inicial aceso (0b00000001)
    mov R21, LED_INDEX    ; Copia o índice do LED para R21

; Calcula qual LED deve estar aceso
loop_shift:
    cpi R21, 0            ; Se LED_INDEX for 0, não precisa deslocar
    breq led_setado       ; Se sim, pula para configurar o LED
    lsl R20               ; Desloca o bit para esquerda (próximo LED)
    dec R21               ; Decrementa contador para controlar deslocamento
    rjmp loop_shift       ; Continua deslocando até alcançar LED_INDEX

; Define o LED correspondente
led_setado:
    mov AUX, R20          ; Copia o valor final de R20 para AUX
    out PORTB, AUX        ; Atualiza os LEDs no PORTB

    ; Verifica se o botão foi pressionado
    sbic PIND, BOTAO_INVERTE  ; Se o botão NÃO for pressionado, pula a próxima instrução
    rjmp sem_alterar          ; Se não foi pressionado, segue normalmente

    ; Pequeno atraso para debounce
    ldi R20, 5  
    rcall delay  

    ; Garante que só altera a direção se o botão for solto
    sbic PIND, BOTAO_INVERTE  ; Se o botão ainda estiver pressionado, não altera
    rjmp sem_alterar  

    ldi TEMP, 1        ; Carrega 1 no registrador auxiliar TEMP
    eor DIRECAO, TEMP  ; Inverte o bit de direção (XOR lógico)

; Continuação do loop principal
sem_alterar:
    ldi R20, 8
    rcall delay        ; Atraso para controlar velocidade do LED

    tst DIRECAO        ; Testa o valor de DIRECAO (verifica se é 0 ou 1)
    breq mover_direita ; Se for 0, move para a direita
    rjmp mover_esquerda; Se for 1, move para a esquerda

; ==========================
; Movimentação do LED para a direita (PB0 → PB7)
; ==========================
mover_direita:
    inc LED_INDEX      ; Incrementa LED_INDEX (próximo LED)
    cpi LED_INDEX, 8   ; Verifica se atingiu PB7 (limite)
    brlt main          ; Se ainda não atingiu o fim, continua
    ldi LED_INDEX, 6   ; Se chegou ao final, define índice para PB6
    ldi DIRECAO, 1     ; Altera direção para "esquerda"
    rjmp main          ; Retorna ao loop principal

; ==========================
; Movimentação do LED para a esquerda (PB7 → PB0)
; ==========================
mover_esquerda:
    dec LED_INDEX      ; Decrementa LED_INDEX (LED anterior)
    brpl main          ; Se LED_INDEX ainda não for negativo, continua
    clr LED_INDEX      ; Se LED_INDEX for negativo, reinicia para PB0
    clr DIRECAO        ; Altera direção para "direita"
    rjmp main          ; Retorna ao loop principal

; ==========================
; Rotina de atraso (usada para debounce e controle da velocidade do LED)
; ==========================
delay:
    push R17           ; Salva o conteúdo de R17 na pilha
    push R18           ; Salva o conteúdo de R18 na pilha
    clr R17            ; Limpa R17
    clr R18            ; Limpa R18

loopdelay:
    dec R17            ; Decrementa R17
    brne loopdelay     ; Se R17 não for zero, continua
    dec R18            ; Decrementa R18
    brne loopdelay     ; Se R18 não for zero, continua
    dec R20            ; Decrementa R20
    brne loopdelay     ; Se R20 não for zero, continua

    pop R18            ; Restaura o valor original de R18
    pop R17            ; Restaura o valor original de R17
    ret                ; Retorna para o código principal
