// Custom Module

module cpu (
    input  wire       clk,
    input  wire       reset,

    output wire [7:0] alu_result,
    output wire       carry_out,
    output wire uart_tx_out,
    output wire [7:0] debug_r2,
    output wire [7:0] debug_io
);


wire [7:0] memory_data;
wire [7:0] memory_write_data;
wire [7:0] io_data;

wire       write_enable;
wire [2:0] alu_op;
wire [1:0] write_select;
wire       mem_write_enable;
wire [7:0] pc;

wire [3:0] opcode_decoded;
wire [1:0] rd;
wire [1:0] rs1;
wire [1:0] rs2;
wire [7:0] immediate;

wire [15:0] instruction;

wire pc_load;

wire zero_flag;
reg  zero_flag_reg;

wire flag_write_enable;

wire jump_if_zero;
wire should_jump;

wire [1:0] read_addr_a_selected;

wire io_selected;

wire data_mem_write_enable;

wire io_write_enable;

wire uart_busy;

wire [7:0] uart_status;

wire [7:0] load_data;

assign load_data =
    (immediate == 8'hFE) ? uart_status : memory_data;

assign uart_status = {7'b0000000, uart_busy};

assign io_selected = (immediate == 8'hFF);

assign data_mem_write_enable =
    mem_write_enable & ~io_selected;

assign read_addr_a_selected =
    (opcode_decoded == 4'b1010) ? rd : rs1;

assign should_jump =
    pc_load | (jump_if_zero & zero_flag_reg);
    

assign io_write_enable =
    mem_write_enable & io_selected;
    
assign debug_io = io_data;

control_unit cu (
    .opcode(opcode_decoded),
    .write_enable(write_enable),
    .alu_op(alu_op),
    .write_select(write_select),
    .pc_load(pc_load),
    .flag_write_enable(flag_write_enable),
    .jump_if_zero(jump_if_zero),
    .mem_write_enable(mem_write_enable)
);

program_counter pc_unit (
    .clk(clk),
    .reset(reset),
    .load(should_jump),
	.load_addr(immediate),
    .pc(pc)
);

datapath dp (
    .clk(clk),
    .reset(reset),

    .write_enable(write_enable),

    .write_addr(rd),
    .read_addr_a(read_addr_a_selected),
    .read_addr_b(rs2),

    .alu_op(alu_op),

    .external_data(immediate),
    .memory_data(load_data),
    .write_select(write_select),

    .alu_result(alu_result),
    .carry_out(carry_out),
    .zero_flag(zero_flag),

    .memory_write_data(memory_write_data),

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

data_memory data_mem (
    .clk(clk),
    .write_enable(data_mem_write_enable),
    .address(immediate),
    .write_data(memory_write_data),
    .read_data(memory_data)
);

uart_tx uart (
    .clk   (clk),
    .reset (reset),
    .start (io_write_enable),
    .data  (memory_write_data),
    .tx    (uart_tx_out),
    .busy  (uart_busy)
);

always @(posedge clk) begin
    if (reset) begin
        zero_flag_reg <= 1'b0;
    end
    else if (flag_write_enable) begin
        zero_flag_reg <= zero_flag;
    end
end

endmodule