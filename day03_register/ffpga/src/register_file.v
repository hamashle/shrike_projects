// Custom Module

module register_file (
    input  wire       clk,
    input  wire       reset,

    input  wire       write_enable,
    input  wire [1:0] write_addr,
    input  wire [7:0] write_data,

    input  wire [1:0] read_addr_a,
    input  wire [1:0] read_addr_b,

    output wire [7:0] read_data_a,
    output wire [7:0] read_data_b
);

wire r0_enable;
wire r1_enable;
wire r2_enable;
wire r3_enable;

assign r0_enable = write_enable && (write_addr == 2'b00);
assign r1_enable = write_enable && (write_addr == 2'b01);
assign r2_enable = write_enable && (write_addr == 2'b10);
assign r3_enable = write_enable && (write_addr == 2'b11);


wire [7:0] r0_data;
wire [7:0] r1_data;
wire [7:0] r2_data;
wire [7:0] r3_data;

register8 r0 (
    .clk   (clk),
    .reset (reset),
    .enable(r0_enable),
    .d     (write_data),
    .q     (r0_data)
);

register8 r1 (
    .clk   (clk),
    .reset (reset),
    .enable(r1_enable),
    .d     (write_data),
    .q     (r1_data)
);

register8 r2 (
    .clk   (clk),
    .reset (reset),
    .enable(r2_enable),
    .d     (write_data),
    .q     (r2_data)
);

register8 r3 (
    .clk   (clk),
    .reset (reset),
    .enable(r3_enable),
    .d     (write_data),
    .q     (r3_data)
);

assign read_data_a =
    (read_addr_a == 2'b00) ? r0_data :
    (read_addr_a == 2'b01) ? r1_data :
    (read_addr_a == 2'b10) ? r2_data :
                             r3_data;


assign read_data_b =
    (read_addr_b == 2'b00) ? r0_data :
    (read_addr_b == 2'b01) ? r1_data :
    (read_addr_b == 2'b10) ? r2_data :
                             r3_data;

endmodule
