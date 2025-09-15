.INCLUDE <m328Pdef.inc>

setup:
sbi DDRB, PB5 ;configura o pino PB5 como saída

loop:
cbi PORTB, PB5 ;coloca o pino PB5 em 0V

rjmp loop