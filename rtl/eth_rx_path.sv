module eth_rx_path (
    input  logic       clk,
    input  logic       rst_n,

    // RMII interface from Ethernet PHY
    input  logic [1:0] rmii_rx_d,
    input  logic       rmii_rx_dv,

    // Valid Ethernet payload stream
    output logic [7:0] payload_data,
    output logic       payload_valid,
    output logic       payload_end,
    output logic       frame_error
);

    logic [7:0] rx_byte_data;
    logic       rx_byte_valid;
    logic       rx_frame_start;
    logic       rx_frame_end;

    rmii_rx u_rmii_rx (
        .clk         (clk),
        .rst_n       (rst_n),
        .rx_d        (rmii_rx_d),
        .rx_dv       (rmii_rx_dv),
        .byte_data   (rx_byte_data),
        .byte_valid  (rx_byte_valid),
        .frame_start (rx_frame_start),
        .frame_end   (rx_frame_end)
    );

    eth_frame_parser u_frame_parser (
        .clk           (clk),
        .rst_n         (rst_n),
        .byte_data     (rx_byte_data),
        .byte_valid    (rx_byte_valid),
        .frame_start   (rx_frame_start),
        .frame_end     (rx_frame_end),
        .payload_data  (payload_data),
        .payload_valid (payload_valid),
        .payload_end   (payload_end),
        .frame_error   (frame_error)
    );

endmodule

