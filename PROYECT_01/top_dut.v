module top_dut #(parameter ANCHOPALABRA=32, parameter DIM=3)(
    input clk_fast_top,
    input rst_top,
    input we_top, //escribir en las memorias RAM
    input enaAcum_top, //retener dato en el acumulador
    input enaGene_top,
    input [(ANCHOPALABRA-1) :0] dataRAM_R1_top,
    input [(ANCHOPALABRA-1) :0] dataRAM_I1_top,
    input [(ANCHOPALABRA-1) :0] dataRAM_R2_top,
    input [(ANCHOPALABRA-1) :0] dataRAM_I2_top,
    input [$clog2(DIM*DIM-1) :0] write_addr_R1_top,
    input [$clog2(DIM*DIM-1) :0] write_addr_I1_top,
    input [$clog2(DIM*DIM-1) :0] write_addr_R2_top,
    input [$clog2(DIM*DIM-1) :0] write_addr_I2_top,

    output signed [4:-27] a1_top,
    output signed [4:-27] a2_top,
    output signed [4:-27] b1_top,
    output signed [4:-27] b2_top,
    output clk_slow_top,
    output flagR_top,
    output flagI_top,
    output [$clog2(DIM*DIM-1) :0] read_addr_M1_top,
    output [$clog2(DIM*DIM-1) :0] read_addr_M2_top,
    output signed [9:-22] a1b1_top,
    output signed [9:-22] a2b2_top,
    output signed [9:-22] a1b2_top,
    output signed [9:-22] a2b1_top,
    output signed [10:-21] ab_real_top,
    output signed [10:-21] ab_imag_top,
	output signed [20:-11] accR_top,
    output signed [20:-11] accI_top
);

localparam NBITS_PRES = 3;

//--------------------------------------------------------------------------
//-------------------------------GENERADORES ADDR---------------------------
//--------------------------------------------------------------------------
StateMachineGenDir1 #(.DIM(DIM)) SM_GDM1(
	.clk    (clk_slow_top), 
	.ena    (enaGene_top), 
	.rst    (rst_top),

	.flag   (),
	.q      (read_addr_M1_top)
);

StateMachineGenDir2 #(.DIM(DIM)) SM_GDM2(
	.clk    (clk_slow_top), 
	.ena    (enaGene_top), 
	.rst    (rst_top),

	.flag   (),
	.q      (read_addr_M2_top)
);

//--------------------------------------------------------------------------
//-------------------------------PRESCALER----------------------------------
//--------------------------------------------------------------------------
prescaler #(.NBITS(NBITS_PRES)) PRESC(
    .clk_fast     (clk_fast_top),
    .rst          (rst_top),
    
    .clk_slow     (clk_slow_top)
);

//--------------------------------------------------------------------------
//-------------------------------RAMS---------------------------------------
//--------------------------------------------------------------------------
simple_dual_port_ram #(.DATA_WIDTH(ANCHOPALABRA), .ADDR_WIDTH($clog2(DIM*DIM-1)+1)) RAMR1(
	.data           (dataRAM_R1_top),
	.read_addr      (read_addr_M1_top), 
    .write_addr     (write_addr_R1_top),
	.we             (we_top), 
    .clk            (clk_slow_top),
    
    .q              (a1_top)
);

simple_dual_port_ram #(.DATA_WIDTH(ANCHOPALABRA), .ADDR_WIDTH($clog2(DIM*DIM-1)+1)) RAMI1(
	.data           (dataRAM_I1_top),
	.read_addr      (read_addr_M1_top), 
    .write_addr     (write_addr_I1_top),
	.we             (we_top), 
    .clk            (clk_slow_top),
    
    .q              (a2_top)
);

simple_dual_port_ram #(.DATA_WIDTH(ANCHOPALABRA), .ADDR_WIDTH($clog2(DIM*DIM-1)+1)) RAMR2(
	.data           (dataRAM_R2_top),
	.read_addr      (read_addr_M2_top), 
    .write_addr     (write_addr_R2_top),
	.we             (we_top), 
    .clk            (clk_slow_top),
    
    .q              (b1_top)
);

simple_dual_port_ram #(.DATA_WIDTH(ANCHOPALABRA), .ADDR_WIDTH($clog2(DIM*DIM-1)+1)) RAMI2(
	.data           (dataRAM_I2_top),
	.read_addr      (read_addr_M2_top), 
    .write_addr     (write_addr_I2_top),
	.we             (we_top), 
    .clk            (clk_slow_top),
    
    .q              (b2_top)
);

//--------------------------------------------------------------------------
//-------------------------------PRODUCTO----------------------------------
//--------------------------------------------------------------------------
prodtwo PROD(
    .clk     (clk_fast_top), 
    .rst     (rst_top),

    .a1      (a1_top),
    .a2      (a2_top),
    .b1      (b1_top),
    .b2      (b2_top),

    .a1b1     (a1b1_top),
    .a2b2     (a2b2_top),
    .a1b2     (a1b2_top),
    .a2b1     (a2b1_top)
);

//--------------------------------------------------------------------------
//-------------------------------SUMAS--------------------------------------
//--------------------------------------------------------------------------
sumtwo SUM(
    .clk      (clk_fast_top), 
    .rst      (rst_top),
    .a1b1     (a1b1_top),
    .a2b2     (a2b2_top),
    .a1b2     (a1b2_top),
    .a2b1     (a2b1_top),

    .ab_real     (ab_real_top),
    .ab_imag     (ab_imag_top)
);

//--------------------------------------------------------------------------
//-------------------------------ACUMULADORES-------------------------------
//--------------------------------------------------------------------------
accum #(.DIM(DIM)) ACUMR(
    .clk     (clk_slow_top), 
    .rst     (rst_top), 
    .ena     (enaAcum_top),
    .data    (ab_real_top),

    .flag     (flagR_top),
	.acc      (accR_top)
);

accum #(.DIM(DIM)) ACUMI(
    .clk     (clk_slow_top), 
    .rst     (rst_top), 
    .ena     (enaAcum_top),
    .data    (ab_imag_top),

    .flag     (flagI_top),
	.acc      (accI_top)
);


endmodule