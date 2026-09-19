// Custom Module

module instruction_rom (
    input  wire [7:0]  addr,
    output reg  [15:0] instruction
);

always @(*) begin
    case (addr)

        8'd0:  instruction = 16'b0001_10_00_00000001; // LOADI R2,1
        8'd1:  instruction = 16'b0001_11_00_00000000; // LOADI R3,0

        // NEXT
        8'd2:  instruction = 16'b1011_00_11_00000000; // LOADR R0,[R3]
        8'd3:  instruction = 16'b0100_01_00_00_000000; // OR R1,R0,R0
        8'd4:  instruction = 16'b0111_00_00_00001011; // JZ 11 (DONE)

        // WAIT
        8'd5:  instruction = 16'b1001_01_00_11111110; // LOAD R1,[0xFE]
        8'd6:  instruction = 16'b1000_01_01_10_000000; // SUB R1,R1,R2
        8'd7:  instruction = 16'b0111_00_00_00000101; // JZ 5 (WAIT)

        8'd8:  instruction = 16'b1010_00_00_11111111; // STORE R0,[0xFF]
        8'd9:  instruction = 16'b0010_11_11_10_000000; // ADD R3,R3,R2
        8'd10: instruction = 16'b0110_00_00_00000010; // JUMP 2 (NEXT)

        // DONE
        8'd11: instruction = 16'b0110_00_00_00001011; // JUMP 11

        default: instruction = 16'b0000_00_00_00000000; // NOP
    endcase
end

endmodule