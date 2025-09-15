// Interrupção
;------------------------------------------------------------
;------------------------------------------------------------
; Definições de pinos e registradores
;------------------------------------------------------------
.equ BOTAO = PD2   ; Define o pino PD2 como "BOTAO" (entrada do botão)
.equ L0 = PB0      ; Define o pino PB0 como "L0" (LED 0)
.equ L1 = PB1      ; Define o pino PB1 como "L1" (LED 1)
.def AUX = R16     ; Define o registrador R16 como "AUX" para uso temporário

;------------------------------------------------------------
; Vetores de interrupção e reset
;------------------------------------------------------------
.ORG 0x0000        ; Endereço do vetor de reset (executado no início do programa)
  RJMP setup       ; Pula para a rotina de configuração do sistema

.ORG 0x0002        ; Endereço do vetor da interrupção INT0
  RJMP isr_int0    ; Pula para a rotina de interrupção INT0

.ORG 0x0034        ; Primeira posição de memória livre após os vetores de interrupção

;------------------------------------------------------------
; Rotina de configuração do microcontrolador
;------------------------------------------------------------
setup:
  ldi AUX,0x03     ; Carrega 0b00000011 em AUX (habilita PB0 e PB1 como saída)
  out DDRB,AUX     ; Configura PB0 e PB1 como saída
  out PORTB,AUX    ; Desliga os LEDs (PB0 e PB1 são setados para alto)

  cbi DDRD, BOTAO  ; Configura PD2 (botão) como entrada
  sbi PORTD, BOTAO ; Habilita resistor de pull-up interno para PD2

  ldi AUX, 0x01    ; Configura interrupção INT0 para ser acionada em borda de subida
  sts EICRA, AUX   ; Escreve o valor em EICRA (configuração de interrupção)
  sbi EIMSK, INT0  ; Habilita a interrupção externa INT0

  sei              ; Habilita interrupções globais (bit I do registrador SREG)

;------------------------------------------------------------
; Loop principal (pisca LED L0 a cada 1 segundo)
;------------------------------------------------------------
main:
  sbi PORTB,L0    ; Desliga L0 (PB0 alto)
  ldi r19, 80      ; Define tempo do delay (80 = 1s)
  rcall delay      ; Chama a sub-rotina de atraso

  cbi  PORTB,L0    ; Liga L0 (PB0 baixo)
  ldi r19, 80      ; Define tempo do delay (80 = 1s)
  rcall delay      ; Chama a sub-rotina de atraso

  rjmp main        ; Repete o loop principal indefinidamente

;------------------------------------------------------------
; Rotina de Interrupção INT0 (acionada pelo botão)
;------------------------------------------------------------
isr_int0:
  push R16         ; Salva o valor de R16 na pilha (para restaurar depois)
  in R16, SREG     ; Salva o estado do registrador de status (SREG) em R16
  push R16         ; Salva SREG na pilha

  sbic PIND,BOTAO  ; Verifica se o botão está pressionado (se não estiver, pula a próxima linha)
  rjmp desliga     ; Se o botão não está pressionado, pula para "desliga"

  cbi  PORTB,L1    ; Liga L1 (PB1 baixo, LED aceso)
  rjmp fim         ; Pula para "fim"

desliga:
  sbi  PORTB,L1    ; Desliga L1 (PB1 alto, LED apagado)

fim:
  pop R16          ; Restaura o valor de SREG da pilha
  out SREG,R16     ; Restaura SREG
  pop R16          ; Restaura o valor original de R16
  reti             ; Retorna da interrupção

;------------------------------------------------------------
; Sub-rotina de atraso programável
; O tempo de atraso depende do valor de R19 carregado antes da chamada.
; Exemplos:
; - R19 = 16 --> 200ms
; - R19 = 80 --> 1s
;------------------------------------------------------------
delay:           
  push r17         ; Salva os valores de R17,
  push r18         ; ... e R18
  in r17,SREG      ; Salva SREG
  push r17         ; Guarda SREG na pilha

  ; Executa um loop de atraso baseado em decrementos de registradores
  clr r17          ; Zera R17
  clr r18          ; Zera R18

loop:            
  dec  R17         ; Decrementa R17
  brne loop        ; Se R17 não for zero, continua o loop
  dec  R18         ; Decrementa R18
  brne loop        ; Se R18 não for zero, continua o loop
  dec  R19         ; Decrementa R19
  brne loop        ; Se R19 não for zero, continua o loop

  ; Restaura os registradores para evitar perda de dados
  pop r17         
  out SREG, r17    ; Restaura SREG
  pop r18          ; Restaura R18
  pop r17          ; Restaura R17

  ret              ; Retorna da sub-rotina de atraso
