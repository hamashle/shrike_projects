(* top *) module main (
    (* iopad_external_pin, clkbuf_inhibit *) input  clk,
    (* iopad_external_pin *) output LED,
    (* iopad_external_pin *) output LED_en,
    (* iopad_external_pin *) output clk_en
);


reg [22:0] counter = 0;

assign LED_en = 1'b1;
assign clk_en = 1'b1;

always @(posedge clk) begin
    counter <= counter + 1'b1;
end

assign LED = counter[22];

endmodule