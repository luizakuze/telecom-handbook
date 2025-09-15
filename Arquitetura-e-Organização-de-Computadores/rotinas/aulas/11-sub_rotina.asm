// O programa demonstra o uso de uma sub-rotina.
// RCALL é usado para chamar "sub_rotina" e RET é usado para retornar ao ponto de chamada.
// Após isso o programa entra no RJMP e executa o programa indeterminadamente.

main:
    rcall sub_rotina
    rjmp main

sub_rotina:
    ;executa sub-rotina
    ret