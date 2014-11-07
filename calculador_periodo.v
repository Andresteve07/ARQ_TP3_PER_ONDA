`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:11:25 10/28/2014 
// Design Name: 
// Module Name:    cuenta_20ns_us 
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
module calculador_periodo(clock_FPGA, reset, periodo_us);
	//periodo_us tendrá un valor máximo de 1000us según consigna
	input clock_FPGA;
	input wire reset;
	output reg [11:0] periodo_us;//permitimos una cuenta máxima hasta 1023.
	//pero el separador de cifras necesita 12bits
	
	reg [5:0] cuenta_20ns;
	reg [11:0] cuenta_us;
	initial periodo_us = 0;
	initial cuenta_20ns = 0;
	initial cuenta_us = 0;
	
	always@ (posedge clock_FPGA)//or posedge reset
	begin
	//con reset síncrono, el flanco de subida del clock debe ocurrir
	//primero para leer reset en "1"
		if(reset)//si el reset dura más de un ciclo de clock se pierde el valor del periodo_us
		begin
			periodo_us = cuenta_us;
			cuenta_20ns = 0;
			cuenta_us = 0;
		end
		else if (cuenta_20ns >= 50)//probar con "5" pero el valor es "50"
		begin
			cuenta_20ns = 0;
			cuenta_us = cuenta_us + 1;
		end
		else cuenta_20ns  = cuenta_20ns + 1;
	end
		
endmodule