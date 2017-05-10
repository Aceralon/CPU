`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 18:21:24
// Design Name: 
// Module Name: ALU
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


module ALU(
    input  logic [31:0] ALUA,
    input  logic [31:0] ALUB,
    input  logic [2:0]  ALUOp,
    output logic [31:0] result,
    output logic        zero 
    );
    
    always_comb
    begin
        case(ALUOp)
            3'b000 : result = ALUA + ALUB;
            3'b001 : result = ALUA - ALUB;
            3'b010 : result = ALUB << ALUA;
            3'b011 : result = ALUA | ALUB;
            3'b100 : result = ALUA & ALUB;
            3'b101 : result = ~ALUA & ALUB;
            3'b110 : result = ALUA ^ ALUB;
            3'b111 : result = ALUA ~^ ALUB;
        endcase
        if(result == 0)
            zero = 1;
        else
            zero = 0;
    end

endmodule
