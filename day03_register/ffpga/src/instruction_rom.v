// Custom Module

module instruction_rom (
    input  wire [7:0]  addr,
    output reg  [15:0] instruction
);

always @(*) begin
    case (addr)

        // LOADI R0, 10
        // opcode=0001, rd=00, unused=00, immediate=00001010
       8'd0: instruction = 16'b0110_00_00_00000010; // JUMP 2

	   8'd1: instruction = 16'b0001_00_00_01100011; // LOADI R0, 99（実行されない）

	   8'd2: instruction = 16'b0001_00_00_00001010; // LOADI R0, 10

       8'd3: instruction = 16'b0001_01_00_00010100; // LOADI R1, 20

       8'd4: instruction = 16'b0010_10_00_01_000000; // ADD R2, R0, R1

	   default: instruction = 16'd0;

    endcase
end

endmodule