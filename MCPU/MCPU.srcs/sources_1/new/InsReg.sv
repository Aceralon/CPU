`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 18:21:24
// Design Name: 
// Module Name: InsReg
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


module InsReg(
    input  logic [31:0] PC,
    input  logic        InsMemRW,
    output logic [31:0] InsOut
    );

    logic [7:0] InsMem [0:255];

    initial
    begin
        $readmemh("Inst.mem",InsMem);
    end

    always_comb
        case(InsMemRW)
            1'b1 : InsOut = {InsMem[PC], InsMem[PC+1], InsMem[PC+2], InsMem[PC+3]};
            1'b0 : InsOut = 32'bz;
        endcase

endmodule
