//`timescale 1ns

module tb_fir ();

   wire CLK_i;
   wire RST_n_i;
   wire VIN_i;
   wire [7:0] DIN3k_i;
   wire [7:0] DIN3k1_i;
   wire [7:0] DIN3k2_i;
   wire [7:0] H0_i;
   wire [7:0] H1_i;
   wire [7:0] H2_i;
   wire [7:0] H3_i;
   wire [7:0] H4_i;
   wire [7:0] H5_i;
   wire [7:0] H6_i;
   wire [7:0] H7_i;
   wire [7:0] H8_i;
   wire [7:0] H9_i;
   wire [7:0] H10_i;
   wire [7:0] DOUT3k_i;
   wire [7:0] DOUT3k1_i;
   wire [7:0] DOUT3k2_i;
   wire VOUT_i;
   wire END_SIM_i;

   clk_gen CG(.END_SIM(END_SIM_i),
  	      .CLK(CLK_i),
	      .RST_n(RST_n_i));

   data_maker SM(.CLK(CLK_i),
	         .RST_n(RST_n_i),
		 .VOUT(VIN_i),
		 .DOUT3k(DIN3k_i),
		 .DOUT3k1(DIN3k1_i),
		 .DOUT3k2(DIN3k2_i),
		 .H0(H0_i),
		 .H1(H1_i),
		 .H2(H2_i),
		 .H3(H3_i),
		 .H4(H4_i),
		 .H5(H5_i),
		 .H6(H6_i),
		 .H7(H7_i),
		 .H8(H8_i),
		 .H9(H9_i),
		 .H10(H10_i),
		 .END_SIM(END_SIM_i));

   parallel_fir UUT(.CLK(CLK_i),
	     .RST_n(RST_n_i),
	     .VIN(VIN_i),
             .IN3k(DIN3k_i),
             .IN3k1(DIN3k1_i),
             .IN3k2(DIN3k2_i),
			 .H0(H0_i),
			 .H1(H1_i),
			 .H2(H2_i),
			 .H3(H3_i),
			 .H4(H4_i),
			 .H5(H5_i),
			 .H6(H6_i),
			 .H7(H7_i),
			 .H8(H8_i),
			 .H9(H9_i),
			 .H10(H10_i),
             .OUT3k(DOUT3k_i),
             .OUT3k1(DOUT3k1_i),
             .OUT3k2(DOUT3k2_i),
             .VOUT(VOUT_i));

   data_sink DS(.CLK(CLK_i),
		.RST_n(RST_n_i),
		.VIN(VOUT_i),
		.DIN3k(DOUT3k_i),
		.DIN3k1(DOUT3k1_i),
		.DIN3k2(DOUT3k2_i));   

endmodule

		   
