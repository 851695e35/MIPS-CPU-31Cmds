`timescale 1ns / 1ps

module sccomp_dataflow(
    input clk,
    input rst,
    output [31:0] inst,
    output wire [31:0] pc,
    output wire [10:0] dm_addr,
    output wire [10:0] im_addr
);

    wire dw, dr, dena;
    wire [31:0] w_data, r_data;
    wire [31:0] instr, res;
    // wire [10:0] DMEM_addr;
    // wire [31:0] IMEM_addr; 
    
    assign inst = instr;   
    assign im_addr = (pc  - 32'h0040_0000) / 4;
    assign dm_addr = (res - 32'h1001_0000) / 4; 

    IMEM imem(
        .addr(im_addr),
        .instr(instr)
    );
    
    DMEM dmem(
        .clk(clk), .ena(dena),
        .wsignal(dw), .rsignal(dr),
        .addr(dm_addr[10:0]), .wdata(w_data), .rdata(r_data)
    );
    
    CPU31 cpu(
        .clk(clk), .reset(rst),
        .inst(instr), .rdata(r_data),
        .DM_CS(dena), .DM_R(dr), .DM_W(dw), .DM_addr(res), .DM_wdata(w_data),
        .pc(pc)
    );
    
endmodule