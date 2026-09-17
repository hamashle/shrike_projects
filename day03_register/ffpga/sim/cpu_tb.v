`timescale 1ns / 1ps

module cpu_tb;

    reg clk;
    reg reset;

    wire [7:0] alu_result;
    wire carry_out;
    wire [7:0] debug_read_data_a;
    wire [7:0] debug_r2;
    wire [7:0] debug_io;

    cpu dut (
        .clk(clk),
        .reset(reset),

        .alu_result(alu_result),
        .carry_out(carry_out),
        .debug_r2(debug_r2),
        .debug_io(debug_io)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        #10;
        reset = 0;

        // ROMの命令を順番に実行する時間を待つ
        #100;
		$display("IO = %d", debug_io);

        $finish;
    end

endmodule