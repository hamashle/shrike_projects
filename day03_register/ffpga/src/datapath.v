// Custom Module

module datapath (
    input  wire       clk,
    input  wire       reset,

    input  wire       write_enable,
    input  wire [1:0] write_addr,
    input  wire [1:0] read_addr_a,
    input  wire [1:0] read_addr_b,

    input  wire [2:0] alu_op,

    input  wire [7:0] external_data,
    input  wire [1:0] write_select,
    input wire [7:0] memory_data,

    output wire [7:0] alu_result,
    output wire       carry_out,
    output wire [7:0] debug_read_data_a,
    output wire [7:0] debug_r2,
    output wire zero_flag,
    output wire [7:0] memory_write_data,
    output wire [7:0] register_data_a
);

    wire [7:0] read_data_a;
    wire [7:0] read_data_b;
    wire [7:0] write_data;
    
    assign register_data_a = read_data_a;

    // write_select
	// 00: ALU result
	// 01: immediate
	// 10: memory data
    assign write_data =
    				(write_select == 2'b00) ? alu_result :
    				(write_select == 2'b01) ? external_data :
    				(write_select == 2'b10) ? memory_data :
                              				  8'd0;
                              				  
    assign memory_write_data = read_data_a;                      	    				  	
    					
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
        .carry_out(carry_out),
        .zero_flag(zero_flag)
    );

endmodule