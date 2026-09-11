// Custom Module

module instruction_rom (
    input  wire [7:0]  addr,
    output reg  [15:0] instruction
);

always @(*) begin
    case (addr)

        // LOADI R0, 10
        // opcode=0001, rd=00, unused=00, immediate=00001010
        8'd0: instruction = 16'b0001_00_00_00001010;

        // LOADI R1, 20
        // opcode=0001, rd=01, unused=00, immediate=00010100
        8'd1: instruction = 16'b0001_01_00_00010100;

        // ADD R2, R0, R1
        // opcode=0010, rd=10, rs1=00, rs2=01, unused=000000
        8'd2: instruction = 16'b0010_10_00_01_000000;

        // NOP
        8'd3: instruction = 16'b0000_0000_0000_0000;

        default: instruction = 16'd0;

    endcase
end

endmodule