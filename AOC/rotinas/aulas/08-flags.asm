// Verifica se um número é maior ou igual a outro
// Se for maior ou igual -> greater_or_equal
// Se for menor -> less_than
ldi r16, -5          ; r16 = -5
ldi r17, 3           ; r17 = 3
cp r16, r17          ; Compara r16 - r17 (subtração: -5 - 3 = -8)

brge greater_or_equal ; Desvia se r16 >= r17
brlt less_than        ; Desvia se r16 < r17

greater_or_equal:
    ; Código para r16 >= r17
    rjmp end
less_than:
    ; Código para r16 < r17
    rjmp end
end:
    ; Código final


//////////////////////////////////////////
//////////////////////////////////////////


// Verifica se um número é maior ou igual que outro (continue)
// Caso seja menor, incrementa o contador e continua o loop (loop)
// BRLT - Se é menor

ldi r16, 10         ; Inicializa r16 com 10 (número positivo)
ldi r17, 0          ; Inicializa r17 como contador

loop:
    cp r17, r16     ; Compara r17 - r16
    brlt continue   ; Se r17 < r16, continua o loop

    rjmp end        ; Sai do loop se r17 >= r16

continue:
    inc r17         ; Incrementa o contador
    rjmp loop       ; Volta para o início do loop

end:
    ; Fim do código