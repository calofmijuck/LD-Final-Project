`timescale 1ns / 1ps


module FinalProject(
	 input CLK, //machine clock (50MHz)
    input reset, //reset button
	 input [7:0] instruction, //instruction input
	 output [6:0] seg1, 
	 output [6:0] seg2, //hex segments
	 output [7:0] readingAddress //instruction address output
	 );
	 
	 wire contCLK; //controlled Clock (1Hz)
	 reg [7:0] regWrite; //regWrite
	 reg [7:0] pc; //pc value
	 assign readingAddress = pc; 
	 reg [7:0] data[31:0]; //data memory
	 reg [7:0] registers[3:0]; //4 registers
	 reg [5:0] counting;
	 
	 FrequencyDivider freqdiv (.CLKin(CLK), .clr(1'b0), .CLKout(contCLK));
	 HextoBCD HBCD1 (.bcd(regWrite[7:4]), .segout(seg1));
	 HextoBCD HBCD2 (.bcd(regWrite[3:0]), .segout(seg2));
	 
	 initial begin
		pc = 8'b00000000;
		for(counting = 0; counting < 32; counting = counting + 1) begin
			data[counting] = counting[3:0];
		end
	 end
	 	 
	 
	 always @(posedge reset or posedge contCLK) begin
		if(reset == 1'b1) begin //reset
			pc = 8'b00000000;
			for(counting = 0; counting < 32; counting = counting + 1) begin
				data[counting] = counting[3:0];
			end
		end
		
		else begin
			case(instruction[7:6])
				2'b00 : begin //add
					registers[instruction[1:0]] = registers[instruction[3:2]] + registers[instruction[5:4]];
					regWrite = registers[instruction[1:0]];
					pc = pc + 1;
				end
				2'b01 : begin //load
					registers[instruction[3:2]] = data[registers[instruction[5:4]] + instruction[1:0]];
					regWrite = registers[instruction[3:2]];
					pc = pc + 1;
				end
				2'b10 : begin //store
					data[registers[instruction[5:4]] + instruction[1:0]] = registers[instruction[3:2]];
					pc = pc + 1;
				end
				2'b11 : begin //jump
					case(instruction[1:0])
						2'b00 : pc = pc + 1;
						2'b01 : pc = pc + 2;
						2'b10 : pc = pc - 1;
						2'b11 : pc = pc;
					endcase
				end
			endcase
		end
	end 

endmodule
