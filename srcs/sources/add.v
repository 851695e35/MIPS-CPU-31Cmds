`timescale 1ns / 1ps

module add(
    input [31:0] a,
    input [31:0] b,
    output [31:0] r,
    output overflow
);

    assign r = a + b;
    assign overflow = (a[31]==b[31] && a[31]!=r[31]);
    
endmodule