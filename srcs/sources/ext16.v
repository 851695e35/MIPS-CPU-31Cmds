`timescale 1ns / 1ps

module ext16 #(parameter WIDTH = 16)(
    input [WIDTH-1:0] i,
    input sext,  // 1 stands for signed
    output [31:0] o
);
    assign o = sext ? {{(32-WIDTH){i[WIDTH-1]}}, i} : {{(32-WIDTH){1'b0}}, i};
endmodule