read_verilog -netlist ../netlist/iir_filter.v
read_saif -input ../saif/iir_filter_syn.saif -instance tb_iir/UUT -unit ns -scale 1
create_clock -name MY_CLK clock
report_power > reports/power_report.txt
quit
