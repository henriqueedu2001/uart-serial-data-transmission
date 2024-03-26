`timescale 1ns/1ns
module serial_tb;
	reg clock;
	reg iniciar_transmissao;
	reg entrada_serial; // para o receptor serial
	wire saida_serial; // fio serial de transmissão para o transmissor
	wire transmissor_acabou;
	wire transmissor_ocupado;
	wire [6:0] hex0_out;
	wire [6:0] hex1_out;
	wire db_botao;
	wire receptor_acabou;

serial uut(
	.clock(clock),
	.iniciar_transmissao(iniciar_transmissao),
	.entrada_serial(entrada_serial), // para o receptor serial
	.saida_serial(saida_serial), // fio serial de transmissão para o transmissor
	.transmissor_acabou(transmissor_acabou),
	.transmissor_ocupado(transmissor_ocupado),
	.hex0_out(hex0_out),
	.hex1_out(hex1_out),
	.db_botao(db_botao),
	.receptor_acabou(receptor_acabou)
);


always
	#5 clock = !clock;

	initial begin
		$dumpfile("wave.vcd");
        $dumpvars(5, serial_tb);
		
		$finish;
	end
endmodule 