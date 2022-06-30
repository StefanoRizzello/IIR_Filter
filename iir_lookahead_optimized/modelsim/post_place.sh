source /software/scripts/init_msim6.2g
cd modelsim/
vlib work
vsim -c -do "do scripts/run_postplace_cmd.do iir_filter_optimized_postplace"
