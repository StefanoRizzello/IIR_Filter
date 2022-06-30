//`timescale 1ns

module tb_iir ();

  wire CLK_i;
  wire RST_n_i;
  wire VIN_i;
  wire [8:0] DIN_i;
  wire [8:0] c1_i;
  wire [8:0] c2_i;
  wire [8:0] d0_i;
  wire [8:0] d1_i;
  wire [8:0] d2_i;
  wire [8:0] d3_i;
  wire [8:0] DOUT_i;
  wire VOUT_i;
  wire END_SIM_i;

  clk_gen CG(.END_SIM(END_SIM_i),
             .CLK(CLK_i),
             .RST_n(RST_n_i));

  data_maker SM(.CLK(CLK_i),
                .RST_n(RST_n_i),
                .VOUT(VIN_i),
                .DOUT(DIN_i),
                .d0(d0_i),
                .d1(d1_i),
                .d2(d2_i),
                .d3(d3_i),
                .c1(c1_i),
		.c2(c2_i),
		.END_SIM(END_SIM_i));

  iir_filter UUT(
               .clock (CLK_i),
               .rst_n (RST_n_i),
               .din (DIN_i),
               .d0(d0_i),
               .d1(d1_i),
               .d2(d2_i),
               .d3(d3_i),
               .c1(c1_i),
	       .c2(c2_i),
               .vin (VIN_i),
               .dout (DOUT_i),
               .vout  ( VOUT_i));


  data_sink DS(.CLK(CLK_i),
               .RST_n(RST_n_i),
               .VIN(VOUT_i),
               .DIN(DOUT_i));

endmodule


