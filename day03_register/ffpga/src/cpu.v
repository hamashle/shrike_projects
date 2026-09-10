// Custom Module

module cpu (
	input  wire       clk,
    input  wire       reset,

    input  wire [3:0] opcode,

    input  wire [1:0] write_addr,
    input  wire [1:0] read_addr_a,
    input  wire [1:0] read_addr_b,

    input  wire [7:0] external_data,

    output wire [7:0] alu_result,
    output wire       carry_out,
    output wire [7:0] debug_read_data_a
);

wire       write_enable;
wire [1:0] alu_op;
wire       use_immediate;

control_unit cu (
	.opcode(opcode),
    .write_enable(write_enable),
    .alu_op(alu_op),
    .use_immediate(use_immediate)
);

datapath dp (
    .clk(clk),
    .reset(reset),

    .write_enable(write_enable),
    .write_addr(write_addr),
    .read_addr_a(read_addr_a),
    .read_addr_b(read_addr_b),

    .alu_op(alu_op),

    .external_data(external_data),
    .write_select(use_immediate),

    .alu_result(alu_result),
    .carry_out(carry_out),
    .debug_read_data_a(debug_read_data_a)
);

endmodule