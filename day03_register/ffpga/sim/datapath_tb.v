// Custom testbench

`timescale 1ns / 1ps

module datapath_tb;

    reg clk;
    reg reset;

    reg       write_enable;
    reg [1:0] write_addr;
    reg [1:0] read_addr_a;
    reg [1:0] read_addr_b;

    reg [1:0] alu_op;

    reg [7:0] external_data;
    reg       write_select;

    wire [7:0] alu_result;
    wire       carry_out;
    
    wire [7:0] debug_read_data_a;

    datapath dut (
        .clk(clk),
        .reset(reset),

        .write_enable(write_enable),
        .write_addr(write_addr),
        .read_addr_a(read_addr_a),
        .read_addr_b(read_addr_b),

        .alu_op(alu_op),

        .external_data(external_data),
        .write_select(write_select),

        .alu_result(alu_result),
        .carry_out(carry_out),
        .debug_read_data_a(debug_read_data_a)
    );

    // 10ns周期
    always #5 clk = ~clk;

    initial begin
        // 初期化
        clk = 0;
        reset = 1;

        write_enable = 0;
        write_addr = 0;
        read_addr_a = 0;
        read_addr_b = 0;

        alu_op = 0;

        external_data = 0;
        write_select = 0;

        // Reset
        #10;
        reset = 0;

        // -------------------------
        // R0 = 10
        // -------------------------
        write_select = 1;
        external_data = 8'd10;

        write_addr = 2'd0;
        write_enable = 1;

        #10;

        // -------------------------
        // R1 = 20
        // -------------------------
        external_data = 8'd20;

        write_addr = 2'd1;

        #10;

        // -------------------------
        // R2 = R0 + R1
        // -------------------------
        write_select = 0;

        read_addr_a = 2'd0;
        read_addr_b = 2'd1;

        write_addr = 2'd2;

        // ADD
        // alu8.v の定義に合わせる
        alu_op = 2'b11;

        write_enable = 1;

        #10;
        

        // 書き込み終了
        write_enable = 0;
		read_addr_a = 2'd2;

		#1;
		$display("R2 = %d", debug_read_data_a);

        #1;

        $display("ALU result = %d", alu_result);

        $finish;
    end

endmodule