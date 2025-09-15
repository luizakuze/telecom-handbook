vlib rtl_work
vmap work rtl_work
vcom -93 -work work {../../mem_ctrl.vhd}
vsim work.mem_ctrl(two_seg_arch)
add wave -position end  sim:/mem_ctrl/reset
add wave -position end  sim:/mem_ctrl/clk
add wave -position end  sim:/mem_ctrl/mem
add wave -position end  sim:/mem_ctrl/rw
add wave -position end  sim:/mem_ctrl/burst
add wave -position end  sim:/mem_ctrl/state_reg
add wave -position end  sim:/mem_ctrl/state_next
add wave -position end  sim:/mem_ctrl/oe
add wave -position end  sim:/mem_ctrl/we
add wave -position end  sim:/mem_ctrl/we_me
force -freeze sim:/mem_ctrl/reset 1 0, 0 20
force -freeze sim:/mem_ctrl/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/mem_ctrl/mem 0 0
force -freeze sim:/mem_ctrl/rw 0 0
force -freeze sim:/mem_ctrl/burst 0 0
run 500
force -freeze sim:/mem_ctrl/mem 1 0
run 500
force -freeze sim:/mem_ctrl/rw 1 0
run 500
force -freeze sim:/mem_ctrl/burst 1 0
run 1000
force -freeze sim:/mem_ctrl/rw 0 0
force -freeze sim:/mem_ctrl/burst 0 0
force -freeze sim:/mem_ctrl/mem 0 0
run 1000
force -freeze sim:/mem_ctrl/mem 1 0
force -freeze sim:/mem_ctrl/mem 1 0, 0 10, 1 15, 0 20, 1 24
run 200