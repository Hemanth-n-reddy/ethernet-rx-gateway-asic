`timescale 1ns/1ps

module tb_eth_frame_parser;

    logic clk;
    logic rst_n;

    logic [7:0] byte_data;
    logic       byte_valid;
    logic       frame_start;
    logic       frame_end;

    logic [7:0] payload_data;
    logic       payload_valid;
    logic       payload_end;
    logic       frame_error;

    // DUT
    eth_frame_parser dut (
        .clk(clk),
        .rst_n(rst_n),
        .byte_data(byte_data),
        .byte_valid(byte_valid),
        .frame_start(frame_start),
        .frame_end(frame_end),
        .payload_data(payload_data),
        .payload_valid(payload_valid),
        .payload_end(payload_end),
        .frame_error(frame_error)
    );

    // Clock Generation (50 MHz)
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Generate VCD
    initial begin
        $dumpfile("simulations/frame_parser.vcd");
        $dumpvars(0, tb_eth_frame_parser);
    end

    // Task to send one byte
    task send_byte(input [7:0] data);
    begin
        @(posedge clk);
        byte_data  <= data;
        byte_valid <= 1'b1;

        @(posedge clk);
        byte_valid <= 1'b0;
    end
    endtask

    // Test Sequence
    initial begin

        rst_n       = 0;
        byte_data   = 8'h00;
        byte_valid  = 0;
        frame_start = 0;
        frame_end   = 0;

        repeat(2) @(posedge clk);

        rst_n = 1;

        // Start Frame
        @(posedge clk);
        frame_start <= 1;

        @(posedge clk);
        frame_start <= 0;

        // Ethernet Preamble
        repeat(7)
            send_byte(8'h55);

        // Start Frame Delimiter
        send_byte(8'hD5);

        // Payload
        send_byte(8'hAA);
        send_byte(8'hBB);
        send_byte(8'hCC);

        // End Frame
        @(posedge clk);
        frame_end <= 1;

        @(posedge clk);
        frame_end <= 0;

        repeat(5) @(posedge clk);

        $finish;

    end

    // Display Signals
    initial begin
        $display("Time\tState");
        $monitor("%0t\tByte=%h Valid=%b Payload=%h PValid=%b End=%b Error=%b",
            $time,
            byte_data,
            byte_valid,
            payload_data,
            payload_valid,
            payload_end,
            frame_error);
    end

endmodule
