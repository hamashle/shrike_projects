module alu8_tb;

reg  [7:0] a;
reg  [7:0] b;
reg  [1:0] op;

wire [7:0] result;
wire       carry_out;

alu8 dut (
    .a(a),
    .b(b),
    .op(op),
    .result(result),
    .carry_out(carry_out)
);

initial begin
    // 7 + 3
    a  = 8'd7;
    b  = 8'd3;
    op = 2'b11;
    #10;
    $display("ADD: %d + %d = %d, carry=%b",
             a, b, result, carry_out);

    // AND / OR / XOR
    a = 8'b10101010;
    b = 8'b11001100;

    op = 2'b00;
    #10;
    $display("AND: %b", result);

    op = 2'b01;
    #10;
    $display("OR : %b", result);

    op = 2'b10;
    #10;
    $display("XOR: %b", result);

    // 8bit overflow
    a  = 8'd255;
    b  = 8'd1;
    op = 2'b11;
    #10;
    $display("OVERFLOW: result=%d carry=%b",
             result, carry_out);

    $finish;
end

endmodule