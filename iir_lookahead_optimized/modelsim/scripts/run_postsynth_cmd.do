project new . $1.mpf
project addfile ../hdl/tb/clk_gen.vhd
project addfile ../hdl/tb/data_maker_new.vhd
project addfile ../hdl/tb/data_sink.vhd
project addfile ../hdl/tb/tb_iir.v
project addfile ../netlist/iir_filter.v
project compileall
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_iir/UUT=../netlist/iir_filter.sdf work.tb_iir
vcd file ../vcd/iir_filter_syn.vcd
vcd add /tb_iir/UUT/*
run 2 us
quit -sim
project close
quit
