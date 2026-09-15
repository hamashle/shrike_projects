// Custom Module

module instruction_rom (
    input  wire [7:0]  addr,
    output reg  [15:0] instruction
);

always @(*) begin
    case (addr)

    	// LOADI R0, 42
    	8'd0: instruction = 16'b0001_00_00_00101010;

    	// STORE R0, [20]
    	8'd1: instruction = 16'b1010_00_00_00010100;

    	// LOAD R2, [20]
    	8'd2: instruction = 16'b1001_10_00_00010100;

    	// NOP
    	8'd3: instruction = 16'b0000_0000_0000_0000;

    	default: instruction = 16'd0;

	endcase
end

endmodule