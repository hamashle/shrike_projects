// Custom testbench

`timescale 1ns / 1ps

module uart_tx_tb;

	reg        clk;
	reg        reset;
	reg        start;
	reg  [7:0] data;

	wire tx;
	wire busy;

	uart_tx uut (
    	.clk(clk),
    	.reset(reset),
    	.start(start),
    	.data(data),
    	.tx(tx),
    	.busy(busy)
	);

	always #5 clk = ~clk;

	initial begin
    	clk   = 0;
    	reset = 1;
    	start = 0;
    	data  = 8'd0;

    	#20;
    	reset = 0;

    	#10;
    	data  = 8'd72;  // 'H' = 0x48
    	start = 1;

    	#10;
    	start = 0;

    	// Start bit の中央付近まで待つ
    	#2000;
    	$display("Start  = %b", tx);

    	// 以降、約1bitごとに確認
    	#4340;
    	$display("Data 0 = %b", tx);

    	#4340;
    	$display("Data 1 = %b", tx);

    	#4340;
    	$display("Data 2 = %b", tx);

    	#4340;
    	$display("Data 3 = %b", tx);

    	#4340;
    	$display("Data 4 = %b", tx);

    	#4340;
    	$display("Data 5 = %b", tx);

    	#4340;
    	$display("Data 6 = %b", tx);

    	#4340;
    	$display("Data 7 = %b", tx);

    	#4340;
    	$display("Stop   = %b", tx);

    	wait (busy == 0);

    	$display("UART transmission finished");
    	$finish;
	end

endmodule