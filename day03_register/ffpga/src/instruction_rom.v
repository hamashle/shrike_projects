// Custom Module

module instruction_rom (
    input  wire [7:0]  addr,
    output reg  [15:0] instruction
);

always @(*) begin
    case (addr)

        8'd0: instruction = 16'b0001_00_00_00001010; // LOADI R0, 10
		8'd1: instruction = 16'b0001_01_00_00001011; // LOADI R1, 11

		8'd2: instruction = 16'b0101_10_00_01_000000; // XOR R2,R0,R1 → 1

		8'd3: instruction = 16'b0111_00_00_00000101; // JZ 5

		8'd4: instruction = 16'b0001_10_00_01100011; // LOADI R2,99

		8'd5: instruction = 16'b0000_0000_0000_0000; // NOP
		8'd6: instruction = 16'b0000_0000_0000_0000; // NOP

	   default: instruction = 16'd0;

    endcase
end

endmodule