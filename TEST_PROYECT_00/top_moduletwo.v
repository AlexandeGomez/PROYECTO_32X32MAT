module top_moduletwo(
    input clk_top, rst_top,
    input signed [4:-27] a1_top,
    input signed [4:-27] a2_top,
    input signed [4:-27] b1_top,
    input signed [4:-27] b2_top,

    output signed [9:-22] a1b1_top,
    output signed [9:-22] a2b2_top,
    output signed [9:-22] a1b2_top,
    output signed [9:-22] a2b1_top,
    output signed [10:-21] ab_real_top,
    output signed [10:-21] ab_imag_top
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