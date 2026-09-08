// Custom testbench

`timescale 1ns/1ps

module control_unit_tb;

    reg  [3:0] opcode;

    wire       write_enable;
    wire [1:0] alu_op;
    wire       use_immediate;

    control_unit dut (
        .opcode(opcode),
        .write_enable(write_enable),
        .alu_op(alu_op),
        .use_immediate(use_immediate)
    );

    initial begin

       opcode = 4'b0000;
		#1;

		$display(
    		"NOP: WE=%b ALU_OP=%b IMM=%b",
    		write_enable,
    	    alu_op,
            use_immediate
	    );
        
        opcode = 4'b0001;
		#1;
	
		$display(
    		"LOADI: WE=%b ALU_OP=%b IMM=%b",
    		write_enable,
    		alu_op,
    		use_immediate
		);
		

		//ADD  → opcode 0010
		opcode = 4'b0010;
		#1;
		$display(
    		"ADD: WE=%b ALU_OP=%b IMM=%b",
    		write_enable,
    		alu_op,
    		use_immediate
		);
		
		
		//AND  → opcode 0011
		opcode = 4'b0011;
		#1;
		$display(
    		"AND: WE=%b ALU_OP=%b IMM=%b",
    		write_enable,
    		alu_op,
    		use_immediate
		);
		
		
		//OR   → opcode 0100
		opcode = 4'b0100;
		#1;
		$display(
    		"OR: WE=%b ALU_OP=%b IMM=%b",
    		write_enable,
    		alu_op,
    		use_immediate
		);
		
		
		//XOR  → opcode 0101
		opcode = 4'b0101;
		#1;
		$display(
    		"XOR: WE=%b ALU_OP=%b IMM=%b",
    		write_enable,
    		alu_op,
    		use_immediate
		);
		
		 $finish;
    end
    

endmodule