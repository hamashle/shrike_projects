`timescale 1ns / 1ps

module instruction_fetch_tb;

reg clk;
reg reset;

wire [7:0]  pc;
wire [15:0] instruction;
wire [3:0]  opcode;
wire [1:0]  rd;
wire [1:0]  rs;
wire [7:0]  immediate;

instruction_fetch dut (
    .clk(clk),
    .reset(reset),
    .pc(pc),
    .instruction(instruction),
    .opcode(opcode),
    .rd(rd),
    .rs(rs),
    .immediate(immediate)
);


// クロック生成
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end


// テスト
initial begin

    // リセット
    reset = 1;

    @(posedge clk);
    #1;

    $display(
        "PC=%d INST=%b OP=%b RD=%b RS=%b IMM=%d",
        pc, instruction, opcode, rd, rs, immediate
    );

    // PCを進める
    reset = 0;

    @(posedge clk);
    #1;

    $display(
        "PC=%d INST=%b OP=%b RD=%b RS=%b IMM=%d",
        pc, instruction, opcode, rd, rs, immediate
    );

    $finish;

end

endmodule