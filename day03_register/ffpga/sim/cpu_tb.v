// Custom testbench

`timescale 1ns / 1ps

module cpu_tb;

    reg clk;
    reg reset;

    reg [3:0] opcode;

    reg [1:0] write_addr;
    reg [1:0] read_addr_a;
    reg [1:0] read_addr_b;

    reg [7:0] external_data;

    wire [7:0] alu_result;
    wire carry_out;
    wire [7:0] debug_read_data_a;

    cpu dut (
        .clk(clk),
        .reset(reset),

        .opcode(opcode),

        .write_addr(write_addr),
        .read_addr_a(read_addr_a),
        .read_addr_b(read_addr_b),

        .external_data(external_data),

        .alu_result(alu_result),
        .carry_out(carry_out),
        .debug_read_data_a(debug_read_data_a)
    );

    always #5 clk = ~clk;
	initial begin
    clk = 0;
    reset = 1;

    opcode = 4'b0000;  // NOP

    write_addr = 0;
    read_addr_a = 0;
    read_addr_b = 0;
    external_data = 0;

    #10;
    reset = 0;
    opcode = 4'b0001;
    write_addr = 2'd0;
    external_data = 8'd10;

    #10;
    
    opcode = 4'b0001;
    write_addr = 2'd1;
    external_data = 8'd20;

    #10;
    
    opcode = 4'b0010;
    read_addr_a = 2'd0;
    read_addr_b = 2'd1;
    write_addr = 2'd2;
    
    #10
    // R2を読み出す
	opcode = 4'b0000;  // NOPにして書き込み停止
	read_addr_a = 2'd2;

	#1;

	$display("R2 = %d", debug_read_data_a);

	$finish;
	end
endmodule