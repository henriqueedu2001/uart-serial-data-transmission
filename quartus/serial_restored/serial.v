module serial (
	input clock,
	input iniciar_transmissao,
	input entrada_serial, // para o receptor serial
	output saida_serial, // fio serial de transmissão para o transmissor
	output transmissor_acabou,
	output transmissor_ocupado,
	output [6:0] hex0_out,
	output [6:0] hex1_out,
	output db_botao,
	output receptor_acabou
);

// Want to interface to 9600 baud UART
// 50000000 / 9600 = 5208 Clocks Per Bit (clock 50 MHz)	
uart_tx #(5208) UART_TX_INST (
		.i_Clock(clock),
		.i_Tx_DV(wire_iniciar_transmissao),  // enable
		.i_Tx_Byte(8'b01000001),// dado
		.o_Tx_Active(transmissor_ocupado),     // busy
		.o_Tx_Serial(saida_serial),
		.o_Tx_Done(transmissor_acabou)        // pronto
	);
	
	wire wire_iniciar_transmissao;
	wire [7:0] data;
	wire receptor_terminou;

	edge_detector edge_detector (
		.clock(clock),
		.reset(),
		.sinal(iniciar_transmissao),
		.pulso(wire_iniciar_transmissao)
	);



	uart_rx #(5208) uart_rx (
	.i_Clock    (clock),
	.i_Rx_Serial(entrada_serial),    // entrada serial
	.o_Rx_DV    (receptor_terminou), // recepção concluida 
	.o_Rx_Byte  (data)               //dado pronto
	);

	reg [7:0] dado_recebido;
	initial begin
		dado_recebido <= 8'b0011_0001;
	end

	always @(posedge clock) begin
		if(receptor_terminou) dado_recebido <= data;
	end


	assign db_botao = ~iniciar_transmissao;
	
	hexa7seg hex0 (
    .hexa(dado_recebido[3:0]),
    .display(hex0_out)
	);

	hexa7seg hex1 (
    .hexa(dado_recebido[7:4]),
    .display(hex1_out)
	);
	
endmodule 