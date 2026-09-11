module instruction_fetch (
    input wire clk,
    input wire reset,

    output wire [7:0]  pc,
    output wire [15:0] instruction,

    output wire [3:0] opcode,
    output wire [1:0] rd,
    output wire [1:0] rs1,
    output wire [1:0] rs2,
    output wire [7:0] immediate
);

program_counter pc_unit (
    .clk      (clk),
    .reset    (reset),
    .load     (1'b0),
    .load_addr(8'd0),
    .pc       (pc)
);

instruction_rom rom_unit (
    .addr        (pc),
    .instruction (instruction)
);

instruction_decoder decoder_unit (
    .instruction(instruction),
    .opcode     (opcode),
    .rd         (rd),
    .rs1        (rs1),
    .rs2        (rs2),
    .immediate  (immediate)
);

endmodule