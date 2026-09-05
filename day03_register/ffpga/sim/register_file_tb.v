`timescale 1ns / 1ps

module register_file_tb;

reg        clk;
reg        reset;

reg        write_enable;
reg  [1:0] write_addr;
reg  [7:0] write_data;

reg  [1:0] read_addr_a;
reg  [1:0] read_addr_b;

wire [7:0] read_data_a;
wire [7:0] read_data_b;


// ==============================
// DUT
// ==============================

register_file dut (
    .clk(clk),
    .reset(reset),

    .write_enable(write_enable),
    .write_addr(write_addr),
    .write_data(write_data),

    .read_addr_a(read_addr_a),
    .read_addr_b(read_addr_b),

    .read_data_a(read_data_a),
    .read_data_b(read_data_b)
);


// ==============================
// Clock
// 10ns周期
// ==============================

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end


// ==============================
// Test
// ==============================

initial begin

    // --------------------------
    // 初期値
    // --------------------------

    reset        = 0;
    write_enable = 0;
    write_addr   = 0;
    write_data   = 0;
    read_addr_a  = 0;
    read_addr_b  = 0;


    // --------------------------
    // ① Reset
    // --------------------------

    reset = 1;

    @(posedge clk);
    #1;

    // R0 / R1を確認
    read_addr_a = 2'b00;
    read_addr_b = 2'b01;
    #1;

    $display(
        "RESET: R0=%d R1=%d",
        read_data_a,
        read_data_b
    );

    // R2 / R3を確認
    read_addr_a = 2'b10;
    read_addr_b = 2'b11;
    #1;

    $display(
        "RESET: R2=%d R3=%d",
        read_data_a,
        read_data_b
    );

    reset = 0;


    // --------------------------
    // ② R0 ← 10
    // --------------------------

    write_enable = 1;
    write_addr   = 2'b00;
    write_data   = 8'd10;

    @(posedge clk);
    #1;

    read_addr_a = 2'b00;
    #1;

    $display(
        "WRITE: R0=%d",
        read_data_a
    );


    // --------------------------
    // ③ R1 ← 20
    // --------------------------

    write_addr = 2'b01;
    write_data = 8'd20;

    @(posedge clk);
    #1;

    read_addr_a = 2'b01;
    #1;

    $display(
        "WRITE: R1=%d",
        read_data_a
    );


    // --------------------------
    // ④ R2 ← 30
    // --------------------------

    write_addr = 2'b10;
    write_data = 8'd30;

    @(posedge clk);
    #1;

    read_addr_a = 2'b10;
    #1;

    $display(
        "WRITE: R2=%d",
        read_data_a
    );


    // --------------------------
    // ⑤ R3 ← 40
    // --------------------------

    write_addr = 2'b11;
    write_data = 8'd40;

    @(posedge clk);
    #1;

    read_addr_a = 2'b11;
    #1;

    $display(
        "WRITE: R3=%d",
        read_data_a
    );


    // --------------------------
    // ⑥ 2ポート同時読み出し
    // R1とR3を同時に読む
    // --------------------------

    write_enable = 0;

    read_addr_a = 2'b01; // R1
    read_addr_b = 2'b11; // R3

    #1;

    $display(
        "DUAL READ: R1=%d R3=%d",
        read_data_a,
        read_data_b
    );


    // --------------------------
    // ⑦ write_enable=0の確認
    //
    // R1へ99を書こうとする
    // → R1は20のままのはず
    // --------------------------

    write_enable = 0;
    write_addr   = 2'b01;
    write_data   = 8'd99;

    @(posedge clk);
    #1;

    read_addr_a = 2'b01;
    #1;

    $display(
        "WRITE DISABLED: R1=%d",
        read_data_a
    );


    // --------------------------
    // 終了
    // --------------------------

    $finish;

end

endmodule