`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/20 13:58:56
// Design Name: 
// Module Name: IR
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


module IR(
    input  logic        clk,
    input  logic [31:0] in,
    input  logic        IRWre,
    output logic [31:0] out
    );

    always_ff @ (posedge clk)
    begin
        if(IRWre)
            out <= in;
        else
            out <= out;
    end

endmodule
