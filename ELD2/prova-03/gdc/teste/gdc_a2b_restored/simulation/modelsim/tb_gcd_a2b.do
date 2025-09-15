vlib rtl_work
vmap work rtl_work

vcom -93 -work work {../../gcd.vhdl}
vsim work.gcd(euclidean_algorithm) 
#vsim work.gcd(slow_arch)
#vsim work.gcd(fast_arch)


# Incluir o wave para a respectiva arquitetura:

# 1) Slow / Fast
#do wave_a2a.do

# 2) Euclidean
do wave_a2b.do 



force -freeze sim:/gcd/reset 1 0, 0 20  
force -freeze sim:/gcd/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/gcd/start 0 0


# Incluir valores de entrada para a respectiva arquitetura:

# 1) Euclidean

## Multiplicação (10 * 2) -> EUCLIDEAN
#force -freeze sim:/gcd/a_in 10#10  
#force -freeze sim:/gcd/c_in 10#2 
#force -freeze sim:/gcd/start 1 0
#run 3000   
#
#force -freeze sim:/gcd/start 0 0

## Multiplicação (50 * 3) -> EUCLIDEAN
#force -freeze sim:/gcd/a_in 10#50
#force -freeze sim:/gcd/c_in 10#3
#force -freeze sim:/gcd/start 1 0
#run 8000

### Multiplicação (130 * 115) -> EUCLIDEAN 
#force -freeze sim:/gcd/a_in 10#130
#force -freeze sim:/gcd/c_in 10#115
#force -freeze sim:/gcd/start 1 0
#run 8000
 
## Multiplicação (140 * 56) -> EUCLIDEAN 
#force -freeze sim:/gcd/a_in 10#140
#force -freeze sim:/gcd/c_in 10#56
#force -freeze sim:/gcd/start 1 0
#run 8000  
 
# Multiplicação (11 * 3) -> EUCLIDEAN 
force -freeze sim:/gcd/a_in 10#11
force -freeze sim:/gcd/c_in 10#3
force -freeze sim:/gcd/start 1 0
run 8000  


# 2) Slow / Fast


### Multiplicação (130 * 115) -> SLOW/FAST 
#force -freeze sim:/gcd/a_in 10#130
#force -freeze sim:/gcd/b_in 10#115
#force -freeze sim:/gcd/start 1 0
#run 8000
#
## Multiplicação (140 * 56) -> SLOW/FAST 
#force -freeze sim:/gcd/a_in 10#140
#force -freeze sim:/gcd/b_in 10#56
#force -freeze sim:/gcd/start 1 0
#run 8000  
##  