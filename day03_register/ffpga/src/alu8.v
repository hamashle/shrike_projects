// Custom Module

// Custom Module

module alu8 (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [2:0] op,
    output wire [7:0] result,
    output wire       carry_out,
    output wire       zero_flag
);

wire [7:0] and_result;
wire [7:0] or_result;
wire [7:0] xor_result;
wire [7:0] add_result;
wire       add_carry;
wire [7:0] sub_result;
wire       sub_carry;

assign and_result = a & b;
assign or_result  = a | b;
assign xor_result = a ^ b;
assign zero_flag = (result == 8'd0);

adder8 adder (
    .a   (a),
    .b   (b),
    .cin (1'b0),
    .sum (add_result),
    .cout(add_carry)
);

adder8 subtractor (
    .a   (a),
    .b   (~b),
    .cin (1'b1),
    .sum (sub_result),
    .cout(sub_carry)
);

assign result =
    (op == 3'b000) ? and_result :
    (op == 3'b001) ? or_result :
    (op == 3'b010) ? xor_result :
    (op == 3'b011) ? add_result :
    (op == 3'b100) ? sub_result :
                     8'd0;

assign carry_out =
    (op == 3'b011) ? add_carry : 1'b0;
assign zero_flag = (result == 8'd0);
endmodule

