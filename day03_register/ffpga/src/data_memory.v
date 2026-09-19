// Custom Module

module data_memory(
	input wire clk,
	input wire write_enable,
	input wire [7:0] address,
	input wire [7:0] write_data,
	output wire [7:0] read_data
);

reg [7:0] memory [0:255];

always @(posedge clk) begin
    if (write_enable) begin
        memory[address] <= write_data;
    end
end

assign read_data = memory[address];

initial begin
    memory[0] = 8'h48; // 'H'
    memory[1] = 8'h69; // 'i'
    memory[2] = 8'h00; // '\0'
end

endmodule
