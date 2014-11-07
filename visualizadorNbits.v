`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:21:50 11/05/2014 
// Design Name: 
// Module Name:    visualizadorNbits 
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

module visualizadorNbits(regNbits, reloj_FPGA, cod7SEG, pantallas);
	parameter CANT_BITS = 12;
	
	parameter CANT_CIFRAS_BCD = CANT_BITS+4;//debería ser una variable local
	parameter CANT_PANTALLAS = (CANT_BITS+4)/4;//debería ser una variable local
	
	input [CANT_BITS-1:0] regNbits;
	input reloj_FPGA;
	output [7:0] cod7SEG;
	output [3:0] pantallas;

	wire [CANT_CIFRAS_BCD-1:0]reg_cifras_BCD;
	wire pulso_1ms;
	wire [3:0] cable_cifra_BCD;
	
	conversor_RegNbits_RegBCD #(CANT_BITS) conv_Bin_BCD(.reg_binario(regNbits),
															  .reg_BCD(reg_cifras_BCD));
															  
	reloj_ms #(1) reloj_1ms (.clock_FPGA(reloj_FPGA),
									 .reloj_N_ms(pulso_1ms));													  

	multiplexor_RegBCD #(CANT_CIFRAS_BCD,CANT_PANTALLAS) mux (.reg_cifrasBCD(reg_cifras_BCD),
																		 .reloj_1ms(pulso_1ms),
																		 .cifraBCD(cable_cifra_BCD),
																		 .pantalla(pantallas));
								  
	conversor_BCD_7SEG conv_7seg (.cifraBCD(cable_cifra_BCD), 
									      .cod7SEG(cod7SEG));

endmodule
