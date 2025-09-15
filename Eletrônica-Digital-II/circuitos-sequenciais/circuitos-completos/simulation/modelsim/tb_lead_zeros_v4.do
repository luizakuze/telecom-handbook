vlib rtl_work
vmap work rtl_work
vcom -93 -work work {/home/luiza.k12/eld2/estudo_p1/refazendo-circuitos/circuitos-completos/ld_zeros.vhd}
vsim work.ld_zeros(ifsc_v4)

add wave -position end  sim:/ld_zeros/N
add wave -position end  sim:/ld_zeros/data
add wave -position end  sim:/ld_zeros/qt_zeros
force -freeze sim:/ld_zeros/data 0100 0
run 1000


