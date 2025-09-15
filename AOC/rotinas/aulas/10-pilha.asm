// Programa carrega dois registradores com valores e os salva na pilha. 
// Em seguida, os recupera da pilha invertendo a ordem de salvamento.

// Inicialmente: r16 = 0x01 e r17 = 0x02 (valores originais, sem alteração)
// Após o push: r16 = 0x01 e r17 = 0x02 (valores originais, só que salvos na pilha)
// Após o pop: r16 = 0x02 e r17 = 0x01 (troca de valores, recuperados da pilha)


ldi r16,0x01 ; carrega r16 com 0x01 
ldi r17,0x02 ; carrega r17 com 0x02

push r16 ; salva r16 na pilha (última posição: 0x08FF)
push r17 ; salva r17 na pilha (penúltima posição: 0x08FE)

pop r16 ; restaura r17 da pilha (penúltima posição: 0x08FE)
pop r17; restaura r16 da pilha (última posição: 0x08FF)