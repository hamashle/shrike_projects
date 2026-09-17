// Custom Module

module instruction_rom (
    input  wire [7:0]  addr,
    output reg  [15:0] instruction
);

always @(*) begin
    case (addr)
    	8'd0: instruction = 16'b0001_00_00_01001000; // LOADI R0,72 ('H')
    	8'd1: instruction = 16'b1010_00_00_11111111; // STORE R0,[255]
    	8'd2: instruction = 16'b0000_0000_0000_0000; // NOP
    	default: instruction = 16'd0;
	endcase
end

endmodule