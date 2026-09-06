// Custom testbench

`timescale 1ns / 1ps

module program_counter_tb;

reg clk;
reg reset;
reg load;
reg [7:0] load_addr;

wire [7:0] pc;

program_counter dut (
    .clk(clk),
    .reset(reset),
    .load(load),
    .load_addr(load_addr),
    .pc(pc)
);

initial begin
   clk = 0;
   forever #5 clk = ~clk;
end

initial begin
    // テスト
    reset     = 0;
    load      = 0;
    load_addr = 0;
    
    reset = 1;

	@(posedge clk);
	#1;

	$display("RESET: pc=%d", pc);

	reset = 0;
	load = 0;
	
	@(posedge clk);
	#1;
	
	$display("COUNT: pc=%d", pc);
	
	@(posedge clk);
	#1;
	
	$display("COUNT: pc=%d", pc);
	
	
	load      = 1;
	load_addr = 8'd100;

	@(posedge clk);
	#1;

	$display("LOAD: pc=%d", pc);
	
	load = 0;

	@(posedge clk);
	#1;
	$display("COUNT: pc=%d", pc);

	@(posedge clk);
	#1;
	$display("COUNT: pc=%d", pc);
	
	load = 1;
	load_addr = 8'd254;
	
	@(posedge clk);
	#1;
	$display("COUNT: pc=%d", pc);
	
	load = 0;
	
	@(posedge clk);
	#1;
	$display("COUNT: pc=%d", pc);
	
	@(posedge clk);
	#1;
	$display("OVERFLOW: pc=%d", pc);
	
	$finish;
end

endmodule
