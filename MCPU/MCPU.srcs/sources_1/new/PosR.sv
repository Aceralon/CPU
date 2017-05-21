`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/20 14:15:02
// Design Name: 
// Module Name: PosR
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


module PosR(
    input  logic        clk,
    input  logic [31:0] in,
    output logic [31:0] out
    );

    always_ff @ (posedge clk)
        out <= in;

endmodule
