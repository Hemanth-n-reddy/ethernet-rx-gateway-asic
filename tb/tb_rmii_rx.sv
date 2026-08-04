`timescale 1ns/1ps

module tb_rmii_rx;

    logic clk;
    logic rst_n;
    logic [1:0] rx_d;
    logic rx_dv;

    logic [7:0] byte_data;
    logic byte_valid;
    logic frame_start;
    logic frame_end;

    // DUT (Device Under Test)
    rmii_rx dut (
        .clk(clk),
        .rst_n(rst_n),
        .rx_d(rx_d),
        .rx_dv(rx_dv),
        .byte_data(byte_data),
        .byte_valid(byte_valid),
        .frame_start(frame_start),
        .frame_end(frame_end)
    );

    // 50 MHz clock (20 ns period)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Test sequence
    initial begin
 $dumpfile("simulations/rmii_rx.vcd");
    $dumpvars(0, tb_rmii_rx);
        // Initialize
        rst_n = 0;
        rx_d = 2'b00;
        rx_dv = 0;

        #25;
        rst_n = 1;

        // Start Ethernet frame
        rx_dv = 1;

        // Send one byte: 10101100
        rx_d = 2'b00;
        #20;

        rx_d = 2'b11;
        #20;

        rx_d = 2'b10;
        #20;

        rx_d = 2'b10;
        #20;

        // End frame
        rx_dv = 0;
        #40;

        $finish;
    end

    // Display outputs
    initial begin

        $display("Time\tDV\tRXD\tByte\tValid\tStart\tEnd");
        $monitor("%0t\t%b\t%02b\t%02h\t%b\t%b\t%b",
                 $time,
                 rx_dv,
                 rx_d,
                 byte_data,
                 byte_valid,
                 frame_start,
                 frame_end);
    end

endmodule

