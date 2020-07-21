`timescale 1ns / 1ps

module controller(
    input clk,
    input z,
    input [31:0] i,
    output PC_CLK,
    output IM_R,
    output M1,
    output M2,
    output M3,
    output M4,
    output M5,
    output M6,
    output M7,
    output M9,
    output M10,
    output [3:0] ALUC,
    output RF_W,
    output RF_CLK,
    output DM_w,
    output DM_r,
    output DM_cs,
    output C_EXT16
);

    assign PC_CLK  = clk;
    assign IM_R    = 1;
    assign M1      = ~(i[16] | i[29] | i[30]);
    assign M2      = (i[24] & z) | (i[25] & ~z);
    assign M3      = i[16];
    assign M4      = i[13] | i[14] | i[15];
    assign M5      = i[17] | i[18] | i[19] | i[20] | i[21] | i[22] | i[23] | i[26] | i[27] | i[28];
    assign M6      = i[30];
    assign M7      = i[22];
    assign M9      = ~(i[10] | i[11] | i[12] | i[13] | i[14] | i[15]);
    assign M10     = i[17] | i[18] | i[19] | i[20] | i[21] | i[22] | i[23] | i[26] | i[27] | i[28];
    assign ALUC[0] = i[2] | i[3] | i[5] | i[7] | i[8] | i[11] | i[14] | i[20] | i[24] | i[25] | i[26];
    assign ALUC[1] = i[0] | i[2] | i[6] | i[7] | i[8] | i[9] | i[10] | i[13] | i[17] | i[21] | i[22] | i[23] | i[24] | i[25] | i[26] | i[27];
    assign ALUC[2] = i[4] | i[5] | i[6] | i[7] | i[10] | i[11] | i[12] | i[13] | i[14] | i[15] | i[19] | i[20] | i[21];
    assign ALUC[3] = i[8] | i[9] | i[10] | i[11] | i[12] | i[13] | i[14] | i[15] | i[26] | i[27] | i[28];
    assign RF_W    = ~(i[16] | i[23] | i[24] | i[25] | i[29]);
    assign RF_CLK  = ~clk;
    assign DM_w    = i[23];
    assign DM_r    = i[22];
    assign DM_cs   = i[22] | i[23];
    assign C_EXT16 = ~(i[19] | i[20] | i[21]);

endmodule

