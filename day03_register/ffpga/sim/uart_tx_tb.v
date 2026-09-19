`timescale 1ns / 1ps

module cpu_tb;

    reg clk;
    reg reset;

    wire [7:0] alu_result;
    wire       carry_out;
    wire [7:0] debug_r2;
    wire [7:0] debug_io;
    wire       uart_tx_out;

    cpu dut (
        .clk         (clk),
        .reset       (reset),
        .alu_result  (alu_result),
        .carry_out   (carry_out),
        .uart_tx_out (uart_tx_out),
        .debug_r2    (debug_r2),
        .debug_io    (debug_io)
    );

    always #5 clk = ~clk;

    initial begin
        clk   = 0;
        reset = 1;

        #10;
        reset = 0;

        // =========================
        // 1文字目: H
        // =========================
        @(negedge uart_tx_out);

        #2170;
        $display("1st Start  = %b", uart_tx_out);

        #4340; $display("1st Data 0 = %b", uart_tx_out);
        #4340; $display("1st Data 1 = %b", uart_tx_out);
        #4340; $display("1st Data 2 = %b", uart_tx_out);
        #4340; $display("1st Data 3 = %b", uart_tx_out);
        #4340; $display("1st Data 4 = %b", uart_tx_out);
        #4340; $display("1st Data 5 = %b", uart_tx_out);
        #4340; $display("1st Data 6 = %b", uart_tx_out);
        #4340; $display("1st Data 7 = %b", uart_tx_out);
        #4340; $display("1st Stop   = %b", uart_tx_out);

        // =========================
        // 2文字目: i
        // =========================
        @(negedge uart_tx_out);

        #2170;
        $display("2nd Start  = %b", uart_tx_out);

        #4340; $display("2nd Data 0 = %b", uart_tx_out);
        #4340; $display("2nd Data 1 = %b", uart_tx_out);
        #4340; $display("2nd Data 2 = %b", uart_tx_out);
        #4340; $display("2nd Data 3 = %b", uart_tx_out);
        #4340; $display("2nd Data 4 = %b", uart_tx_out);
        #4340; $display("2nd Data 5 = %b", uart_tx_out);
        #4340; $display("2nd Data 6 = %b", uart_tx_out);
        #4340; $display("2nd Data 7 = %b", uart_tx_out);
        #4340; $display("2nd Stop   = %b", uart_tx_out);

        // UART送信完了とCPUの終端処理を少し待つ
        #10000;

        $display("------------------------");
        $display("Final PC = %d", dut.pc);
        $display("Final R0 = %d", dut.dp.rf.r0_data);
        $display("Final R3 = %d", dut.dp.rf.r3_data);
        $display("------------------------");

        $finish;
    end

endmodule