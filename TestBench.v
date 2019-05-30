
`timescale 1 ns/ 10 ps
module DCT_vlg_tst();
// constants                                           
// general purpose registers
reg eachvec;
// test vector input registers
reg clk;
reg [8:0] data_in0;
reg [8:0] data_in1;
reg [8:0] data_in2;
reg [8:0] data_in3;
reg [8:0] data_in4;
reg [8:0] data_in5;
reg [8:0] data_in6;
reg [8:0] data_in7;
reg ena;
reg rst_n;
// wires                                               
wire [9:0]  M0;
wire [9:0]  M1;
wire [9:0]  M2;
wire [9:0]  M3;
wire [10:0]  M03;
wire [11:0]  M4;
wire [10:0]  M12;
wire [9:0]  P0;
wire [9:0]  P1;
wire [9:0]  P2;
wire [9:0]  P3;
wire [10:0]  P03;
wire [11:0]  P4;
wire [10:0]  P12;
wire [18:0]  data_out0;
wire [18:0]  data_out1;
wire [18:0]  data_out2;
wire [18:0]  data_out3;
wire [18:0]  data_out4;
wire [18:0]  data_out5;
wire [18:0]  data_out6;
wire [18:0]  data_out7;
wire done;
wire pipe0;
wire pipe1;
wire pipe2;
wire pipe3;
wire pipe4;

// assign statements (if any)                          
DCT i1 (
// port map - connection between master ports and signals/registers   
	.M0(M0),
	.M1(M1),
	.M2(M2),
	.M3(M3),
	.M03(M03),
	.M4(M4),
	.M12(M12),
	.P0(P0),
	.P1(P1),
	.P2(P2),
	.P3(P3),
	.P03(P03),
	.P4(P4),
	.P12(P12),
	.clk(clk),
	.data_in0(data_in0),
	.data_in1(data_in1),
	.data_in2(data_in2),
	.data_in3(data_in3),
	.data_in4(data_in4),
	.data_in5(data_in5),
	.data_in6(data_in6),
	.data_in7(data_in7),
	.data_out0(data_out0),
	.data_out1(data_out1),
	.data_out2(data_out2),
	.data_out3(data_out3),
	.data_out4(data_out4),
	.data_out5(data_out5),
	.data_out6(data_out6),
	.data_out7(data_out7),
	.done(done),
	.ena(ena),
	.pipe0(pipe0),
	.pipe1(pipe1),
	.pipe2(pipe2),
	.pipe3(pipe3),
	.pipe4(pipe4),
	.rst_n(rst_n)
);
initial                                                
begin                                                  
  #10 rst_n = 0;
    #10 rst_n = 1;
    #10 clk = 0;	
	 #100;
	 data_in0 = 8'd255;
    data_in1 = 8'd0;
    data_in2 = 8'd0;
    data_in3 = 8'd255;
    data_in4 = 8'd255;
    data_in5 = 8'd0;
    data_in6 = 8'd0;
    data_in7 = 8'd255;
	 #50 ena = 1;
	 #40;
	 data_in0 = 8'd155;
    data_in1 = 8'd0;
    data_in2 = 8'd0;
    data_in3 = 8'd155;
    data_in4 = 8'd155;
    data_in5 = 8'd0;
    data_in6 = 8'd0;
    data_in7 = 8'd155;
	 #40;
	 data_in0 = 8'd10;
    data_in1 = 8'd50;
    data_in2 = 8'd100;
    data_in3 = 8'd150;
    data_in4 = 8'd200;
    data_in5 = 8'd250;
    data_in6 = 8'd100;
    data_in7 = 8'd0;
	 #20;
	 data_in0 = 8'd155;
    data_in1 = 8'd154;
    data_in2 = 8'd153;
    data_in3 = 8'd152;
    data_in4 = 8'd151;
    data_in5 = 8'd150;
    data_in6 = 8'd149;
    data_in7 = 8'd148;
	 #500;
	 $stop;                                          
$display("Running testbench");                       
end   
initial                                                
begin  
forever 
	  begin
		 #10 clk <= !clk;                                                 
	  end
end                                                 
always                                                 
// optional sensitivity list                           
// @(event1 or event2 or .... eventn)                  
begin                                                  
// code executes for every event on sensitivity list   
// insert code here --> begin                          
                                                       
@eachvec;                                              
// --> end                                             
end                                                  
endmodule

