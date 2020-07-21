`timescale 1ns / 1ps

module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] aluc,
    output [31:0] r,
    output zero,
    output carry,
    output negative,
    output overflow
);
        
    parameter Addu = 4'b0000;    
    parameter Add  = 4'b0010;    
    parameter Subu = 4'b0001;    
    parameter Sub  = 4'b0011;    
    parameter And  = 4'b0100;    
    parameter Or   = 4'b0101;    
    parameter Xor  = 4'b0110;    
    parameter Nor  = 4'b0111;    
    parameter Lui1 = 4'b1000;    
    parameter Lui2 = 4'b1001;    
    parameter Slt  = 4'b1011;    
    parameter Sltu = 4'b1010;    
    parameter Sra  = 4'b1100;    
    parameter Sll  = 4'b1110;    
    parameter Srl  = 4'b1101;    
    parameter Slr  = 4'b1111;    
    
    parameter bits = 31;
    parameter ENABLE = 1,DISABLE = 0;
    
    reg signed [32:0] result;
    reg [33:0] sresult;
    wire signed [31:0] sa = a, sb = b;
  
    always @ (*) begin
        case(aluc)
            Addu: begin
                result  <= a + b;
                sresult <= {sa[31], sa} + {sb[31], sb};
            end
            Subu: begin
                result  <= a - b;
                sresult <= {sa[31], sa} - {sb[31], sb};
            end
            Add: begin
                result <= sa + sb;
            end
            Sub: begin
                result <= sa - sb;
            end
            Sra: begin
                if(a == 0) begin
                    {result[31:0], result[32]} <= {b, 1'b0};
                end else begin
                    {result[31:0], result[32]} <= sb >>> (a-1);
                end
            end
            Srl: begin
                if(a == 0) begin
                    {result[31:0], result[32]} <= {b, 1'b0};
                end else begin
                    {result[31:0], result[32]} <= b >> (a-1);
                end
            end
            Sll, Slr: begin
                result <= b << a;
            end
            And: begin
                result <= a & b;
            end
            Or: begin
                result <= a | b;
            end
            Xor: begin
                result <= a ^ b;
            end
            Nor: begin
                result <= ~(a | b);
            end
            Sltu: begin
                result <= a < b ? 1 : 0;
            end
            Slt: begin
                result <= sa < sb ? 1 : 0;
            end
            Lui1, Lui2: begin
                result <= {b[15:0], 16'b0};
            end
            default:
                result <= a + b;
        endcase
    end
    
    assign r = result[31:0];
    assign carry = (aluc==Addu|aluc==Subu|aluc==Sltu|aluc==Sra|aluc==Srl|aluc==Sll) ? result[32] : 1'bz; 
    assign zero = (r==32'b0);
    assign negative = result[31];
    assign overflow = (aluc==Add|aluc==Sub) ? (sresult[32]^sresult[33]) : 1'bz;
    
endmodule