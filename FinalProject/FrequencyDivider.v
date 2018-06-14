`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:19:57 06/13/2018 
// Design Name: 
// Module Name:    FrequencyDivider 
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
module FrequencyDivider(
    input CLKin,
    input clr,
    output reg CLKout
    );
	
	 reg [31:0] cnt;
	 always @(posedge CLKin) begin
		if(clr) begin
			cnt <= 32'd0;
			CLKout <= 1'b0;
		end
		else if(cnt == 32'd25)//000000) 
		begin
			cnt <= 32'd0;
			CLKout <= ~CLKout;
		end
		else begin
			cnt <= cnt+1;
		end
	end

endmodule