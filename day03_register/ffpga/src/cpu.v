// Custom Module

module cpu (
    input  wire       clk,
    input  wire       reset,

    output wire [7:0] alu_result,
    output wire       carry_out,
    output wire [7:0] debug_r2
);

wire       write_enable;
wire [1:0] alu_op;
wire       use_immediate;
wire [7:0] pc;

wire [3:0] opcode_decoded;
wire [1:0] rd;
wire [1:0] rs1;
wire [1:0] rs2;
wire [7:0] immediate;

wire [15:0] instruction;

control_unit cu (
    .opcode(opcode_decoded),
    .write_enable(write_enable),
    .alu_op(alu_op),
    .use_immediate(use_immediate)
);

program_counter pc_unit (
    .clk(clk),
    .reset(reset),
    .load(1'b0),
    .load_addr(8'd0),
    .pc(pc)
);

datapath dp (
    .clk(clk),
    .reset(reset),

    .write_enable(write_enable),

    .write_addr(rd),
    .read_addr_a(rs1),
    .read_addr_b(rs2),

    .alu_op(alu_op),

    .external_data(immediate),
    .write_select(use_immediate),

    .alu_result(alu_result),
    .carry_out(carry_out),
    .debug_r2(debug_r2)
);

instruction_rom rom (
    .addr(pc),
    .instruction(instruction)
);

instruction_decoder decoder (
    .instruction(instruction),
    .opcode(opcode_decoded),
    .rd(rd),
    .rs1(rs1),
    .rs2(rs2),
    .immediate(immediate)
);
endmodule