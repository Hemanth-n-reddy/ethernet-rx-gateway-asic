`timescale 1ns/1ps

module tb_sync_fifo;

logic clk;
logic rst_n;
logic wr_en;
logic rd_en;
logic [7:0] din;
logic [7:0] dout;
logic full;
logic empty;
logic [4:0] count;

sync_fifo #(
    .DATA_WIDTH(8),
    .DEPTH(16)
) dut (
    .clk(clk),
    .rst_n(rst_n),
    .wr_en(wr_en),
    .din(din),
    .rd_en(rd_en),
    .dout(dout),
    .full(full),
    .empty(empty),
    .count(count)
);

initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

initial begin
    $dumpfile("simulations/sync_fifo.vcd");
    $dumpvars(0,tb_sync_fifo);
end

initial begin

    rst_n = 0;
    wr_en = 0;
    rd_en = 0;
    din   = 0;

    #25;
    rst_n = 1;

    // Write three bytes
    repeat(3) begin
        @(posedge clk);
        wr_en = 1;
        din = din + 8'h11;
    end

    @(posedge clk);
    wr_en = 0;

    // Read three bytes
    repeat(3) begin
        @(posedge clk);
        rd_en = 1;
    end

    @(posedge clk);
    rd_en = 0;

    #50;

    $finish;

end

initial begin
    $monitor("T=%0t DIN=%h DOUT=%h COUNT=%0d FULL=%b EMPTY=%b",
              $time,din,dout,count,full,empty);
end

endmodule
