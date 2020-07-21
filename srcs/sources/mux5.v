`timescale 1ns / 1ps

module mux5(
    input [4:0] a,
    input [4:0] b,
    input [1:0] ctrl,
    output [4:0] out
);
    reg [4:0] zr;
    always @ (*) begin
        case (ctrl)
            2'b00 : zr   <= a;
            2'b01 : zr   <= b;
            2'b10 : zr   <= 5'b11111;
            2'b11 : zr   <= 5'b11111;
            default : zr <= 5'bz;
        endcase
    end
    assign out = zr;
endmodule