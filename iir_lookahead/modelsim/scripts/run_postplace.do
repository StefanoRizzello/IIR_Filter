project compileall
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_iir/UUT=../innovus/iir_filter.sdf work.tb_iir
vcd file ../vcd/design.vcd
vcd add /tb_iir/UUT/*
do wave.do
run 2 us
