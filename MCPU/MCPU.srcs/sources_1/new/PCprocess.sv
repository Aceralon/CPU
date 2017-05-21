`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/20 14:18:27
// Design Name: 
// Module Name: PCprocess
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


module PCprocess(
    input  logic [25:0] prePC,
    input  logic [3:0]  PC4,
    output logic [31:0] outPC
    );

    assign outPC = {PC4, prePC, 2'b00};

endmodule
