// Custom Module

module instruction_rom (
    input  wire [7:0]  addr,
    output reg  [15:0] instruction
);

always @(*) begin
    case (addr)
    	8'd0: instruction = 16'b0001_10_00_00000000; // LOADI R2,0

		8'd1: instruction = 16'b1001_01_00_11111110; // LOAD R1,[0xFE]
		8'd2: instruction = 16'b1000_01_01_10_000000; // SUB R1,R1,R2
		8'd3: instruction = 16'b0111_00_00_00000101; // JZ 5
		8'd4: instruction = 16'b0110_00_00_00000001; // JUMP 1
		8'd5: instruction = 16'b0001_00_00_01001000; // LOADI R0,72 ('H')
		8'd6: instruction = 16'b1010_00_00_11111111; // STORE R0,[0xFF]
		8'd7: instruction = 16'b0001_00_00_01101001; // LOADI R0,'i'
		8'd8: instruction = 16'b1001_01_00_11111110; // LOAD R1,[0xFE]
		8'd9: instruction = 16'b1000_01_01_10_000000; // SUB R1,R1,R2
		8'd10: instruction = 16'b0111_00_00_00001100; // JZ 12
		8'd11: instruction = 16'b0110_00_00_00001000; // JUMP 8
		8'd12: instruction = 16'b1010_00_00_11111111; // STORE R0,[0xFF]
    	default: instruction = 16'd0;
	endcase
end

endmodule