`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:00:20 09/12/2014 
// Design Name: 
// Module Name:    calculador_periodo 
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
module calculador_periodo(reloj_placa, flanco_pos_onda_cuad, valor_periodo, contador);
	input reloj_placa, flanco_pos_onda_cuad;
	output reg [11:0] valor_periodo;
	output reg [11:0] contador;
	reg [9:0] cant_us, cant_ms;
	initial valor_periodo = 0;
	initial contador = 0;
	initial cant_us = 0;
	initial cant_ms = 0;
	
	always@(negedge reloj_placa, posedge flanco_pos_onda_cuad)
	begin
	
		if(flanco_pos_onda_cuad)
		begin
			valor_periodo = cant_us;
			contador = 0;
			cant_us=0;
			cant_ms=0;
		end
		
		else
		begin
			if(contador >= 2)//50
			begin
				cant_us = cant_us +1;
				contador = 0;
			end
			else if(cant_us >= 4)//50
			begin
				cant_ms = cant_ms +1;
				cant_us = 0;
			end
			else
			contador = contador + 1;
		end
		
	end


endmodule
