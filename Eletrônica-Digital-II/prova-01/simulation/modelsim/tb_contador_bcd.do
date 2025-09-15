vlib rtl_work
vmap work rtl_work
vcom -93 -work work {../../contador_bcd.vhd}
vsim work.contador_bcd(ifsc_v1)

do wave_contador_bcd.do

force -freeze sim:/contador_bcd/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/contador_bcd/rst 1 0, 0 20
force -freeze sim:/contador_bcd/en 1 0
run 5000

