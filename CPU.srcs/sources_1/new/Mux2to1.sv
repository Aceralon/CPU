`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 18:21:24
// Design Name: 
// Module Name: 2Mux1
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


module Mux2to1(
    input  logic        SelSig,
    input  logic [31:0] zero,
    input  logic [31:0] one,
    input  logic [31:0] out
    );

    always_comb
    begin
        case(SelSig)
            1'b0 : out = zero;
            1'b1 : out = one;
        endcase
    end

endmodule
