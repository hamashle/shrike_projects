// Custom testbench

`timescale 1ns / 1ps

module data_memory_tb;

    reg        clk;
    reg        write_enable;
    reg  [7:0] address;
    reg  [7:0] write_data;
    wire [7:0] read_data;

    data_memory dut (
        .clk(clk),
        .write_enable(write_enable),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    always #5 clk = ~clk;
    
    initial begin
    	clk = 0;
    	write_enable = 0;
    	address = 0;
    	write_data = 0;
    	
    	address = 10;
    	write_data = 42;
    	write_enable = 1;
    	
    	@(posedge clk);
    	
    	#1;
    	write_enable = 0;
    	
    	address = 10;
    	#1;
    	
    	$display("read_data = %d", read_data);
    	$finish;
    end

endmodule
