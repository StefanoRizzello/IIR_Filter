//`timescale 1ns

module tb_iir ();

  wire CLK_i;
  wire RST_n_i;
  wire VIN_i;
  wire [8:0] DIN_i;
  wire [8:0] a1_i;
  wire [8:0] c2_i;
  wire [8:0] c3_i;
  wire [8:0] b0_i;
  wire [8:0] b1_i;
  wire [8:0] b2_i;
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
		.a1(a1_i),
                .b0(b0_i),
                .b1(b1_i),
                .b2(b2_i),
                .c2(c2_i),
		.c3(c3_i),
		.END_SIM(END_SIM_i));

  iir_filter UUT(
               .clock (CLK_i),
               .rst_n (RST_n_i),
               .din (DIN_i),
	       .a1(a1_i),
               .b0(b0_i),
               .b1(b1_i),
               .b2(b2_i),
               .c2(c2_i),
	       .c3(c3_i),
               .vin (VIN_i),
               .dout(DOUT_i),
               .vout( VOUT_i));


  data_sink DS(.CLK(CLK_i),
               .RST_n(RST_n_i),
               .VIN(VOUT_i),
               .DIN(DOUT_i));

endmodule


