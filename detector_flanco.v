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
	output flanco_pos_onda_cuad;
	
	reg onda_cuadrada_retraso;
	//reg flanco_pos_onda_cuad;
	
	initial onda_cuadrada_retraso = 0;
	//initial flanco_pos_onda_cuad = 0;
	
	always @(posedge clock_FPGA or negedge reset)
	//con posedge clock_FPGA funciona pero la lectura del reset en el contador_us
	//se hace en el cambio de flanco y podría no detectarse o ser erronea.
	
	begin
		if(!reset)
			onda_cuadrada_retraso<=1'b0;
		else
			onda_cuadrada_retraso<=onda_cuadrada;
	end

	assign flanco_pos_onda_cuad = onda_cuadrada & !onda_cuadrada_retraso;
	
	/*
	begin
		flanco_pos_onda_cuad = onda_cuadrada & !onda_cuadrada_retraso;
		if(!reset)
			onda_cuadrada_retraso = 1'b0;
		else
			onda_cuadrada_retraso = onda_cuadrada;
	end
	*/
endmodule
