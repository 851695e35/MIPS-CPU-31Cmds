`timescale 1ns / 1ps

module regfile(
    input clk,
    input ena,
    input rst,
    input we,
    input [4:0] Rsc,
    input [4:0] Rtc,
    output [31:0] Rs,
    output [31:0] Rt,
    input [4:0] Rdc,
    input [31:0] Rd
);

    reg [31:0] registers[0:31];
    
    always @ (posedge clk or posedge rst) begin
        if (rst && ena) begin
            registers[0]  <= 32'b0;
            registers[1]  <= 32'b0;
            registers[2]  <= 32'b0;
            registers[3]  <= 32'b0;
            registers[4]  <= 32'b0;
            registers[5]  <= 32'b0;
            registers[6]  <= 32'b0;
            registers[7]  <= 32'b0;
            registers[8]  <= 32'b0;
            registers[9]  <= 32'b0;
            registers[10] <= 32'b0;
            registers[11] <= 32'b0;
            registers[12] <= 32'b0;
            registers[13] <= 32'b0;
            registers[14] <= 32'b0;
            registers[15] <= 32'b0;
            registers[16] <= 32'b0;
            registers[17] <= 32'b0;
            registers[18] <= 32'b0;
            registers[19] <= 32'b0;
            registers[20] <= 32'b0;
            registers[21] <= 32'b0;
            registers[22] <= 32'b0;
            registers[23] <= 32'b0;
            registers[24] <= 32'b0;
            registers[25] <= 32'b0;
            registers[26] <= 32'b0;
            registers[27] <= 32'b0;
            registers[28] <= 32'b0;
            registers[29] <= 32'b0;
            registers[30] <= 32'b0;
            registers[31] <= 32'b0;
        end else begin
            if (we && ena && Rdc != 5'b0) begin
                registers[Rdc] <= Rd;
            end
        end
    end
        
    assign Rs = ena ? registers[Rsc] : 32'bz;
    assign Rt = ena ? registers[Rtc] : 32'bz;
    
endmodule
