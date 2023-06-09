`timescale 1ns/1ns
module tb_dut();

parameter ANCHO_PALABRA=32;
parameter DIM = 3;

integer  i;
integer fileR1, fileI1, fileR;
integer fileR2, fileI2;

reg clk_fast_tb;
reg rst_tb;
reg we_tb; //escribir en las memorias RAM
//reg enaAcum_tb; //retener dato en el acumulador
//reg enaGene_tb; //generar la siguiente direccion de memoria
reg signal_tb;
reg [(ANCHO_PALABRA-1) :0] dataRAM_R1_tb;
reg [(ANCHO_PALABRA-1) :0] dataRAM_I1_tb;
reg [(ANCHO_PALABRA-1) :0] dataRAM_R2_tb;
reg [(ANCHO_PALABRA-1) :0] dataRAM_I2_tb;
reg [$clog2(DIM*DIM-1) :0] write_addr_R1_tb;
reg [$clog2(DIM*DIM-1) :0] write_addr_I1_tb;
reg [$clog2(DIM*DIM-1) :0] write_addr_R2_tb;
reg [$clog2(DIM*DIM-1) :0] write_addr_I2_tb;

wire signalGenAddr_tb;
wire signalAcum_tb;
wire signed [4:-27] a1_tb;
wire signed [4:-27] a2_tb;
wire signed [4:-27] b1_tb;
wire signed [4:-27] b2_tb;
wire clk_slow_tb;
wire flagR_tb;
wire flagI_tb;
wire [$clog2(DIM*DIM-1) :0] read_addr_M1_tb;
wire [$clog2(DIM*DIM-1) :0] read_addr_M2_tb;
wire signed [9:-22] a1b1_tb;
wire signed [9:-22] a2b2_tb;
wire signed [9:-22] a1b2_tb;
wire signed [9:-22] a2b1_tb;
wire signed [10:-21] ab_real_tb;
wire signed [10:-21] ab_imag_tb;
wire signed [20:-11] accR_tb;
wire signed [20:-11] accI_tb;


top_dut #(.ANCHOPALABRA(ANCHO_PALABRA),	.DIM(DIM)) DUT(
    .clk_fast_top           (clk_fast_tb),
    .rst_top                (rst_tb),
    .we_top                 (we_tb), //escribir en las memorias RAM
    //.enaAcum_top            (enaAcum_tb), //retener dato en el acumulador
    //.enaGene_top            (enaGene_tb),
    .signal_top             (signal_tb),
    .dataRAM_R1_top         (dataRAM_R1_tb),
    .dataRAM_I1_top         (dataRAM_I1_tb),
    .dataRAM_R2_top         (dataRAM_R2_tb),
    .dataRAM_I2_top         (dataRAM_I2_tb),
    .write_addr_R1_top      (write_addr_R1_tb),
    .write_addr_I1_top      (write_addr_I1_tb),
    .write_addr_R2_top      (write_addr_R2_tb),
    .write_addr_I2_top      (write_addr_I2_tb),

    .signalGenAddr_top      (signalGenAddr_tb),
    .signalAcum_top         (signalAcum_tb),
    .a1_top                 (a1_tb),
    .a2_top                 (a2_tb),
    .b1_top                 (b1_tb),
    .b2_top                 (b2_tb),
    .clk_slow_top           (clk_slow_tb),
    .flagR_top              (flagR_tb),
    .flagI_top              (flagI_tb),
    .read_addr_M1_top       (read_addr_M1_tb),
    .read_addr_M2_top       (read_addr_M2_tb),
    .a1b1_top               (a1b1_tb),
    .a2b2_top               (a2b2_tb),
    .a1b2_top               (a1b2_tb),
    .a2b1_top               (a2b1_tb),
    .ab_real_top            (ab_real_tb),
    .ab_imag_top            (ab_imag_tb),
	.accR_top               (accR_tb),
    .accI_top               (accI_tb)
);


initial begin
    fileR1 = $fopen("Reales_M1.txt", "r");
    fileI1 = $fopen("Imagin_M1.txt", "r");
    fileR2 = $fopen("Reales_M2.txt", "r");
    fileI2 = $fopen("Imagin_M2.txt", "r");
	     
	 fileR = $fopen("outputR.txt", "w");
	 #6000;
    $fclose(fileR);
	 $fclose(fileR1);
    $fclose(fileI1);
    $fclose(fileR2);
    $fclose(fileI2);
    $stop;
end

always@(posedge flagR_tb) begin
		$fwrite(fileR, "%b\n", accR_tb);
end

initial begin
    clk_fast_tb = 1'b0;
    rst_tb = 1'b1;
    we_tb = 1'b0;
    #1 rst_tb = 1'b0;
    #10 rst_tb = 1'b1;

    for(i=0; i<=(DIM*DIM); i=i+1) begin
        @(posedge clk_slow_tb)
        $fscanf(fileR1,"%b\n",dataRAM_R1_tb);
        $fscanf(fileI1,"%b\n",dataRAM_I1_tb);
        $fscanf(fileR2,"%b\n",dataRAM_R2_tb);
        $fscanf(fileI2,"%b\n",dataRAM_I2_tb);
        write_addr_R1_tb = i;
        write_addr_I1_tb = i;
        write_addr_R2_tb = i;
        write_addr_I2_tb = i;
        we_tb = 1'b1;
    end
    we_tb = 1'b0;
	 #10;
	signal_tb = 1'b1;
end

always#1 clk_fast_tb = ~clk_fast_tb;

endmodule