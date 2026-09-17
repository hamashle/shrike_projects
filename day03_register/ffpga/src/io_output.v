module io_output(
    input  wire       clk,
    input  wire       write_enable,
    input  wire [7:0] write_data,

    output wire [7:0] io_data
);

reg [7:0] register8;

always @(posedge clk) begin
    if (write_enable) begin
        register8 <= write_data;
    end
end

assign io_data = register8;

endmodule