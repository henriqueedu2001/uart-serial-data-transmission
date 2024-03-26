module serial (
	input fpga_clock,
	input enable,
	output tx, //fio serial de transmissão
	output done,
	output busy,
	output db_clock
);
	// Want to interface to 9600 baud UART
	// 50000000 / 9600 = 5208 Clocks Per Bit (clock 50 MHz)

	
uart_tx #(5208) UART_TX_INST (
		.i_Clock(fpga_clock),
		.i_Tx_DV(enable), //enable
		.i_Tx_Byte(8'b01000001), 
		.o_Tx_Active(busy), //busy
		.o_Tx_Serial(tx),
		.o_Tx_Done(done) // pronto
	);
	
	assign db_clock = fpga_clock;
	
endmodule 