onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /contador_bcd/clk
add wave -noupdate /contador_bcd/rst
add wave -noupdate /contador_bcd/en
add wave -noupdate -radix unsigned /contador_bcd/unidade
add wave -noupdate -radix unsigned /contador_bcd/dezena
add wave -noupdate /contador_bcd/fim_contagem
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {346 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1 ns}
