// Custom Module

module instruction_rom (
    input  wire [7:0]  addr,
    output reg  [15:0] instruction
);

always @(*) begin
    case (addr)

        8'd0: instruction = 16'b0001_01_10_00001010;
        8'd1: instruction = 16'b0010_10_01_00010100;

        default: instruction = 16'd0;

    endcase
end

endmodule