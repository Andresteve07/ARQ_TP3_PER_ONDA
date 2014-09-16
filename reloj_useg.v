`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:42:36 09/12/2014 
// Design Name: 
// Module Name:    reloj_useg 
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
module reloj_us(clock_FPGA, reloj_N_us);
	parameter CANT_MS = 1;
	
	input clock_FPGA;
	output reg reloj_N_us;
	
	reg [14:0] contador;
	initial contador = 0;
	initial reloj_N_us = 0;
	
	always@ (posedge clock_FPGA)
	begin
		if (contador >= CANT_MS*25)
		begin
			contador = 0;
			reloj_N_ms = ~reloj_N_us;
		end
		else contador  = contador + 1;
		
endmodule
