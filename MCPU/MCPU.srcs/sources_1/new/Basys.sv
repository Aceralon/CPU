`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/22 15:17:22
// Design Name: 
// Module Name: Basys
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


module Basys(
    input  logic        mainClk,
    input  logic [4:0]  btnIn,
    input  logic [15:0] switch,
    output logic [6:0]  seg,
    output logic [3:0]  posSeg,
    output logic        dp,
    output logic [4:0]  led
    );

    logic        clk;
    logic        reset;
    logic        clk256;
    logic [4:0]  btn;
    logic [15:0] dispContent;
    logic [31:0] curPC;
    logic [31:0] nextPC;
    logic [31:0] ALUResult;
    logic [31:0] DataBus;
    logic [31:0] aluA;
    logic [31:0] aluB;
    logic [4:0]  rs;
    logic [4:0]  rt;

    logic [31:0] cnt;

    assign reset = ~btn[0];
    assign led[4] = clk256;
    assign led[3] = reset;
    assign led[2] = btn[4];
    assign led[1] = btnIn[4];
    assign clk = btn[0] | btn[4];

    always_comb
    begin
        case({switch[15], switch[14]})
            2'b00 : dispContent <= {curPC[7:0], nextPC[7:0]};
            2'b01 : dispContent <= {ALUResult[7:0], DataBus[7:0]};
            2'b10 : dispContent <= {aluA[7:0], aluB[7:0]};
            2'b11 : dispContent <= {3'b000, rs[4:0], 3'b000, rt[4:0]};
        endcase
    end

    SCPU mySCPU(
        .clk(clk),
        .reset(reset),
        .curPC(curPC),
        .nextPC(nextPC),
        .ALUResult(ALUResult),
        .DataOut(DataBus),
        .ALUA(aluA),
        .ALUB(aluB),
        .rs(rs),
        .rt(rt)
    );

    clkDiv myClkDiv(
        .mainClk(mainClk),
        .clk256(clk256),
        .cnt(cnt)
    );

    btnDebounce myBtn(
        .clk256(clk256),
        .btnIn(btnIn),
        .btnOut(btn)
    );

    display myDisplay(
        .clk256(clk256),
        .clkcnt(cnt),
        .content(dispContent),
        .seg(seg),
        .position(posSeg),
        .dp(dp)
    );

endmodule
