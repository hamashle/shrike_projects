// Custom Module

// Custom Module

module uart_tx (
    input  wire       clk,
    input  wire       reset,
    input  wire       start,
    input  wire [7:0] data,

    output wire       tx,
    output wire       busy
);

reg [7:0] data_reg;
reg [3:0] bit_count;
reg [8:0] baud_count;
reg       busy_reg;
reg       tx_reg;

assign busy = busy_reg;
assign tx   = tx_reg;

always @(posedge clk) begin

    // 初期状態
    if (reset) begin
        data_reg   <= 8'd0;
        bit_count  <= 4'd0;
        baud_count <= 9'd0;
        busy_reg   <= 1'b0;
        tx_reg     <= 1'b1;   // UARTはIdle=1
    end

    // 新しい1byteの送信開始
    else if (start && !busy_reg) begin
        data_reg   <= data;
        bit_count  <= 4'd0;
        baud_count <= 9'd0;
        busy_reg   <= 1'b1;
        tx_reg     <= 1'b0;   // Start bit
    end

    // UART送信中
    else if (busy_reg) begin

        // 434 clocks = 約1 UART bit
        if (baud_count == 9'd433) begin
            baud_count <= 9'd0;

            // Stop bitを送り終えた
            if (bit_count == 4'd9) begin
                busy_reg <= 1'b0;
                tx_reg   <= 1'b1;   // Idleに戻る
            end

            // 次のbitへ
            else begin
                bit_count <= bit_count + 1'b1;

                // data bit 0〜7
                if (bit_count < 4'd8) begin
   				    tx_reg <= data_reg[bit_count[2:0]];
			   end

                // Stop bit
                else begin
                    tx_reg <= 1'b1;
                end
            end
        end

        else begin
            baud_count <= baud_count + 1'b1;
        end
    end
end

endmodule