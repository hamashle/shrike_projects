// Custom Module

module program_counter (
    input  wire       clk,
    input  wire       reset,
    input  wire       load,
    input  wire [7:0] load_addr,
    output reg  [7:0] pc
);

always @(posedge clk) begin
    if (reset) begin
        pc <= 8'd0;
    end
    else if (load) begin
        pc <= load_addr;
    end
    else begin
        pc <= pc + 1'b1;
    end
end

endmodule
