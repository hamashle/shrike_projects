// Custom testbench

`timescale 1ns / 1ps

module instruction_rom_tb;

  reg [7:0] addr;
  wire [15:0] instruction;
  
  instruction_rom dut(
  	.addr(addr),
  	.instruction(instruction)
  );

  initial begin

    addr = 8'd0;
    #1;
    $display("addr=0 inst=%b", instruction);

    addr = 8'd1;
    #1;
    $display("addr=1 inst=%b", instruction);


    $finish;
  end

endmodule
