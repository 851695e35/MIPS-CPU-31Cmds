`timescale 1ns / 1ps

module CPU31 (
    input         clk,
    input         reset,
    input  [31:0] inst,
    input  [31:0] rdata,
    output [31:0] pc,
    output [31:0] DM_addr,
    output [31:0] DM_wdata,
    output        IM_R,
    output        DM_CS,
    output        DM_R,
    output        DM_W
);
    
    wire PC_CLK;                     
    wire PC_ENA;                     
    wire M1, M2, M3, M4, M5, M6, M7, M8, M9, M10, M11;                        
    wire [3:0] ALUC;                 
    wire RF_W;                       
    wire RF_CLK;                     
    wire C_EXT16;                    
    
    wire zero;                       
    wire carry;                      
    wire negative;                   
    wire overflow;                   
    wire add_overflow;               
    
    wire [31:0] ins_code;                 
    
    wire [31:0] D_ALU;               
    wire [31:0] D_PC;                
    wire [31:0] D_RF;                
    wire [31:0] D_Rs;                
    wire [31:0] D_Rt;                
    wire [31:0] D_IM;                
    wire [31:0] D_DM;                
    wire [31:0] D_Mux1;              
    wire [31:0] D_Mux2;              
    wire [31:0] D_Mux3;              
    wire [4:0]  D_Mux4;              
    wire [4:0]  D_Mux5;              
    wire [31:0] D_Mux6;              
    wire [31:0] D_Mux7;              
    wire [31:0] D_Mux8;              
    wire [31:0] D_Mux9;              
    wire [31:0] D_Mux10;             
    wire        D_Mux11;             
                                      
    wire [31:0] D_EXT1;              
    wire [31:0] D_EXT5;              
    wire [31:0] D_EXT16;             
    wire [31:0] D_EXT18;             
    wire [31:0] D_ADD;               
    wire [31:0] D_ADD8;              
    wire [31:0] D_NPC;               
    wire [31:0] D_ii;
                   
    assign PC_ENA = 1;
    
    assign pc = D_PC;
    assign DM_addr = D_ALU;
    assign DM_wdata = D_Rt;
    
    instr_decode cpu_inst (
        .instr_raw(inst), 
        .instr_code(ins_code)
    );
    
    controller cpu_control (
        .clk(clk), .z(zero), 
        .i(ins_code), .PC_CLK(PC_CLK), 
        .IM_R(IM_R), .M1(M1), .M2(M2), .M3(M3), .M4(M4), .M5(M5), .M6(M6), .M7(M7), .M9(M9), .M10(M10), 
        .ALUC(ALUC), .RF_W(RF_W), .RF_CLK(RF_CLK), .DM_w(DM_W), .DM_r(DM_R), .DM_cs(DM_CS), .C_EXT16(C_EXT16)
    );
    
    pcreg cpu_pc (
        .clk(PC_CLK), .rst(reset), .ena(PC_ENA),
        .data_in(D_Mux1), .data_out(D_PC)
    );
    
    alu cpu_alu (
        .a(D_Mux9), .b(D_Mux10),
        .aluc(ALUC), .r(D_ALU),
        .zero(zero), .carry(carry), .negative(negative), .overflow(overflow)
    );
    
    mux32 cpu_mux1 (
        .a(D_Mux3), .b(D_Mux2),
        .ctrl(M1), .out(D_Mux1)
    );
    
    mux32 cpu_mux2 (
        .a(D_NPC), .b(D_ADD),
        .ctrl(M2), .out(D_Mux2)
    );
    
    mux32 cpu_mux3 (
        .a(D_ii), .b(D_Rs),
        .ctrl(M3), .out(D_Mux3)
    );
    
    mux5 cpu_mux4 (
        .a(inst[10:6]), .b(D_Rs[4:0]),
        .ctrl({ins_code[30], M4}), .out(D_Mux4)
    );
    
    mux5 cpu_mux5 (
        .a(inst[15:11]), .b(inst[20:16]),
        .ctrl({ins_code[30], M5}), .out(D_Mux5)
    );
    
    mux32 cpu_mux6 (
        .a(D_Mux7), .b(D_ADD8),
        .ctrl(M6), .out(D_Mux6)
    );
    
    mux32 cpu_mux7 (
        .a(D_ALU), .b(rdata), 
        .ctrl(M7), .out(D_Mux7)
    );
    
    mux32 cpu_mux9 (
        .a(D_EXT5), .b(D_Rs), 
        .ctrl(M9), .out(D_Mux9)
    );
    
    mux32 cpu_mux10 (
        .a(D_Rt), .b(D_EXT16),
        .ctrl(M10), .out(D_Mux10)
    );
    
    ext5 cpu_ext5 (
        .i(D_Mux4),
        .o(D_EXT5)
    );
    
    ext16 cpu_ext16 (
        .i(inst[15:0]), 
        .sext(C_EXT16), 
        .o(D_EXT16)
    );
    
    ext18 cpu_ext18 (
        .i(inst[15:0]), 
        .o(D_EXT18)
    );
    
    add cpu_add (
        .a(D_EXT18), .b(D_NPC),
        .r(D_ADD), .overflow(add_overflow)
    );
    
    add8 cpu_add8 (
        .a(D_PC), .r(D_ADD8)
    );
    npc cpu_npc  (
        .a(D_PC), .r(D_NPC)
    );
    
    II cpu_ii (
        .a(D_PC[31:28]), .b(inst[25:0]),
        .r(D_ii)
    );
    
    regfile cpu_rf(
        .clk(RF_CLK), .ena(1'b1), .rst(reset), .we(RF_W),
        .Rsc(inst[25:21]), .Rtc(inst[20:16]), .Rdc(D_Mux5),
        .Rs(D_Rs), .Rt(D_Rt), .Rd(D_Mux6)
    );
    
endmodule