project compileall
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_iir/UUT=../netlist/iir_filter.sdf work.tb_iir
vcd file ../vcd/iir_filter_syn.vcd
vcd add /tb_iir/UUT/*
do wave.do
run 2 us
