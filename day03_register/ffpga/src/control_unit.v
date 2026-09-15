// Custom Module

module control_unit (
    input  wire [3:0] opcode,

    output reg        write_enable,
    output reg [2:0]  alu_op,
    output reg        use_immediate,
    output reg        pc_load,
    output reg flag_write_enable,
    output reg jump_if_zero
);

always @(*) begin

    // デフォルト値
    write_enable  = 1'b0;
    alu_op = 3'b000;
    use_immediate = 1'b0;
    pc_load = 1'b0;
    flag_write_enable = 1'b0;
    jump_if_zero = 1'b0;

    case (opcode)

        4'b0000: begin // NOP
            // 何もしない
        end

        4'b0001: begin // LOADI
            write_enable = 1'b1;
            use_immediate = 1'b1;
        end

        4'b0010: begin // ADD
            write_enable = 1'b1;
            alu_op = 2'b11;
            use_immediate = 1'b0;
            flag_write_enable = 1'b1;
        end

        4'b0011: begin // AND
        	    write_enable = 1'b1;
        	    alu_op = 2'b00;
        	    use_immediate = 1'b0;
        	    flag_write_enable = 1'b1;
        end
        
         4'b0100: begin // OR
        	    write_enable = 1'b1;
        	    alu_op = 2'b01;
        	    use_immediate = 1'b0;
        	    flag_write_enable = 1'b1;
        end
        
         4'b0101: begin // XOR
        	    write_enable = 1'b1;
        	    alu_op = 2'b10;
        	    use_immediate = 1'b0;
        	    flag_write_enable = 1'b1;
        end
        
        4'b0110: begin // JUMP
    			pc_load = 1'b1;
		end
		4'b0111: begin // JZ
    			jump_if_zero = 1'b1;
		end
		4'b1000: begin // SUB
    			write_enable      = 1'b1;
    			alu_op            = 3'b100;
    			use_immediate     = 1'b0;
    			flag_write_enable = 1'b1;
		end
    endcase

end

endmodule
