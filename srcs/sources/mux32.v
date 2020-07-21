`timescale 1ns / 1ps

module mux32 (
    input [31:0] a,
    input [31:0] b,
    input ctrl,
    output [31:0] out
);
    
    assign out = ctrl ? b : a;
    
endmodule