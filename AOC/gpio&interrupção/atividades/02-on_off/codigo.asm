@ Simular um circuito com dois botões, ON (PD2) e OFF (PD3), e dois LEDs, L0 (PB0) e o L1 (PB1).

@ Utilizando interrupção externa, implementar um sistema com o seguinte comportamento:

@ Piscar o L0 a cada 2s;
@ Quando o botão ON for pressionado, o L1 deve ligar;
@ Quando o botão OFF for pressionado, o L1 deve desligar.


;------------------------------------------------------------
; Definições de pinos e registradores
;------------------------------------------------------------
.equ BOTAO_ON  = PD2  ; Define o pino PD2 como "BOTAO_ON" (entrada do botão ON)
.equ BOTAO_OFF = PD3  ; Define o pino PD3 como "BOTAO_OFF" (entrada do botão OFF)
.equ L0 = PB0         ; Define o pino PB0 como "L0" (LED 0)
.equ L1 = PB1         ; Define o pino PB1 como "L1" (LED 1)
.def AUX = R16        ; Define o registrador R16 como "AUX" para uso temporário

;------------------------------------------------------------
; Vetores de interrupção e reset
;------------------------------------------------------------
.ORG 0x0000        ; Endereço do vetor de reset
  RJMP setup       ; Pula para a rotina de configuração

.ORG 0x0002        ; Endereço do vetor da interrupção INT0 (BOTAO_ON)
  RJMP isr_on      ; Pula para a rotina de interrupção do botão ON

.ORG 0x0004        ; Endereço do vetor da interrupção INT1 (BOTAO_OFF)
  RJMP isr_off     ; Pula para a rotina de interrupção do botão OFF

.ORG 0x0034        ; Primeira posição de memória livre após os vetores

;------------------------------------------------------------
; Rotina de configuração
;------------------------------------------------------------
setup:
  ldi AUX, 0x03      ; Configura PB0 e PB1 como saída
  out DDRB, AUX      
  out PORTB, AUX     ; Desliga os LEDs

  cbi DDRD, BOTAO_ON  ; Configura PD2 como entrada
  sbi PORTD, BOTAO_ON ; Ativa pull-up interno para PD2

  cbi DDRD, BOTAO_OFF ; Configura PD3 como entrada
  sbi PORTD, BOTAO_OFF ; Ativa pull-up interno para PD3

  //ldi AUX, 0x05     ; Configura INT0 e INT1 para borda de subida
  ldi AUX, 0b000_1010 ; Configura INT0 e INT1 para borda de descida
  sts EICRA, AUX
  sbi EIMSK, INT0     ; Habilita interrupção externa INT0
  sbi EIMSK, INT1     ; Habilita interrupção externa INT1

  sei                 ; Habilita interrupções globais

;------------------------------------------------------------
; Loop principal (Pisca LED L0 a cada 2 segundos)
;------------------------------------------------------------
main:
  sbi  PORTB,L0   ; Desliga L0 (PB0 alto)
  ldi r19, 160    ; Define tempo do delay (160 = 2s)
  rcall delay     

  cbi  PORTB,L0   ; Liga L0 (PB0 baixo)
  ldi r19, 160    ; Define tempo do delay (160 = 2s)
  rcall delay     

  rjmp main       ; Repete o loop principal

;------------------------------------------------------------
; Rotina de Interrupção INT0 (Botão ON)
;------------------------------------------------------------
isr_on:
  push R16        
  in R16, SREG    
  push R16       

  cbi PORTB,L1    ; Liga L1 (PB1 baixo)

  pop R16        
  out SREG,R16   
  pop R16        
  reti           

;------------------------------------------------------------
; Rotina de Interrupção INT1 (Botão OFF)
;------------------------------------------------------------
isr_off:
  push R16        
  in R16, SREG    
  push R16       

  sbi PORTB,L1    ; Desliga L1 (PB1 alto)

  pop R16        
  out SREG,R16   
  pop R16        
  reti           

;------------------------------------------------------------
; Sub-rotina de atraso programável
;------------------------------------------------------------
delay:            
  push r17         
  push r18         
  in r17,SREG      
  push r17         

  clr r17          
  clr r18          

loop:            
  dec  R17         
  brne loop        
  dec  R18         
  brne loop        
  dec  R19         
  brne loop        

  pop r17         
  out SREG, r17   
  pop r18         
  pop r17         

  ret
