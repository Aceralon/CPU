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
    input  logic [15:0] in,
    output logic [31:0] out
    );

    always_comb
    begin
        case(in[15])
            1b'0 : out = {16{1'b0},in};
            1'b1 : out = {16{1'b1},in};
        endcase
    end

endmodule
