// Custom testbench

`timescale 1ns / 1ps

module instruction_decoder_tb;

    reg [15:0] instruction;

    wire [3:0] opcode;
    wire [1:0] rd;
    wire [1:0] rs;
    wire [7:0] immediate;

  instruction_decoder dut(
     .instruction(instruction),
     .opcode(opcode),
     .rd(rd),
     .rs(rs),
     .immediate(immediate)
  );

  initial begin

    instruction = 16'b0001_01_10_00001010;
    #1
    $display("opcode = %b, rd = %b, rs = %b, immediate = %b",opcode, rd, rs, immediate);

    $finish;
  end

endmodule
