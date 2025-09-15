vlib rtl_work
vmap work rtl_work
vcom -93 -work work {../../right_reg.vhd}
vsim work.right_reg(ifsc_v1)
add wave -position end  sim:/right_reg/N
add wave -position end  sim:/right_reg/clk
add wave -position end  sim:/right_reg/rst
add wave -position end  sim:/right_reg/d
add wave -position end  sim:/right_reg/q
add wave -position end  sim:/right_reg/r_reg
add wave -position end  sim:/right_reg/r_next
force -freeze sim:/right_reg/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/right_reg/rst 1 0, 0 20
force -freeze sim:/right_reg/d 1 0
run 1000


