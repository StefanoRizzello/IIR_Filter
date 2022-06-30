project new . $1.mpf
project addfile ../src/iir_filter.vhd
project addfile ../src/reg.vhd
project addfile ../src/ff.vhd
project addfile ../tb/clk_gen.vhd
project addfile ../tb/data_maker_new.vhd
project addfile ../tb/data_sink.vhd
project addfile ../tb/tb_iir.v
project compileall
vsim work.tb_iir -t ns
run 2 us
quit -sim
project close
quit
