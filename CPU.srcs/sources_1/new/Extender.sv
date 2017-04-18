`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 18:21:24
// Design Name: 
// Module Name: Extender
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


module Extender(
    input  logic        ExtSel,
    input  logic [15:0] in,
    output logic [31:0] out
    );

    always_comb
    begin
        casex({ExtSel, in[15]})
            2'b0x : out = {16 {1'b0}, in};
            2'b10 : out = {16 {1'b0}, in};
            2'b11 : out = {16 {1'b1}, in};
        endcase
    end

endmodule
