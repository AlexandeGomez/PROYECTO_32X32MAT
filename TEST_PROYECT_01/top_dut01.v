module top_dut01 #(parameter NDIR = 4, parameter NBIT=6)(
    input clk_top, 
    input rst_top,
    input we_top,
    input [3:0] addr_am1_top, 
    input [3:0] addr_bm1_top,
    input [3:0] addr_am2_top, 
    input [3:0] addr_bm2_top,
    input [1:0] addr_spram_real_top,
    input [1:0] addr_spram_imag_top,

    output signed [4:-27] a1_top,
    output signed [4:-27] a2_top,
    output signed [4:-27] b1_top,
    output signed [4:-27] b2_top,
    output signed [9:-22] a1b1_top,
    output signed [9:-22] a2b2_top,
    output signed [9:-22] a1b2_top,
    output signed [9:-22] a2b1_top,
    output signed [10:-21] ab_real_top,
    output signed [10:-21] ab_imag_top,
    output signed [10:-21] q_real_top,
	 output signed [10:-21] q_imag_top
);

single_port_ramM1 #(  .DATA_WIDTH(32),   .ADDR_WIDTH(4)) SPRAM_R(
	.data       (ab_real_top),
	.addr       (addr_spram_real_top),
	.we         (we_top), 
   .clk        (clk_top),
	.q          (q_real_top)
);

single_port_ramM1 #(  .DATA_WIDTH(32),   .ADDR_WIDTH(4)) SPRAM_I(
	.data       (ab_imag_top),
	.addr       (addr_spram_imag_top),
	.we         (we_top), 
   .clk 	      (clk_top),
	.q          (q_imag_top)
);

dual_port_romM1 #(  .DATA_WIDTH(NBIT),   .ADDR_WIDTH(NDIR)) DPROM_M1
(
	.addr_a     (addr_am1_top), 
    .addr_b     (addr_bm1_top),
	.clk        (clk_top), 
	.q_a        (a1_top), 
    .q_b        (a2_top)
);

dual_port_romM2 #(  .DATA_WIDTH(NBIT),   .ADDR_WIDTH(NDIR)) DPROM_M2
(
	.addr_a     (addr_am2_top), 
    .addr_b     (addr_bm2_top),
	.clk        (clk_top), 
	.q_a        (b1_top), 
    .q_b        (b2_top)
);


prodtwo PT(
    .clk    (clk_top), 
    .rst    (rst_top),
    .a1     (a1_top),
    .a2     (a2_top),
    .b1     (b1_top),
    .b2     (b2_top),

    .a1b1   (a1b1_top),
    .a2b2   (a2b2_top),
    .a1b2   (a1b2_top),
    .a2b1   (a2b1_top)
);

sumtwo ST(
    .clk    (clk_top), 
    .rst    (rst_top),
    .a1b1   (a1b1_top),
    .a2b2   (a2b2_top),
    .a1b2   (a1b2_top),
    .a2b1   (a2b1_top),

    .ab_real(ab_real_top),
    .ab_imag(ab_imag_top)
);

endmodule
