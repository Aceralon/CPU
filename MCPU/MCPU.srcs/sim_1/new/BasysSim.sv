`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/22 19:13:29
// Design Name: 
// Module Name: BasysSim
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


module BasysSim(
    );

    logic       clk;
    logic [0:4] btn;
    logic [0:6] seg;
    logic [0:3] posSeg;

    Basys myBasys(
        .mainClk(clk),
        .butnIn(btn),
        .seg(seg),
        .posSeg(posSeg)
    );

    always
    begin
        #1 clk = ~clk;
        #10 btn[4] = ~btn[4];
    end

    initial
    begin
        clk = 0;
        btn[4] = 1;

        #60;
    end

endmodule
