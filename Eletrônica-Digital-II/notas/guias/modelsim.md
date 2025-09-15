## Testbench - Modelsim 

- Comando para executar: ``do tb_XXXX.do``

### Modelo tb_XXXX.do
```vhd
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/../../nand_gate.vhd}

vsim work.nand_gate(ifsc_v1)

do wave.do

add wave -position end sim:/nand_gate/a 
add wave -position end sim:/nand_gate/b
add wave -position end sim:/nand_gate/x

force -freeze sim:/nand_gate/a 0 0, 1 1min, 0 2min, 1 3min -r 5min
force -freeze sim:/nand_gate/b 0 0, 1 2min -r 7min
run 1hr
```

---

## Função Individual dos Comandos

### Configuração do Ambiente

- Criação de biblioteca e mapeamento
  - `vlib rtl_work`
  - `vmap work rtl_work`

### Compilação e Simulação do Design VHDL

- Compilação do arquivo VHDL da porta NAND
  - `vcom -93 -work work {/home/luiza.k12/eld2/nand_gate/nand_gate.vhd}`
  <!--- Use este comando se o caminho correto for este: `vcom -93 -work work {../../nand_gate.vhd}` -->

- Inicialização da simulação
  - `vsim work.nand_gate(ifsc_v1)`

### Configuração das Formas de Onda

- Adiciona sinais à janela de formas de onda
  - `add wave -position end sim:/nand_gate/a`
  - `add wave -position end sim:/nand_gate/b`
  - `add wave -position end sim:/nand_gate/x`

### Simulação com Estímulos

- Define estímulos para o sinal 'a' da porta NAND
  - `force -freeze sim:/nand_gate/a 0 0, 1 1min, 0 2min, 1 3min -r 5min`
- Define estímulos para o sinal 'b' da porta NAND
  - `force -freeze sim:/nand_gate/b 0 0, 1 2min -r 7min`
- Executa a simulação por 1 hora
  - `run 1hr`
