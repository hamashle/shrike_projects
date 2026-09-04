`timescale 1ns / 1ps

module register8_tb;

reg        clk;
reg        reset;
reg        enable;
reg  [7:0] d;

wire [7:0] q;

register8 dut(
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .d(d),
    .q(q)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset  = 1'b0;
    enable = 1'b0;
    d      = 8'd0;

    // reset
    reset = 1'b1;
    @(posedge clk);
    #1;
    $display("RESET: q=%d", q);

    // 42を書き込み
    reset  = 1'b0;
    enable = 1'b1;
    d      = 8'd42;

    @(posedge clk);
    #1;
    $display("WRITE 42: q=%d", q);

    // 保持
    enable = 1'b0;
    d      = 8'd100;

    @(posedge clk);
    #1;
    $display("HOLD: q=%d", q);

    // 100を書き込み
    enable = 1'b1;

    @(posedge clk);
    #1;
    $display("WRITE 100: q=%d", q);

    // reset
    reset = 1'b1;

    @(posedge clk);
    #1;
    $display("RESET: q=%d", q);

    $finish;
end

endmodule