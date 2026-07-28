module eth_frame_parser (
    input  logic       clk,
    input  logic       rst_n,

    input  logic [7:0] byte_data,
    input  logic       byte_valid,
    input  logic       frame_start,
    input  logic       frame_end,

    output logic [7:0] payload_data,
    output logic       payload_valid,
    output logic       payload_end,
    output logic       frame_error
);

    typedef enum logic [1:0] {
        WAIT_FRAME,
        PREAMBLE,
        PAYLOAD
    } state_t;

    state_t state;
    logic [2:0] preamble_count;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state          <= WAIT_FRAME;
            preamble_count <= '0;
            payload_data   <= '0;
            payload_valid  <= 1'b0;
            payload_end    <= 1'b0;
            frame_error    <= 1'b0;
        end else begin
            payload_valid <= 1'b0;
            payload_end   <= 1'b0;
            frame_error   <= 1'b0;

            if (frame_start) begin
                state          <= PREAMBLE;
                preamble_count <= '0;
            end

            if (frame_end) begin
                if (state == PAYLOAD)
                    payload_end <= 1'b1;
                else
                    frame_error <= 1'b1;

                state <= WAIT_FRAME;
            end

            else if (byte_valid && state == PREAMBLE) begin
                if (preamble_count < 7) begin
                    if (byte_data == 8'h55)
                        preamble_count <= preamble_count + 1'b1;
                    else begin
                        frame_error <= 1'b1;
                        state <= WAIT_FRAME;
                    end
                end

                else begin
                    if (byte_data == 8'hD5)
                        state <= PAYLOAD;
                    else begin
                        frame_error <= 1'b1;
                        state <= WAIT_FRAME;
                    end
                end
            end

            else if (byte_valid && state == PAYLOAD) begin
                payload_data  <= byte_data;
                payload_valid <= 1'b1;
            end
        end
    end

endmodule

