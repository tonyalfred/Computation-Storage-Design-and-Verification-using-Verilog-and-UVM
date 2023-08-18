vlog -cover bcest rtl/comp_strg.v
vopt +acc=a work.comp_strg_tb -o dbgver
vsim -voptargs=+acc -assertdebug -msgmode both -coverage work.comp_strg_tb -logfile transcript.log

onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -position end sim:/comp_strg_tb/clk
add wave -position end sim:/comp_strg_tb/rst
add wave -position end sim:/comp_strg_tb/addA
add wave -position end sim:/comp_strg_tb/addB
add wave -position end sim:/comp_strg_tb/addC
add wave -position end sim:/comp_strg_tb/cmd
add wave -position end sim:/comp_strg_tb/en
add wave -position end sim:/comp_strg_tb/DQ
add wave -position end sim:/comp_strg_tb/valid_out

add wave -position end sim:/comp_strg_tb/dut/DQ_en
add wave -position end sim:/comp_strg_tb/dut/DQ_reg
add wave -position end sim:/comp_strg_tb/dut/valid_out_reg

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18884 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 152
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {61170 ps}

run -all