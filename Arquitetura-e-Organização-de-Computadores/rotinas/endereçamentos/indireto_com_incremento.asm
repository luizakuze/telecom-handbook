.DSEG
.ORG SRAM_START
A: .BYTE 1
B: .BYTE 1
C: .BYTE 1

.CSEG
start:

ldi XH, HIGH(A) 
ldi XL, LOW(A)

ld r0, X+
ld r1, X+

add r0, r1
    
rjmp start