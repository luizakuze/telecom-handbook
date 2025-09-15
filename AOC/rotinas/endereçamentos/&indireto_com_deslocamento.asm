# Endereçamento Indireto com Deslocamento

; Sintaxe: Indireto com Deslocamento
## Sintaxe: "ldd Rd, index+q" ; Rd ← (index + q)
## Sintaxe: "std index+q", Rr ; (index + q) ← Rr


ldi r29, 0x01  
ldi r28, 0x00  
inc r0
std Y+2, r0 ; Y = 0x0100 "+2" = 0x0102
inc r0
std Y+3, r0 ; Y  agora tem a posição 0x0102 + 3, então é o endereço 0x0105