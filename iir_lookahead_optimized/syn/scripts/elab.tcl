proc elab {} {
source .synopsys_dc.setup
#adding elemts
analyze -f vhdl -lib WORK ../hdl/src/iir_filter.vhd
analyze -f vhdl -lib WORK ../hdl/src/reg.vhd
analyze -f vhdl -lib WORK ../hdl/src/ff.vhd
set power_preserve_rtl_hier_names true
elaborate IIR_FILTER -arch ARCH -lib WORK > ./elaborate.txt
#filter contains multiple instances of reg, need to uniquify
uniquify 
link
}
elab
