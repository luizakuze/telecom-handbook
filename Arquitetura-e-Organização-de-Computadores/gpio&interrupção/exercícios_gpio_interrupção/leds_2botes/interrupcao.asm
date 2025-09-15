.INCLUDE <m328Pdef.inc>  ; Inclui definições do ATmega328P, permitindo usar nomes como PD2 e PB0.

; ==========================
; Definições de pinos
; ==========================
.equ BOTAO_AUMENTAR = PD2  ; Botão de aumentar a velocidade (conectado ao pino PD2 - INT0)
.equ BOTAO_DIMINUIR = PD3  ; Botão de diminuir a velocidade (conectado ao pino PD3 - INT1)

; ==========================
; Definição de registradores
; ==========================
.def AUX = R16         ; Registrador auxiliar para operações temporárias
.def INDEX_ESQ = R17   ; Índice do LED da esquerda (de PB0 a PB7)
.def INDEX_DIR = R18   ; Índice do LED da direita (de PB7 a PB0)
.def DELAY = R19       ; Controla a velocidade da animação (quanto menor, mais rápido)

; ==========================
; Configuração inicial
; ==========================
setup:
    ldi AUX, 0xFF         ; Carrega 0xFF no registrador AUX (todos os bits 1)
    out DDRB, AUX         ; Configura todos os pinos PB0-PB7 como saída para os LEDs

    ldi AUX, 0x00         ; Carrega 0x00 no AUX (todos os bits 0)
    out PORTB, AUX        ; Apaga todos os LEDs no início

    ; Configura botões como entrada com pull-up ativado
    cbi DDRD, BOTAO_AUMENTAR  ; Define PD2 (botão +) como entrada
    cbi DDRD, BOTAO_DIMINUIR  ; Define PD3 (botão -) como entrada
    sbi PORTD, BOTAO_AUMENTAR ; Ativa resistor pull-up interno no botão +
    sbi PORTD, BOTAO_DIMINUIR ; Ativa resistor pull-up interno no botão -

    ; Configura interrupções externas para INT0 e INT1
    ldi AUX, 0b00001010   ; Configura interrupções para serem acionadas na borda de descida (quando o botão é pressionado)
    sts EICRA, AUX        ; Escreve no registrador EICRA para configurar INT0 e INT1
    sbi EIMSK, INT0       ; Habilita interrupção externa INT0 (botão +)
    sbi EIMSK, INT1       ; Habilita interrupção externa INT1 (botão -)

    sei                   ; Habilita interrupções globais

    ; Define posições iniciais dos LEDs
    ldi INDEX_ESQ, 0      ; LED esquerdo começa em PB0
    ldi INDEX_DIR, 7      ; LED direito começa em PB7
    ldi DELAY, 10         ; Define velocidade inicial

    rjmp main             ; Pula para o loop principal

; ==========================
; Loop principal
; ==========================
main:
    clr AUX               ; Limpa o registrador auxiliar

    ; ==============================
    ; Define o LED da esquerda (PB0 → PB7)
    ; ==============================
    ldi R20, 1            ; Carrega o valor 1 (0b00000001) no R20
    mov R21, INDEX_ESQ    ; Copia INDEX_ESQ para R21
loop_shift_esq:
    cpi R21, 0            ; Se INDEX_ESQ for 0, o bit já está na posição correta
    breq led_esq_done     
    lsl R20               ; Desloca o bit para a esquerda (PB0 → PB7)
    dec R21               ; Decrementa R21 para contar quantas vezes o bit foi deslocado
    rjmp loop_shift_esq   ; Repete o deslocamento até atingir INDEX_ESQ
led_esq_done:
    or AUX, R20           ; Faz OR com AUX para acender o LED esquerdo

    ; ==============================
    ; Define o LED da direita (PB7 → PB0)
    ; ==============================
    ldi R20, 0b10000000   ; Começa no PB7 (0b10000000)
    mov R21, INDEX_DIR    ; Copia INDEX_DIR para R21
loop_shift_dir:
    cpi R21, 7            ; Se INDEX_DIR for 7, o bit já está na posição correta
    breq led_dir_done     
    lsr R20               ; Desloca o bit para a direita (PB7 → PB0)
    inc R21               ; Incrementa R21 para contar quantas vezes o bit foi deslocado
    rjmp loop_shift_dir   ; Repete o deslocamento até atingir INDEX_DIR
led_dir_done:
    or AUX, R20           ; Faz OR com AUX para acender o LED direito

    out PORTB, AUX        ; Atualiza LEDs no PORTB

    ; ==============================
    ; Aguarda antes de avançar para o próximo LED
    ; ==============================
    ldi R20, 10           ; Define quantidade de ciclos de delay
    rcall delay1          ; Chama a rotina de atraso

    inc INDEX_ESQ         ; Move LED esquerdo para frente (PB0 → PB7)
    dec INDEX_DIR         ; Move LED direito para trás (PB7 → PB0)

    cpi INDEX_ESQ, 7      ; Se INDEX_ESQ alcançar o índice 7...
    breq reset            ; ... reinicia a animação

    rjmp main             ; Volta para o início do loop principal

; ==========================
; Reinicia a animação
; ==========================
reset:
    ldi INDEX_ESQ, 0      ; Reinicia LED esquerdo em PB0
    ldi INDEX_DIR, 7      ; Reinicia LED direito em PB7
    rjmp main             ; Retorna ao loop principal

; ==========================
; Interrupção para aumentar velocidade (botão +)
; ==========================
isr_int0:
    subi DELAY, 2         ; Reduz o valor do delay (aumenta a velocidade)
    reti                  ; Retorna da interrupção

; ==========================
; Interrupção para diminuir velocidade (botão -)
; ==========================
isr_int1:
    subi DELAY, -2        ; Aumenta o valor do delay (diminui a velocidade)
    reti                  ; Retorna da interrupção

; ==========================
; Rotina de atraso (delay)
; ==========================
delay1:
    push R17              ; Salva o registrador R17 na pilha
    push R18              ; Salva o registrador R18 na pilha
    clr R17               ; Zera R17
    clr R18               ; Zera R18

loopdelay:
    dec R17               ; Decrementa R17
    brne loopdelay        ; Se R17 não for zero, continua no loop
    dec R18               ; Decrementa R18
    brne loopdelay        ; Se R18 não for zero, continua no loop
    dec R20               ; Decrementa R20
    brne loopdelay        ; Se R20 não for zero, continua no loop

    pop R18               ; Restaura R18 da pilha
    pop R17               ; Restaura R17 da pilha
    ret                   ; Retorna da sub-rotina
