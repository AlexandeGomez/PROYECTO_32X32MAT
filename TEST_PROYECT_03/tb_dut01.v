`timescale 1ps/1ps
module tb_dut01();

reg clk_tb; 
reg rst_tb;
reg we_tb;
reg ena_tb;
reg [3:0] addr_am1_tb; 
reg [3:0] addr_bm1_tb;
reg [3:0] addr_am2_tb; 
reg [3:0] addr_bm2_tb;

wire flag_tb;
wire clkslow_tb;
wire signed [10:-21] acc_tb;
wire signed [4:-27] a1_tb;
wire signed [4:-27] a2_tb;
wire signed [4:-27] b1_tb;
wire signed [4:-27] b2_tb;
wire signed [9:-22] a1b1_tb;
wire signed [9:-22] a2b2_tb;
wire signed [9:-22] a1b2_tb;
wire signed [9:-22] a2b1_tb;
wire signed [10:-21] ab_real_tb;
wire signed [10:-21] ab_imag_tb;

integer i,j,h;
integer k,l;
integer file;

top_dut01 #(  .NDIR(4),  .NBIT(32)) DUT(
    .clk_top        (clk_tb),
    .rst_top        (rst_tb),
    .we_top         (we_tb),
    .ena_top        (ena_tb),
    .addr_am1_top   (addr_am1_tb), 
    .addr_bm1_top   (addr_bm1_tb),
    .addr_am2_top   (addr_am2_tb),
    .addr_bm2_top   (addr_bm2_tb),

    .flag_top       (flag_tb),
	 .clkslow_top	  (clkslow_tb),
    .acc_top        (acc_tb),
    .a1_top         (a1_tb),
    .a2_top         (a2_tb),
    .b1_top         (b1_tb),
    .b2_top         (b2_tb),
    .a1b1_top       (a1b1_tb),
    .a2b2_top       (a2b2_tb),
    .a1b2_top       (a1b2_tb),
    .a2b1_top       (a2b1_tb),
    .ab_real_top    (ab_real_tb),
    .ab_imag_top    (ab_imag_tb)
);

initial begin
    clk_tb = 1'b0;
    rst_tb = 1'b1;
    
    #3 rst_tb = 1'b0;
    #3 rst_tb = 1'b1;

    #5000 $stop;
end

initial begin
    #16;
    for(i=0; i<2; i=i+1) 
    begin
        for(h=0; h<2; h=h+1)
        begin
            for(j=0; j<2; j=j+1)
            begin
				@(posedge clkslow_tb)
                addr_am1_tb = 2*j+4*i;
                addr_bm1_tb = ((2*(j+1))-1)+4*i;
                #35;
            end
        end
    end
end

initial begin
    #16;
    for(l=0; l<2; l=l+1) 
    begin
        for(k=0; k<=3; k=k+1)
        begin
		    @(posedge clkslow_tb)
			ena_tb <= 1'b1;
            addr_am2_tb = 2*k;
            addr_bm2_tb = (2*(k+1))-1;
            #35 ena_tb <= 1'b0;
        end
    end
end

initial begin
    file = $fopen("output.txt", "w");
    if(file==0) $display("Error");
    else begin
        while(1) begin
			@(posedge clkslow_tb)
			#10;
			@(flag_tb == 1'b1)
			$fwrite(file, "%b\n", acc_tb);
		  end
    end
    $fclose(file);
end

always#1 clk_tb = ~clk_tb;

endmodule
