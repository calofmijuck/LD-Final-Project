`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:49:28 06/13/2018 
// Design Name: 
// Module Name:    FinalProject 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module FinalProject(
<<<<<<< HEAD
	 input CLK,
    input reset,
	 input [7:0] instruction,
	 output [3:0] seg1,
	 output [3:0] seg2,
	 output [7:0] readingAddress
=======
    input [7:0] instruction,
	 input [7:0] pc,
    input reset
>>>>>>> a44ebc8a260f176a1e748ad6eb1ffb25dbf1059f
	 );
	 
	 wire contCLK;
	 reg regWrite;
	 reg [7:0] pc;
	 assign readingAddress = pc;
	 
	 initial begin
		pc = 8'b00000000;
		for(counting = 0; counting < 32; counting = counting + 1) begin
			data[counting] = counting[3:0];
		end
	 end
	 


	 
	 frequencyDivider freqdiv (.CLKin(CLK), .clr(1'b0), .clkout(contCLK));
	 
	 reg [31:0] data[7:0];
	 reg [3:0] registers[7:0];
	 reg [4:0] counting;
	 
	 always @(posedge reset or posedge contCLK) begin
		if(reset == 1'b0) begin
			for(counting = 0; counting < 32; counting = counting + 1) begin
				data[counting] = counting[3:0];
			end
		end
		else begin
			case(instruction[7:6])
				2'b00 : begin
					registers[instruction[1:0]] = registers[instruction[3:2]] + registers[instruction[5:4]];
					pc = pc + 1;
				end
				2'b01 : begin
					registers[instruction[3:2]] = data[registers[instruction[5:4]] + instruction[1:0]];
					pc = pc + 1;
				end
				2'b10 : begin
					data[registers[instruction[5:4]] + instruction[1:0]] = registers[instruction[3:2]];
					pc = pc + 1;
				end
				2'b11 : begin
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
