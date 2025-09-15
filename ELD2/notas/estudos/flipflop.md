# Notas de Aula

## Flip-Flops e Latches
- Não utilizar latch.
- Utilizar flip-flops do tipo D.

## Para utilizar flip-flops
1) Declarar o tipo de dado como std_logic.
2) Escrever o código do flip-flop.
3) Utilizar a borda de clock, por exemplo, rising_edge.

## Processo em VHDL
- O processo em VHDL é concorrente com outros processos na arquitetura.
- Dentro do processo, o código é sequencial.
- Estruturas como if são sequenciais.
- Utilizar with select, when else para construções concorrentes.

## Habilitar Sugestões Automáticas
- ``Tools > Options > Text Editor > Autocomplete Text`` 

## Incluir Bibliotecas
- `Insert Template > VHDL > Constructs > Design Units > Use Clause`
