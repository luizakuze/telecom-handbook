vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/luiza.k12/eld2/aula-27/fsm.vhd}
vsim work.fsm(ifsc_v1)

add wave -position end  sim:/fsm/clk
add wave -position end  sim:/fsm/rst
add wave -position end  sim:/fsm/x
add wave -position end  sim:/fsm/y
add wave -position end  sim:/fsm/pr_state
add wave -position end  sim:/fsm/nx_state

force -freeze sim:/fsm/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/fsm/rst 1 0, 0 20

run
run

force -freeze sim:/fsm/x 1 0
run
run

force -freeze sim:/fsm/x 2 0
run
run

force -freeze sim:/fsm/x 1 0
run
run

force -freeze sim:/fsm/x 2 0
run
run


