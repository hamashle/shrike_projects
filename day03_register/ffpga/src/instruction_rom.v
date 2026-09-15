// Custom Module

module instruction_rom (
    input  wire [7:0]  addr,
    output reg  [15:0] instruction
);

always @(*) begin
    case (addr)

       8'd0: instruction = 16'b0001_00_00_00000011; // LOADI R0, 3
	   8'd1: instruction = 16'b0001_01_00_00000001; // LOADI R1, 1

       8'd2: instruction = 16'b1000_00_00_01_000000; // SUB R0, R0, R1

       8'd3: instruction = 16'b0111_00_00_00000101; // JZ 5
       8'd4: instruction = 16'b0110_00_00_00000010; // JUMP 2

       8'd5: instruction = 16'b0001_10_00_01100011; // LOADI R2, 99

	default: instruction = 16'd0;

    endcase
end

endmodule