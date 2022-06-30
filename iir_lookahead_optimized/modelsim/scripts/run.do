project compileall
vsim work.tb_iir -t ns
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 40 /tb_iir/CLK_i
add wave -noupdate -height 40 /tb_iir/RST_n_i
add wave -noupdate -height 40 /tb_iir/VIN_i
add wave -noupdate -height 40 -radix decimal /tb_iir/DIN_i
add wave -noupdate -height 40 -radix decimal /tb_iir/a1_i
add wave -noupdate -height 40 -radix decimal /tb_iir/a2_i
add wave -noupdate -height 40 -radix decimal /tb_iir/b0_i
add wave -noupdate -height 40 -radix decimal /tb_iir/b1_i
add wave -noupdate -height 40 -radix decimal /tb_iir/b2_i
add wave -noupdate -height 40 -radix decimal /tb_iir/DOUT_i
add wave -noupdate -height 40 /tb_iir/VOUT_i
add wave -noupdate -height 40 /tb_iir/END_SIM_i
add wave -noupdate -height 40 -radix decimal /tb_iir/UUT/q_reg1
add wave -noupdate -height 40 -radix decimal /tb_iir/UUT/outputpro/TMPq1_a1
add wave -noupdate -height 40 -radix decimal /tb_iir/UUT/outputpro/TMPq1_b1
add wave -noupdate -height 40 -radix decimal /tb_iir/UUT/q_reg2
add wave -noupdate -height 40 -radix decimal /tb_iir/UUT/outputpro/TMPq2_a2
add wave -noupdate -height 40 -radix decimal /tb_iir/UUT/outputpro/TMPq2_b2
add wave -noupdate -height 40 -radix decimal /tb_iir/UUT/outputpro/TMPtmpa_b0
add wave -noupdate -height 40 -radix decimal /tb_iir/UUT/outputpro/TMPa
add wave -noupdate -height 40 -radix decimal /tb_iir/UUT/outputpro/TMPb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {49 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 295
configure wave -valuecolwidth 213
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ns} {204 ns}
run 10 us