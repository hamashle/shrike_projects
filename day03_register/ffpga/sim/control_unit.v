// Custom testbench

`timescale 1ns / 1ps

module control_unit;

  initial begin

    $dumpfile ("control_unit.vcd");
    $dumpvars (0, control_unit);

    $finish;
  end

endmodule
