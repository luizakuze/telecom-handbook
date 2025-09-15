transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {/home/luiza.k12/eld2/prova-03/A2B/teste/gdc_a2b_restored/gcd.vhdl}

