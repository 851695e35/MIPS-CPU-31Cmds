`timescale 1ns / 1ps

module ext18 (
    input [15:0] i,
    output [31:0] o
);

    assign o = {{(32 - 18){i[15]}}, i, 2'b00};
    
endmodule