// Custom Module

module alu8 (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [1:0] op,
    output wire [7:0] result,
    output wire       carry_out
);

wire [7:0] and_result;
wire [7:0] or_result;
wire [7:0] xor_result;
wire [7:0] add_result;
wire       add_carry;

assign and_result = a & b;
assign or_result  = a | b;
assign xor_result = a ^ b;

adder8 adder (
    .a   (a),
    .b   (b),
    .cin (1'b0),
    .sum (add_result),
    .cout(add_carry)
);

assign result =
    (op == 2'b00) ? and_result :
    (op == 2'b01) ? or_result :
    (op == 2'b10) ? xor_result :
                     add_result;

assign carry_out =
    (op == 2'b11) ? add_carry : 1'b0;

endmodule
