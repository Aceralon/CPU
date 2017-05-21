`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/20 13:53:19
// Design Name: 
// Module Name: Mux4to1
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


module Mux4to1(
    input   logic [1:0]  SelSig,
    input   logic [31:0] zero,
    input   logic [31:0] one,
    input   logic [31:0] two,
    input   logic [31:0] three,
    output  logic [31:0] out
    );

    always_comb
    begin
        case(SelSig)
            2'b00 : out = zero;
            2'b01 : out = one;
            2'b10 : out = two;
            2'b11 : out = three;
        endcase
    end

endmodule
