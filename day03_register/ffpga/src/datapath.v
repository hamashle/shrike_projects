// Custom Module

module datapath (
    input  wire       clk,
    input  wire       reset,

    input  wire       write_enable,
    input  wire [1:0] write_addr,
    input  wire [1:0] read_addr_a,
    input  wire [1:0] read_addr_b,

    input  wire [1:0] alu_op,

    input  wire [7:0] external_data,
    input  wire       write_select,

    output wire [7:0] alu_result,
    output wire       carry_out,
    output wire [7:0] debug_read_data_a,
    output wire [7:0] debug_r2
);

    wire [7:0] read_data_a;
    wire [7:0] read_data_b;
    wire [7:0] write_data;

    // write_select = 1 → external_data
    // write_select = 0 → alu_result
    assign write_data = write_select ? external_data : alu_result;
    assign debug_read_data_a = read_data_a;

    register_file rf (
        .clk(clk),
        .reset(reset),

        .write_enable(write_enable),
        .write_addr(write_addr),
        .write_data(write_data),

        .read_addr_a(read_addr_a),
        .read_addr_b(read_addr_b),

        .read_data_a(read_data_a),
        .read_data_b(read_data_b),
        .debug_r2(debug_r2)
    );

    alu8 alu (
        .a(read_data_a),
        .b(read_data_b),
        .op(alu_op),
        .result(alu_result),
        .carry_out(carry_out)
    );

endmodule