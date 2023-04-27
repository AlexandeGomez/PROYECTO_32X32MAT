`timescale 1ns/1ns
module tb_rom_sp();

reg [8:0] addr_tb;
reg clk_tb;
wire [31:0] q_tb;

integer i;

single_port_rom #( .DATA_WIDTH(32),  .ADDR_WIDTH(8)) DUT_SPR
(
	.addr   (addr_tb),
	.clk    (clk_tb),

	.q      (q_tb)
);

initial begin
    clk_tb = 1'b0;
    #2;
    for(i=0; i<=8; i=i+1)
    begin
        addr_tb = i;
        #5;
    end
    $stop;
end

always #1 clk_tb = ~clk_tb;

endmodule