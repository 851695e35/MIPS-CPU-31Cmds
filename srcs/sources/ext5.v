`timescale 1ns / 1ps

module ext5 #(parameter WIDTH = 5)(
    input [WIDTH-1:0] i,
    output [31:0] o
);

    assign o = {{(32-WIDTH){1'b0}}, i};
    
endmodule