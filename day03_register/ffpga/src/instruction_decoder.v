// Custom Module

module instruction_decoder (
    input  wire [15:0] instruction,

    output wire [3:0] opcode,
    output wire [1:0] rd,
    output wire [1:0] rs1,
    output wire [1:0] rs2,
    output wire [7:0] immediate
);

assign opcode = instruction[15:12];
assign rd     = instruction[11:10];
assign rs1    = instruction[9:8];
assign rs2    = instruction[7:6];

assign immediate = instruction[7:0];


endmodule
