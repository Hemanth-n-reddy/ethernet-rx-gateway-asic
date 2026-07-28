module eth_packet_buffer #(
    parameter int FIFO_DEPTH = 16
) (
    input  logic       clk,
    input  logic       rst_n,

    input  logic [7:0] payload_data,
    input  logic       payload_valid,
    input  logic       payload_end,

    input  logic       rd_en,
    output logic [7:0] rd_data,
    output logic       empty,

    input  logic       packet_release,
    output logic       packet_ready,
    output logic       buffer_overflow
);

    localparam int COUNT_WIDTH = $clog2(FIFO_DEPTH + 1);

    logic fifo_full;
    logic [COUNT_WIDTH-1:0] fifo_count;
    logic fifo_wr_en;

    assign fifo_wr_en = payload_valid && !fifo_full && !packet_ready;

    sync_fifo #(
        .DATA_WIDTH(8),
        .DEPTH(FIFO_DEPTH)
    ) u_fifo (
        .clk   (clk),
        .rst_n (rst_n),
        .wr_en (fifo_wr_en),
        .din   (payload_data),
        .rd_en (rd_en),
        .dout  (rd_data),
        .full  (fifo_full),
        .empty (empty),
        .count (fifo_count)
    );

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            packet_ready    <= 1'b0;
            buffer_overflow <= 1'b0;
        end else begin
            if (packet_release) begin
                packet_ready    <= 1'b0;
                buffer_overflow <= 1'b0;
            end

            if (payload_valid && fifo_full)
                buffer_overflow <= 1'b1;

            if (payload_end && !buffer_overflow)
                packet_ready <= 1'b1;
        end
    end

endmodule
