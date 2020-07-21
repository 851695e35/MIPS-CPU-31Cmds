`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/22 18:39:49
// Design Name: 
// Module Name: cpu_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module cpu_tb;

    reg clk, rst;
    wire [31:0] inst, pc;
    reg [31:0] cnt;
    wire [10:0] dma, ima;
    integer file_open;
    initial begin
        clk = 1'b0;
        rst = 1'b1;
        #10 rst = 1'b0;
        cnt = 0;
    end

    always begin
        #20 clk = ~clk;
    end

    always @ (posedge clk) begin
        cnt <= cnt + 1'b1;
        if (cnt == 8'h99 - 1) begin
            file_open = $fopen("output.txt", "w");
                $fdisplay(file_open, "$zero = %h", sc.cpu.cpu_rf.registers[0]);
                $fdisplay(file_open, "$at   = %h", sc.cpu.cpu_rf.registers[1]);
                $fdisplay(file_open, "$v0   = %h", sc.cpu.cpu_rf.registers[2]);
                $fdisplay(file_open, "$v1   = %h", sc.cpu.cpu_rf.registers[3]);
                $fdisplay(file_open, "$a0   = %h", sc.cpu.cpu_rf.registers[4]);
                $fdisplay(file_open, "$a1   = %h", sc.cpu.cpu_rf.registers[5]);
                $fdisplay(file_open, "$a2   = %h", sc.cpu.cpu_rf.registers[6]);
                $fdisplay(file_open, "$a3   = %h", sc.cpu.cpu_rf.registers[7]);
                $fdisplay(file_open, "$t0   = %h", sc.cpu.cpu_rf.registers[8]);
                $fdisplay(file_open, "$t1   = %h", sc.cpu.cpu_rf.registers[9]);
                $fdisplay(file_open, "$t2   = %h", sc.cpu.cpu_rf.registers[10]);
                $fdisplay(file_open, "$t3   = %h", sc.cpu.cpu_rf.registers[11]);
                $fdisplay(file_open, "$t4   = %h", sc.cpu.cpu_rf.registers[12]);
                $fdisplay(file_open, "$t5   = %h", sc.cpu.cpu_rf.registers[13]);
                $fdisplay(file_open, "$t6   = %h", sc.cpu.cpu_rf.registers[14]);
                $fdisplay(file_open, "$t7   = %h", sc.cpu.cpu_rf.registers[15]);
                $fdisplay(file_open, "$s0   = %h", sc.cpu.cpu_rf.registers[16]);
                $fdisplay(file_open, "$s1   = %h", sc.cpu.cpu_rf.registers[17]);
                $fdisplay(file_open, "$s2   = %h", sc.cpu.cpu_rf.registers[18]);
                $fdisplay(file_open, "$s3   = %h", sc.cpu.cpu_rf.registers[19]);
                $fdisplay(file_open, "$s4   = %h", sc.cpu.cpu_rf.registers[20]);
                $fdisplay(file_open, "$s5   = %h", sc.cpu.cpu_rf.registers[21]);
                $fdisplay(file_open, "$s6   = %h", sc.cpu.cpu_rf.registers[22]);
                $fdisplay(file_open, "$s7   = %h", sc.cpu.cpu_rf.registers[23]);
                $fdisplay(file_open, "$t8   = %h", sc.cpu.cpu_rf.registers[24]);
                $fdisplay(file_open, "$t9   = %h", sc.cpu.cpu_rf.registers[25]);
                $fdisplay(file_open, "$k0   = %h", sc.cpu.cpu_rf.registers[26]);
                $fdisplay(file_open, "$k1   = %h", sc.cpu.cpu_rf.registers[27]);
                $fdisplay(file_open, "$gp   = %h", sc.cpu.cpu_rf.registers[28]);
                $fdisplay(file_open, "$sp   = %h", sc.cpu.cpu_rf.registers[29]);
                $fdisplay(file_open, "$fp   = %h", sc.cpu.cpu_rf.registers[30]);
                $fdisplay(file_open, "$ra   = %h", sc.cpu.cpu_rf.registers[31]);
            $fclose(file_open);
        end
    end
    sccomp_dataflow sc(
        .clk(clk),
        .rst(rst),
        .inst(inst),
        .pc(pc),
        .dm_addr(dma),
        .im_addr(ima)
    );

endmodule
