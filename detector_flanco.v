`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:51:45 09/15/2014 
// Design Name: 
// Module Name:    detector_flanco 
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
module detector_flanco(onda_cuadrada, reset, clock_FPGA, flanco_pos_onda_cuad);
	input onda_cuadrada, reset, clock_FPGA;
	output  flanco_pos_onda_cuad;
	reg onda_cuadrada_retraso;

	always @(posedge clock_FPGA or negedge reset)
	begin
		if(!reset)
			onda_cuadrada_retraso<=1'b0;
		else
			onda_cuadrada_retraso<=onda_cuadrada;
	end

	assign flanco_pos_onda_cuad = onda_cuadrada & !onda_cuadrada_retraso;

endmodule
