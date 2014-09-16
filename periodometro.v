`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:48 09/12/2014 
// Design Name: 
// Module Name:    periodometro 
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
module periodometro(onda_cuadrada, reloj_FPGA, cod7SEG, pantallas);
	parameter CANT_BITS = 12;
	
	parameter CANT_CIFRAS_BCD = CANT_BITS+4;
	parameter CANT_PANTALLAS = (CANT_BITS+4)/4;

	input onda_cuadrada, reloj_FPGA;
	output [7:0] cod7SEG;
	output [3:0] pantallas;
//	wire pulso_1us;
//	
//	
//	reloj_us #(1) reloj_1us (.clock_FPGA(reloj_FPGA), .reloj_N_us(pulso_1us));
	wire senial_sinc;
	wire flanco_pos_onda_cuad;
	wire [11:0] valor_periodo;
	wire [11:0] contador;
	wire [CANT_BITS+3:0]reg_cifras_BCD;
	wire pulso_1ms;
	wire [3:0] cable_cifra_BCD;
	
	sincronizador sinc (.senial_externa(onda_cuadrada), 
							  .clock_FPGA(reloj_FPGA),
							  .senial_sincronizada(senial_sinc));
	
	detector_flanco det_flanco(.onda_cuadrada(senial_sinc), 
						 .reset(1'b1), 
						 .clock_FPGA(reloj_FPGA), 
						 .flanco_pos_onda_cuad(flanco_pos_onda_cuad));
	
	calculador_periodo calc (.reloj_placa(reloj_FPGA),
									 .flanco_pos_onda_cuad(flanco_pos_onda_cuad),
									 .valor_periodo(valor_periodo),
									 .contador(contador));
	
	conversor_RegNbits_RegBCD #(12) conv_Bin_BCD(.reg_binario(valor_periodo),
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
