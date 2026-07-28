module rmii_rx (
    input  logic       clk,
    input  logic       rst_n,

    // From external Ethernet PHY (RMII)
    input  logic [1:0] rx_d,
    input  logic       rx_dv,

    // Byte stream into packet buffer / MAC logic
    output logic [7:0] byte_data,
    output logic       byte_valid,
    output logic       frame_start,
    output logic       frame_end
);

    logic [7:0] shift_reg;
    logic [1:0] dibit_count;
    logic       rx_dv_d;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg   <= '0;
            dibit_count <= '0;
            byte_data   <= '0;
            byte_valid  <= 1'b0;
            frame_start <= 1'b0;
            frame_end   <= 1'b0;
            rx_dv_d     <= 1'b0;
        end else begin
            byte_valid  <= 1'b0;
            frame_start <= 1'b0;
            frame_end   <= 1'b0;
            rx_dv_d     <= rx_dv;

            // First active cycle of an incoming frame
            if (rx_dv && !rx_dv_d)
                frame_start <= 1'b1;

            // First inactive cycle after an incoming frame
            if (!rx_dv && rx_dv_d)
                frame_end <= 1'b1;

            if (rx_dv) begin
                // RMII sends least-significant dibit first
                shift_reg <= {rx_d, shift_reg[7:2]};

                if (dibit_count == 2'd3) begin
                    byte_data   <= {rx_d, shift_reg[7:2]};
                    byte_valid  <= 1'b1;
                    dibit_count <= 2'd0;
                end else begin
                    dibit_count <= dibit_count + 1'b1;
                end
            end else begin
                dibit_count <= 2'd0;
            end
        end
    end
endmodule

