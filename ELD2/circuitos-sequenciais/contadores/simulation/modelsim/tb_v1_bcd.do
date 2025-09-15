vlib rtl_work
vmap work rtl_work
vcom -93 -work work {/home/luiza.k12/eld2/estudo_p1/refazendo-circuitos/contadores/c_bcd.vhd}
vsim work.c_bcd(ifsc_v1)

add wave -position end  sim:/c_bcd/N_BITS
add wave -position end  sim:/c_bcd/MAX_VALUE
add wave -position end  sim:/c_bcd/clk
add wave -position end  sim:/c_bcd/rst
add wave -position end  sim:/c_bcd/d1
add wave -position end  sim:/c_bcd/d10
add wave -position end  sim:/c_bcd/d100
force -freeze sim:/c_bcd/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/c_bcd/rst 1 0, 0 1
run 4000


