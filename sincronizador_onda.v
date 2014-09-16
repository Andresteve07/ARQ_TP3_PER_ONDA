`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:46:16 09/15/2014 
// Design Name: 
// Module Name:    sincronizador 
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
module sincronizador(senial_externa, clock_FPGA, senial_sincronizada);
	input senial_externa, clock_FPGA;
	output reg senial_sincronizada;
	initial senial_sincronizada = 0;
	always @(negedge clock_FPGA)
	begin
		senial_sincronizada = senial_externa;
	end
endmodule
