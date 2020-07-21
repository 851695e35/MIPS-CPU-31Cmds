`timescale 1ns / 1ps

module DMEM(
    input clk,
    input ena,
    input wsignal,
    input rsignal,
    input [10:0] addr,
    input [31:0] wdata,
    output [31:0] rdata
);

    reg [31:0] data[0:31];
    
    always @ (posedge clk) begin
        if (wsignal && ena) begin
            data[addr] <= wdata;
        end
    end
    
    assign rdata = (rsignal && ena) ? data[addr] : 32'bz;
    
endmodule