`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/12/20 09:25:41
// Design Name: 
// Module Name: clk_div
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


module clkDiv(
    input  logic        mainClk,
    output logic        clk256,
    output logic [31:0] cnt
    );
    
    logic [31:0] cnt;
    logic        clk;

    initial
    begin
        cnt = 0;
        clk = 0;
    end
    
    always_ff @ (posedge mainClk) 
        if(cnt < 390625)
            cnt <= cnt + 1;
        else
        begin
            clk256 <= ~clk256;
            cnt <= 0;
        end
    
endmodule
