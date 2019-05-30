module DCT(clk,rst_n,ena,done,pipe0,pipe1,pipe2,pipe3,pipe4,
			data_in0,data_in1,data_in2,data_in3,data_in4,data_in5,data_in6,data_in7,
			data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7,
			M0,M1,M2,M3,P0,P1,P2,P3,M03,M12,P03,P12,M4,P4);

parameter DATA_IN_WIDTH = 8;
parameter DATA_IN_SIGNED_WIDTH = DATA_IN_WIDTH + 1'b1;
parameter FACTOR_WIDTH = 4;
parameter FACTOR_SIGNED_WIDTH = FACTOR_WIDTH + 1'b1;
parameter TEMP_MULTIPLY_SIGNED_WIDTH = 17; //DATA_IN_SIGNED_WIDTH + 3 + FACTOR_SIGNED_WIDTH;
parameter TEMP_ADDER_SIGNED_WIDTH = 18;
parameter DATA_OUT_SIGNED_WIDTH = 19;

input clk,rst_n,ena;
input signed [DATA_IN_SIGNED_WIDTH - 1:0] data_in0,data_in1,data_in2,data_in3,data_in4,data_in5,data_in6,data_in7;
output signed [DATA_OUT_SIGNED_WIDTH - 1:0] data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7;
output done;
output pipe0,pipe1,pipe2,pipe3,pipe4;

output signed [DATA_IN_SIGNED_WIDTH :0] M0,M1,M2,M3,P0,P1,P2,P3;
output signed [DATA_IN_SIGNED_WIDTH + 1:0] M03,M12,P03,P12;
output signed [DATA_IN_SIGNED_WIDTH + 2:0] M4,P4;

reg signed [DATA_OUT_SIGNED_WIDTH - 1:0] data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7;
reg signed [DATA_OUT_SIGNED_WIDTH - 1:0] data_out_reg0,data_out_reg1,data_out_reg2,data_out_reg3,
			 data_out_reg4,data_out_reg5,data_out_reg6,data_out_reg7;
reg done;

reg signed [DATA_IN_SIGNED_WIDTH :0] M0,M1,M2,M3,P0,P1,P2,P3;
reg signed [DATA_IN_SIGNED_WIDTH :0] M0_reg1,M1_reg1,M2_reg1,M3_reg1,P0_reg1,P1_reg1,P2_reg1,P3_reg1;
reg signed [DATA_IN_SIGNED_WIDTH :0] M0_reg2,M1_reg2,M2_reg2,M3_reg2,P0_reg2,P1_reg2,P2_reg2,P3_reg2;
reg signed [DATA_IN_SIGNED_WIDTH + 1:0] M03,M12,P03,P12;
reg signed [DATA_IN_SIGNED_WIDTH + 1:0] M03_reg1,M12_reg1,P03_reg1,P12_reg1;
reg signed [DATA_IN_SIGNED_WIDTH + 2:0] M4,P4;
reg signed [TEMP_MULTIPLY_SIGNED_WIDTH - 1:0] tempMultiply[21:0];
reg signed [TEMP_ADDER_SIGNED_WIDTH - 1:0] tempAdder[11:0];
reg pipe0;
reg pipe1;
reg pipe2;
reg pipe3;
reg pipe4;

reg signed [FACTOR_SIGNED_WIDTH - 1:0]	C1 = 4'd15,
				C2 = 4'd14,
				C3 = 4'd13,
				C4 = 4'd11,
				C5 = 4'd9,
				C6 = 4'd6,
				C7 = 4'd3;

  always@(posedge clk or negedge rst_n)
    begin
	   if(!rst_n)
		  begin
			 pipe0 <= 0;
		    M0 <= 10'b0;
			 M1 <= 10'b0;
			 M2 <= 10'b0;
			 M3 <= 10'b0;
			 P0 <= 10'b0;
			 P1 <= 10'b0;
			 P2 <= 10'b0;
			 P3 <= 10'b0;
			 
			 M0_reg1 <= 10'b0;
			 M1_reg1 <= 10'b0;
			 M2_reg1 <= 10'b0;
			 M3_reg1 <= 10'b0;
			 P0_reg1 <= 10'b0;
			 P1_reg1 <= 10'b0;
			 P2_reg1 <= 10'b0;
			 P3_reg1 <= 10'b0;
			 
			 M0_reg2 <= 10'b0;
			 M1_reg2 <= 10'b0;
			 M2_reg2 <= 10'b0;
			 M3_reg2 <= 10'b0;
			 P0_reg2 <= 10'b0;
			 P1_reg2 <= 10'b0;
			 P2_reg2 <= 10'b0;
			 P3_reg2 <= 10'b0;
		  end
		else
		  begin
		    if(ena)
			   begin
				pipe0 <= 1;
				M0 <= M0_reg2;
				M1 <= M1_reg2;
				M2 <= M2_reg2;
				M3 <= M3_reg2;
				P0 <= P0_reg2;
				P1 <= P1_reg2;
				P2 <= P2_reg2;
				P3 <= P3_reg2;
				
				M0_reg2 <= M0_reg1;
				M1_reg2 <= M1_reg1;
				M2_reg2 <= M2_reg1;
				M3_reg2 <= M3_reg1;
				P0_reg2 <= P0_reg1;
				P1_reg2 <= P1_reg1;
				P2_reg2 <= P2_reg1;
				P3_reg2 <= P3_reg1;
				
				M0_reg1 <= data_in0 - data_in7;
				M1_reg1 <= data_in1 - data_in6;
				M2_reg1 <= data_in2 - data_in5;
				M3_reg1 <= data_in3 - data_in4;
				P0_reg1 <= data_in0 + data_in7;
				P1_reg1 <= data_in1 + data_in6;
				P2_reg1 <= data_in2 + data_in5;
				P3_reg1 <= data_in3 + data_in4;
				end
		  end
	 end
  
  always@(posedge clk or negedge rst_n)
    begin
	   if(!rst_n)
		  begin
		    M03 <= 11'b0;
			 M12 <= 11'b0;
			 P03 <= 11'b0;
			 P12 <= 11'b0;
			 pipe1 <= 0;
			 
			 M03_reg1 <= 11'b0;
			 M12_reg1 <= 11'b0;
			 P03_reg1 <= 11'b0;
			 P12_reg1 <= 11'b0;
		  end
		else
		  begin
		    if(pipe0)
			   begin
				M03 <= M03_reg1;
				M12 <= M12_reg1;
				P03 <= P03_reg1;
				P12 <= P12_reg1;
				pipe1 <= 1;
				
				M03_reg1 <= P0_reg1 - P3_reg1;
				M12_reg1 <= P1_reg1 - P2_reg1;
				P03_reg1 <= P0_reg1 + P3_reg1;
				P12_reg1 <= P1_reg1 + P2_reg1;
				end
		  end
	 end
	 
  always@(posedge clk or negedge rst_n)
    begin
	   if(!rst_n)
		  begin
		    M4 <= 12'b0;
			 P4 <= 12'b0;
			 pipe2 <= 0;
		  end
		else
		  begin
		    if(pipe1)
			   begin
				  M4 <= P03_reg1 - P12_reg1;
				  P4 <= P03_reg1 + P12_reg1;
				  pipe2 <= 1;
				end
		  end
	 end
	 
always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
	   begin
		 tempMultiply[0]  <= 18'b0;
		 tempMultiply[1]  <= 18'b0;
		 tempMultiply[2]  <= 18'b0;
		 tempMultiply[3]  <= 18'b0;
		 tempMultiply[4]  <= 18'b0;
		 tempMultiply[5]  <= 18'b0;
		 tempMultiply[6]  <= 18'b0;
		 tempMultiply[7]  <= 18'b0;
		 tempMultiply[8]  <= 18'b0;
		 tempMultiply[9]  <= 18'b0;
		 tempMultiply[10]  <= 18'b0;
		 tempMultiply[11]  <= 18'b0;
		 tempMultiply[12]  <= 18'b0;
		 tempMultiply[13]  <= 18'b0;
		 tempMultiply[14]  <= 18'b0;
		 tempMultiply[15]  <= 18'b0;
		 tempMultiply[16]  <= 18'b0;
		 tempMultiply[17]  <= 18'b0;
		 tempMultiply[18]  <= 18'b0;
		 tempMultiply[19]  <= 18'b0;
		 tempMultiply[20]  <= 18'b0;
		 tempMultiply[21]  <= 18'b0;
		 pipe3 <= 0;
      end
    else
		begin
		 if(pipe2)
		   begin
			 tempMultiply[0]  <= P4*C4;
			 tempMultiply[1]  <= M0*C1;
			 tempMultiply[2]  <= M1*C3;
			 tempMultiply[3]  <= M2*C5;
			 tempMultiply[4]  <= M3*C7;
			 tempMultiply[5]  <= M03*C2;
			 tempMultiply[6]  <= M12*C6;
			 tempMultiply[7]  <= M0*C3;
			 tempMultiply[8]  <= M1*C7;
			 tempMultiply[9]  <= M2*C1;
			 tempMultiply[10]  <= M3*C5;
			 tempMultiply[11]  <= M4*C4;
			 tempMultiply[12]  <= M0*C5;
			 tempMultiply[13]  <= M1*C1;
			 tempMultiply[14]  <= M2*C7;
			 tempMultiply[15]  <= M3*C3;
			 tempMultiply[16]  <= M03*C6;
			 tempMultiply[17]  <= M12*C2;
			 tempMultiply[18]  <= M0*C7;
			 tempMultiply[19]  <= M1*C5;
			 tempMultiply[20]  <= M2*C3;
			 tempMultiply[21]  <= M3*C1;
			 pipe3 <= 1;
			end
	  end		  
  end
  
always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
	   begin
			tempAdder[0]  <= 17'b0;
			tempAdder[1]  <= 17'b0;
			tempAdder[2]  <= 17'b0;
			tempAdder[3]  <= 17'b0;
			tempAdder[4]  <= 17'b0;
			tempAdder[5]  <= 17'b0;
			tempAdder[6]  <= 17'b0;
			tempAdder[7]  <= 17'b0;
			tempAdder[8]  <= 17'b0;
			tempAdder[9]  <= 17'b0;
			tempAdder[10]  <= 17'b0;
			tempAdder[11]  <= 17'b0;
			
			pipe4 <= 0;
      end
    else
		begin
		 if(pipe3)
		   begin
				tempAdder[0]  <= tempMultiply[0];
				tempAdder[1]  <= tempMultiply[1] + tempMultiply[2];
				tempAdder[2]  <= tempMultiply[3] + tempMultiply[4];
				tempAdder[3]  <= tempMultiply[5] + tempMultiply[6];
				tempAdder[4]  <= tempMultiply[7] - tempMultiply[8];
				tempAdder[5]  <= tempMultiply[9] + tempMultiply[10];
				tempAdder[6]  <= tempMultiply[11];
				tempAdder[7]  <= tempMultiply[12] - tempMultiply[13];
				tempAdder[8]  <= tempMultiply[14] + tempMultiply[15];
				tempAdder[9]  <= tempMultiply[16] - tempMultiply[17];
				tempAdder[10]  <= tempMultiply[18] - tempMultiply[19];
				tempAdder[11]  <= tempMultiply[20] - tempMultiply[21];
				pipe4 <= 1;
			end
	  end		  
  end
  
always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
	   begin
			 data_out_reg0 <= 18'b0;
			 data_out_reg1 <= 18'b0;
			 data_out_reg2 <= 18'b0;
			 data_out_reg3 <= 18'b0;
			 data_out_reg4 <= 18'b0;
			 data_out_reg5 <= 18'b0;
			 data_out_reg6 <= 18'b0;
			 data_out_reg7 <= 18'b0;
			 done <= 0;
      end
    else
		begin
		 if(pipe4)
		   begin
			 data_out_reg0  <= tempAdder[0];
			 data_out_reg1  <= tempAdder[1] + tempAdder[2];
			 data_out_reg2  <= tempAdder[3];
			 data_out_reg3  <= tempAdder[4] - tempAdder[5];
			 data_out_reg4  <= tempAdder[6];
			 data_out_reg5  <= tempAdder[7] + tempAdder[8];
			 data_out_reg6  <= tempAdder[9];
			 data_out_reg7  <= tempAdder[10] + tempAdder[11];
			 done <= 1;
			end
	  end		  
  end
  
always@(posedge clk or negedge rst_n)
  begin
    if(!rst_n)
	   begin
		  data_out0 <= 18'b0;
		  data_out1 <= 18'b0;
		  data_out2 <= 18'b0;
		  data_out3 <= 18'b0;
		  data_out4 <= 18'b0;
		  data_out5 <= 18'b0;
		  data_out6 <= 18'b0;
		  data_out7 <= 18'b0;
      end
    else
	  begin
	    if(done)
		   begin
			 data_out0 <= data_out_reg0;
			 data_out1 <= data_out_reg1;
			 data_out2 <= data_out_reg2;
			 data_out3 <= data_out_reg3;
			 data_out4 <= data_out_reg4;
			 data_out5 <= data_out_reg5;
			 data_out6 <= data_out_reg6;
			 data_out7 <= data_out_reg7;
			end
	  end		  
  end
 

endmodule 
