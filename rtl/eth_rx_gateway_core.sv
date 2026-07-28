module eth_rx_gateway_core (
    input  logic       clk,
    input  logic       rst_n,

    // RMII interface from external Ethernet PHY
    input  logic [1:0] rmii_rx_d,
    input  logic       rmii_rx_dv,

    // Consumer interface: CPU or future CAN-FD gateway logic
    input  logic       rd_en,
    output logic [7:0] rd_data,
    output logic       fifo_empty,
    input  logic       packet_release,

    // Status
    output logic       packet_ready,
    output logic       frame_error,
    output logic       buffer_overflow
);

    logic [7:0] post_sfd_data;
    logic       post_sfd_valid;
    logic       post_sfd_end;

    eth_rx_path u_eth_rx_path (
        .clk           (clk),
        .rst_n         (rst_n),
        .rmii_rx_d     (rmii_rx_d),
        .rmii_rx_dv    (rmii_rx_dv),
        .payload_data  (post_sfd_data),
        .payload_valid (post_sfd_valid),
        .payload_end   (post_sfd_end),
        .frame_error   (frame_error)
    );

    eth_packet_buffer #(
        .FIFO_DEPTH(16)
    ) u_packet_buffer (
        .clk             (clk),
        .rst_n           (rst_n),
        .payload_data    (post_sfd_data),
        .payload_valid   (post_sfd_valid),
        .payload_end     (post_sfd_end),
        .rd_en           (rd_en),
        .rd_data         (rd_data),
        .empty           (fifo_empty),
        .packet_release  (packet_release),
        .packet_ready    (packet_ready),
        .buffer_overflow (buffer_overflow)
    );

endmodule
