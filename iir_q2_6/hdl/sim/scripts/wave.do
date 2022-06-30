onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /tb_iir/UUT/clock
add wave -noupdate -format Logic /tb_iir/UUT/rst_n
add wave -noupdate -format Literal /tb_iir/UUT/din
add wave -noupdate -format Literal /tb_iir/UUT/a1
add wave -noupdate -format Literal /tb_iir/UUT/a2
add wave -noupdate -format Literal /tb_iir/UUT/b0
add wave -noupdate -format Literal /tb_iir/UUT/b1
add wave -noupdate -format Literal /tb_iir/UUT/b2
add wave -noupdate -format Logic /tb_iir/UUT/vin
add wave -noupdate -format Literal /tb_iir/UUT/dout
add wave -noupdate -format Logic /tb_iir/UUT/vout
add wave -noupdate -format Literal /tb_iir/UUT/tmp_a_slv
add wave -noupdate -format Literal /tb_iir/UUT/q_reg1
add wave -noupdate -format Literal /tb_iir/UUT/q_reg2
add wave -noupdate -format Literal /tb_iir/UUT/din_s
add wave -noupdate -format Literal /tb_iir/UUT/a1_s
add wave -noupdate -format Literal /tb_iir/UUT/a2_s
add wave -noupdate -format Literal /tb_iir/UUT/b0_s
add wave -noupdate -format Literal /tb_iir/UUT/b1_s
add wave -noupdate -format Literal /tb_iir/UUT/b2_s
add wave -noupdate -format Literal /tb_iir/UUT/tmpq1_a1
add wave -noupdate -format Literal /tb_iir/UUT/tmpq2_a2
add wave -noupdate -format Literal /tb_iir/UUT/tmptmpa_b0
add wave -noupdate -format Literal /tb_iir/UUT/tmpq1_b1
add wave -noupdate -format Literal /tb_iir/UUT/tmpq2_b2
add wave -noupdate -format Literal /tb_iir/UUT/tmp_b_slv
add wave -noupdate -format Literal /tb_iir/UUT/tmpa
add wave -noupdate -format Literal /tb_iir/UUT/tmpb
add wave -noupdate -format Literal /tb_iir/UUT/dout_pad
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
update
WaveRestoreZoom {0 ns} {1 us}
