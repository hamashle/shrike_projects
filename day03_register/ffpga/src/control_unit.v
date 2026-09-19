// Custom Module

module control_unit (
    input  wire [3:0] opcode,

    output reg        write_enable,
    output reg [2:0]  alu_op,
    output reg [1:0]  write_select,
    output reg        pc_load,
    output reg flag_write_enable,
    output reg jump_if_zero,
    output reg mem_write_enable
);

always @(*) begin

    // デフォルト値
    write_enable  = 1'b0;
    alu_op = 3'b000;
    write_select = 2'b00;
    pc_load = 1'b0;
    flag_write_enable = 1'b0;
    jump_if_zero = 1'b0;
    mem_write_enable = 1'b0;

    case (opcode)

        4'b0000: begin // NOP
            // 何もしない
        end

        4'b0001: begin // LOADI
            write_enable = 1'b1;
            write_select = 2'b01;
        end

        4'b0010: begin // ADD
            write_enable = 1'b1;
            alu_op = 3'b011;
            write_select = 2'b00;
            flag_write_enable = 1'b1;
        end

        4'b0011: begin // AND
        	    write_enable = 1'b1;
        	    alu_op = 3'b000;
        	    write_select = 2'b00;
        	    flag_write_enable = 1'b1;
        end
        
         4'b0100: begin // OR
        	    write_enable = 1'b1;
        	    alu_op = 3'b001;
        	    write_select = 2'b00;
        	    flag_write_enable = 1'b1;
        end
        
         4'b0101: begin // XOR
        	    write_enable = 1'b1;
        	    alu_op = 3'b010;
        	    write_select = 2'b00;
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
    			write_select     = 2'b00;
    			flag_write_enable = 1'b1;
		end
		4'b1001: begin // LOAD
    			write_enable = 1'b1;
    			write_select = 2'b10;
		end
		4'b1010: begin // STORE
    			mem_write_enable = 1'b1;
		end
		4'b1011: begin // LOADR
    			write_enable = 1'b1;
    			write_select = 2'b10;
		end
    endcase

end

endmodule
