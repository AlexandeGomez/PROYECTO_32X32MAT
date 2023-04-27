`timescale 1ns/1ns
module tb_top_moduletwo();

reg clk_tb, rst_tb;
reg signed [4:-27] a1_tb;
reg signed [4:-27] a2_tb;
reg signed [4:-27] b1_tb;
reg signed [4:-27] b2_tb;

wire signed [9:-22] a1b1_tb;
wire signed [9:-22] a2b2_tb;
wire signed [9:-22] a1b2_tb;
wire signed [9:-22] a2b1_tb;
wire signed [10:-21] ab_real_tb;
wire signed [10:-21] ab_imag_tb;


top_moduletwo TOP_DUT(
    .clk_top    (clk_tb),
    .rst_top    (rst_tb),
    .a1_top     (a1_tb),
    .a2_top     (a2_tb),
    .b1_top     (b1_tb),
    .b2_top     (b2_tb),

    .a1b1_top   (a1b1_tb),
    .a2b2_top   (a2b2_tb),
    .a1b2_top   (a1b2_tb),
    .a2b1_top   (a2b1_tb),
    .ab_real_top(ab_real_tb),
    .ab_imag_top(ab_imag_tb)
);

initial 
begin    
    clk_tb = 1'b0;
    rst_tb = 1'b1;
    a1_tb = 32'b11001111100000101100011011100010;
    a2_tb = 32'b10101001100110110010010011101000;
    b1_tb = 32'b11000111011110100101101010001010;
    b2_tb = 32'b11001111111111111001110000101110;
    #10 rst_tb = 1'b0;
    #1 rst_tb = 1'b1;
    
	 $display ("Real part = %b", ab_real_tb);
	 
    #100 $stop;
end

always#1 clk_tb = ~clk_tb;

endmodule
