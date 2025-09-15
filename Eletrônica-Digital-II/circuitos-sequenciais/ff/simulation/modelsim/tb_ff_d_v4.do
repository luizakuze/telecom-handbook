 vlib rtl_work
 vmap work rtl_work
 vcom -93 -work work {../../ff_d.vhd}
 
vsim work.ff_d(ff_v4)
 
add wave -position end  sim:/ff_d/N
add wave -position end  sim:/ff_d/clk
add wave -position end  sim:/ff_d/rst
add wave -position end  sim:/ff_d/q2
add wave -position end  sim:/ff_d/d2
force -freeze sim:/ff_d/clk 1 0, 0 {10 ps} -r 40 
force -freeze sim:/ff_d/rst 1 0, 0 1
force -freeze sim:/ff_d/d2 00000000 0 
run 300 



force -freeze sim:/ff_d/d2 11111111
run 300 
force -freeze sim:/ff_d/d2 00001111
run 300 