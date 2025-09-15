@ LED L0 (PB0): Pisca a cada 1 segundo. O LED L0 é alternado entre ligado e desligado a cada 1 segundo, continuamente.
@ LED L1 (PB1): Controlado pelo botão (PD3):
@ Quando o botão é pressionado (pino PD3 em nível baixo), o LED L1 é ligado.
@ Quando o botão é pressionado novamente, o LED L1 é desligado.
@ Interrupção (INT1): A interrupção externa (INT1) é configurada para detectar o pressionamento do botão e alternar o estado do LED L1.


\;DEFINIÇÕES
 .equ BOTAO = PD3
 .equ L0 = PB0
 .equ L1 = PB1
 .def AUX = R16

.ORG 0x0000 ; Reset vector
 RJMP setup

 .ORG 0x0004 ; Vetor (endereço na Flash) da INT1
 RJMP isr_int1

 .ORG 0x0034 ; primeira end. livre depois dos vetores
 setup:
 ldi AUX,0x03 ; 0b00000011
 out DDRB,AUX ; Configura PB3/2 como saída
 out PORTB,AUX ; Desliga os LEDs
 cbi DDRD, BOTAO ; Configura o PD3 como entrada
 sbi PORTD, BOTAO ; Liga o pull-up do PD3

 LDI AUX, 0b00000100 ;
 STS EICRA, AUX ; config. INT1 sensível a borda
 SBI EIMSK, INT1 ; habilita a INT1

 SEI ; habilita a interrup¸c~ao glo


 main:
 sbi PORTB,L0 ; Desliga L0
 ldi r19, 80
 rcall delay ; Delay 1s
 cbi PORTB,L0 ; Liga L0
 ldi r19, 80
 rcall delay ; Delay 1s
 rjmp main


 ;-------------------------------------------------
 ; Rotina de Interrupção (ISR) da INT1
 ;-------------------------------------------------
 isr_int1:
 push R16 ; Salva o contexto (SREG)
 in R16, SREG
 push R16

 sbic PIND,BOTAO ; botao pressionado -> Salta a próxima instrução
 rjmp desliga
 
 ; Intrução de ligar o LED;
 cbi PORTB,L1 ; Liga L1
 rjmp fim
 
 ; Instrução de desligar o LED;
 desliga:
 sbi PORTB,L1 ; Desliga L1

 ; Restaurar os valores e retornar de onde interrompeu; 
 fim:
 pop R16 ; Restaura o contexto (SREG)
 out SREG,R16
 pop R16
 reti ; retorna da interrupcao

;--------------------------------------------------------------
;SUB-ROTINA DE ATRASO Programavel
; Depende do valor de R19 carregado antes da chamada.
;--------------------------------------------------------------
delay: 
 ; Salva os valores dos registradores R17 e R18
 push r17 
 push r18 

 ; Salva os valores de SREG no registrador R17 para salva-lo
 in r17,SREG 
 push r17 
 
;Limpa o conteúdo do registrador R17 e R18
clr r17 
clr r18
 
loopdelay:
    
dec R17 ;decrementa R17, inicia em com 0x00
brne loopdelay ;enquanto R17 > 0 fica decrementando R17
dec R18 ;decrementa R18, inicia em com 0x00
brne loopdelay ;enquanto R18 > 0 volta decrementar R18
dec R19 ;decrementa R19
brne loopdelay ;enquanto R19 > 0 vai para volta o incio
    
; Restaura os valores de SREG,
pop r17
out SREG, r17

; Restaura os valores dos registradores R17 e R18
pop r18 
pop r17
    
ret