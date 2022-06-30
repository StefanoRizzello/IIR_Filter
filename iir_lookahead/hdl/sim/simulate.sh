source /software/scripts/init_msim6.2g
cd hdl/sim/
vlib work
vsim -c -do "do scripts/run_cmd.do iir_7bit_nopipe"
