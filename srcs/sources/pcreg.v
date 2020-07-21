`timescale 1ns / 1ps

module pcreg (
    input clk,
    input rst,
    input ena,
    input [31:0] data_in,
    output reg [31:0] data_out
);

    always @ (posedge rst or posedge clk) begin
        if (rst) begin
            data_out <= 32'h0040_0000;
        end else if (ena) begin
            data_out <= data_in;
        end
    end

endmodule