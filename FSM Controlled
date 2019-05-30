module DCT(clk,rst_n,ena,done,pipe0,pipe1,pipe2,pipe3,
			data_in0,data_in1,data_in2,data_in3,data_in4,data_in5,data_in6,data_in7,
			data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7,
			M0,M1,M2,M3,P0,P1,P2,P3,M03,M12,P03,P12,M4,P4);

parameter DATA_IN_WIDTH = 8;
parameter DATA_IN_SIGNED_WIDTH = DATA_IN_WIDTH + 1'b1;
parameter FACTOR_WIDTH = 4;
parameter FACTOR_SIGNED_WIDTH = FACTOR_WIDTH + 1'b1;
parameter TEMP_MULTIPLY_SIGNED_WIDTH = 17; //DATA_IN_SIGNED_WIDTH + 3 + FACTOR_SIGNED_WIDTH;
parameter DATA_OUT_SIGNED_WIDTH = 19;

input clk,rst_n,ena;
input signed [DATA_IN_SIGNED_WIDTH - 1:0] data_in0,data_in1,data_in2,data_in3,data_in4,data_in5,data_in6,data_in7;
output signed [DATA_OUT_SIGNED_WIDTH - 1:0] data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7;
output done;
output pipe0,pipe1,pipe2,pipe3;

output signed [DATA_IN_SIGNED_WIDTH :0] M0,M1,M2,M3,P0,P1,P2,P3;
output signed [DATA_IN_SIGNED_WIDTH + 1:0] M03,M12,P03,P12;
output signed [DATA_IN_SIGNED_WIDTH + 2:0] M4,P4;

reg signed [DATA_OUT_SIGNED_WIDTH - 1:0] data_out0,data_out1,data_out2,data_out3,data_out4,data_out5,data_out6,data_out7;
reg signed [DATA_OUT_SIGNED_WIDTH - 1:0] data_out_reg0,data_out_reg1,data_out_reg2,data_out_reg3,
			 data_out_reg4,data_out_reg5,data_out_reg6,data_out_reg7;
reg done;

reg signed [DATA_IN_SIGNED_WIDTH :0] M0,M1,M2,M3,P0,P1,P2,P3;
reg signed [DATA_IN_SIGNED_WIDTH + 1:0] M03,M12,P03,P12;
reg signed [DATA_IN_SIGNED_WIDTH + 2:0] M4,P4;
reg signed [TEMP_MULTIPLY_SIGNED_WIDTH - 1:0] tempMultiply[21:0];
reg pipe0;
reg pipe1;
reg pipe2;
reg pipe3;

reg signed [FACTOR_SIGNED_WIDTH - 1:0]	C1 = 4'd15,
				C2 = 4'd14,
				C3 = 4'd13,
				C4 = 4'd11,
				C5 = 4'd9,
				C6 = 4'd6,
				C7 = 4'd3;

	localparam 		IDLE		= 3'b011;
	localparam 		STAGE1 		= 3'b001;
	localparam 		STAGE2		= 3'b010;
	localparam		STAGE3		= 3'b111;
	localparam 		STAGE4 		= 3'b100;
	localparam 		STAGE5 		= 3'b101;
	localparam 		STAGE6 		= 3'b110;
	reg [2:0] current_state = 3'b000;
	reg [2:0] next_state = 3'b000;

	// FSM Controller
	always @(posedge clk or negedge rst_n)
		begin
			if (!rst_n)
				current_state <= IDLE;
			else
				current_state <= next_state;
		end
	
	always @ (rst_n,current_state,ena,data_in0,data_in1,data_in2,data_in3,data_in4,data_in5,data_in6,data_in7)
		begin
			if (!rst_n)
				next_state = IDLE;
			else
				case(current_state)
					IDLE:	
						if (ena)
							next_state = STAGE1;
					STAGE1:
							next_state = STAGE2;
					STAGE2:
							next_state = STAGE3;
					STAGE3:
							next_state = STAGE4;
					STAGE4:
							next_state = STAGE5;
					STAGE5:
							next_state = STAGE6;
					STAGE6:
							next_state = IDLE;
					default:
							next_state = IDLE;
				endcase
		end
		
	always @(posedge clk or negedge rst_n)
		begin
			if (!rst_n)
				begin
				  data_out0 <= 16'b0;
				  data_out1 <= 16'b0;
				  data_out2 <= 16'b0;
				  data_out3 <= 16'b0;
				  data_out4 <= 16'b0;
				  data_out5 <= 16'b0;
				  data_out6 <= 16'b0;
				  data_out7 <= 16'b0;
				  
				 M0 <= 9'b0;
				 M1 <= 9'b0;
				 M2 <= 9'b0;
				 M3 <= 9'b0;
				 P0 <= 9'b0;
				 P1 <= 9'b0;
				 P2 <= 9'b0;
				 P3 <= 9'b0;
				 pipe0 <= 0;
				 
				 M03 <= 10'b0;
				 M12 <= 10'b0;
				 P03 <= 10'b0;
				 P12 <= 10'b0;
				 pipe1 <= 0;

				 M4 <= 11'b0;
				 P4 <= 11'b0;
				 pipe2 <= 0;
				 
				 tempMultiply[0]  <= 16'b0;
				 tempMultiply[1]  <= 16'b0;
				 tempMultiply[2]  <= 16'b0;
				 tempMultiply[3]  <= 16'b0;
				 tempMultiply[4]  <= 16'b0;
				 tempMultiply[5]  <= 16'b0;
				 tempMultiply[6]  <= 16'b0;
				 tempMultiply[7]  <= 16'b0;
				 tempMultiply[8]  <= 16'b0;
				 tempMultiply[9]  <= 16'b0;
				 tempMultiply[10]  <= 16'b0;
				 tempMultiply[11]  <= 16'b0;
				 tempMultiply[12]  <= 16'b0;
				 tempMultiply[13]  <= 16'b0;
				 tempMultiply[14]  <= 16'b0;
				 tempMultiply[15]  <= 16'b0;
				 tempMultiply[16]  <= 16'b0;
				 tempMultiply[17]  <= 16'b0;
				 tempMultiply[18]  <= 16'b0;
				 tempMultiply[19]  <= 16'b0;
				 tempMultiply[20]  <= 16'b0;
				 tempMultiply[21]  <= 16'b0;
				 pipe3 <= 0;
				end
			else
				begin
					case(current_state)
						IDLE:
							begin
							  data_out0 <= 16'b0;
							  data_out1 <= 16'b0;
							  data_out2 <= 16'b0;
							  data_out3 <= 16'b0;
							  data_out4 <= 16'b0;
							  data_out5 <= 16'b0;
							  data_out6 <= 16'b0;
							  data_out7 <= 16'b0;
							  
							 M0 <= 9'b0;
							 M1 <= 9'b0;
							 M2 <= 9'b0;
							 M3 <= 9'b0;
							 P0 <= 9'b0;
							 P1 <= 9'b0;
							 P2 <= 9'b0;
							 P3 <= 9'b0;
							 pipe0 <= 0;
							 
							 M03 <= 10'b0;
							 M12 <= 10'b0;
							 P03 <= 10'b0;
							 P12 <= 10'b0;
							 pipe1 <= 0;
							 
							 
							 M4 <= 11'b0;
							 P4 <= 11'b0;
							 pipe2 <= 0;
							 
							 tempMultiply[0]  <= 16'b0;
							 tempMultiply[1]  <= 16'b0;
							 tempMultiply[2]  <= 16'b0;
							 tempMultiply[3]  <= 16'b0;
							 tempMultiply[4]  <= 16'b0;
							 tempMultiply[5]  <= 16'b0;
							 tempMultiply[6]  <= 16'b0;
							 tempMultiply[7]  <= 16'b0;
							 tempMultiply[8]  <= 16'b0;
							 tempMultiply[9]  <= 16'b0;
							 tempMultiply[10]  <= 16'b0;
							 tempMultiply[11]  <= 16'b0;
							 tempMultiply[12]  <= 16'b0;
							 tempMultiply[13]  <= 16'b0;
							 tempMultiply[14]  <= 16'b0;
							 tempMultiply[15]  <= 16'b0;
							 tempMultiply[16]  <= 16'b0;
							 tempMultiply[17]  <= 16'b0;
							 tempMultiply[18]  <= 16'b0;
							 tempMultiply[19]  <= 16'b0;
							 tempMultiply[20]  <= 16'b0;
							 tempMultiply[21]  <= 16'b0;
							 pipe3 <= 0;
							end
						STAGE1:
							begin
								 M0 <= data_in0 - data_in7;
								 M1 <= data_in1 - data_in6;
								 M2 <= data_in2 - data_in5;
								 M3 <= data_in3 - data_in4;
								 P0 <= data_in0 + data_in7;
								 P1 <= data_in1 + data_in6;
								 P2 <= data_in2 + data_in5;
								 P3 <= data_in3 + data_in4;
								 pipe0 <= 1;
							end
						STAGE2:
							begin
								 M03 <= P0 - P3;
								 M12 <= P1 - P2;
								 P03 <= P0 + P3;
								 P12 <= P1 + P2;
								 pipe1 <= 1;
							end
						STAGE3:
							begin
							  M4 <= P03 - P12;
							  P4 <= P03 + P12;
							  pipe2 <= 1;
							end
						STAGE4:
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
						STAGE5:	
							begin
							 data_out_reg0  <= tempMultiply[0];
							 data_out_reg1  <= tempMultiply[1] + tempMultiply[2] + tempMultiply[3] + tempMultiply[4];
							 data_out_reg2  <= tempMultiply[5] + tempMultiply[6];
							 data_out_reg3  <= tempMultiply[7] - tempMultiply[8] - tempMultiply[9] - tempMultiply[10];
							 data_out_reg4  <= tempMultiply[11];
							 data_out_reg5  <= tempMultiply[12] - tempMultiply[13] + tempMultiply[14] + tempMultiply[15];
							 data_out_reg6  <= tempMultiply[16] - tempMultiply[17];
							 data_out_reg7  <= tempMultiply[18] - tempMultiply[19] + tempMultiply[20] - tempMultiply[21];
							 done <= 1;
							end	
						STAGE6:
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
						default:
							begin
							  data_out0 <= 16'b0;
							  data_out1 <= 16'b0;
							  data_out2 <= 16'b0;
							  data_out3 <= 16'b0;
							  data_out4 <= 16'b0;
							  data_out5 <= 16'b0;
							  data_out6 <= 16'b0;
							  data_out7 <= 16'b0;
							  
							 M0 <= 9'b0;
							 M1 <= 9'b0;
							 M2 <= 9'b0;
							 M3 <= 9'b0;
							 P0 <= 9'b0;
							 P1 <= 9'b0;
							 P2 <= 9'b0;
							 P3 <= 9'b0;
							 pipe0 <= 0;
							 
							 M03 <= 10'b0;
							 M12 <= 10'b0;
							 P03 <= 10'b0;
							 P12 <= 10'b0;
							 pipe1 <= 0;
							 
							 
							 M4 <= 11'b0;
							 P4 <= 11'b0;
							 pipe2 <= 0;
							 
							 tempMultiply[0]  <= 16'b0;
							 tempMultiply[1]  <= 16'b0;
							 tempMultiply[2]  <= 16'b0;
							 tempMultiply[3]  <= 16'b0;
							 tempMultiply[4]  <= 16'b0;
							 tempMultiply[5]  <= 16'b0;
							 tempMultiply[6]  <= 16'b0;
							 tempMultiply[7]  <= 16'b0;
							 tempMultiply[8]  <= 16'b0;
							 tempMultiply[9]  <= 16'b0;
							 tempMultiply[10]  <= 16'b0;
							 tempMultiply[11]  <= 16'b0;
							 tempMultiply[12]  <= 16'b0;
							 tempMultiply[13]  <= 16'b0;
							 tempMultiply[14]  <= 16'b0;
							 tempMultiply[15]  <= 16'b0;
							 tempMultiply[16]  <= 16'b0;
							 tempMultiply[17]  <= 16'b0;
							 tempMultiply[18]  <= 16'b0;
							 tempMultiply[19]  <= 16'b0;
							 tempMultiply[20]  <= 16'b0;
							 tempMultiply[21]  <= 16'b0;
							 pipe3 <= 0;
							end
					endcase
				end
		end

endmodule 
