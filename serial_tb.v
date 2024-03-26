`timescale 1ns/1ns
module serial_tb;
	
reg fpga_clock;
reg enable;
wire done;
wire busy;
wire tx;
wire db_clock;

serial uut(
	.fpga_clock(fpga_clock),
	.enable(enable),
	.done(done),
	.busy(busy),
	
	.tx(tx), //fio serial de transmissão
	.db_clock(db_clock)
);

always
	#5 fpga_clock = !fpga_clock;

	initial begin
		$dumpfile("wave.vcd");
        $dumpvars(5, serial_tb);
		fpga_clock = 0;
		enable = 1;
		#1000

		enable = 0;

		#1000000;
		$finish;
	end
endmodule 