vlib rtl_work
vmap work rtl_work

vcom -93 -work work {../../gcd.vhdl}
vsim work.gcd(euclidean_algorithm) 

do wave_a2b.do

force -freeze sim:/gcd/reset 1 0, 0 20  
force -freeze sim:/gcd/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/gcd/start 0 0
 
# Multiplicação simples (10 * 2)
force -freeze sim:/gcd/a_in 10#10  
force -freeze sim:/gcd/c_in 10#2 
force -freeze sim:/gcd/start 1 0
run 3000  