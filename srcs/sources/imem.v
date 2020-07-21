`timescale 1ns / 1ps

module IMEM(
    input [10:0] addr,
    output [31:0] instr
);
    
    cpu31_instr ip_catalog(
        .a(addr),
        .spo(instr)
    );
    
endmodule