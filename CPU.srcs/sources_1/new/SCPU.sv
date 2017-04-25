`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/19 19:41:39
// Design Name: 
// Module Name: SCPU
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

module SCPU(
    input  logic clk,
    input  logic reset,
    output logic [31:0] curPC,
    output logic [31:0] nextPC,
    output logic [31:0] ALUResult, //alu output
    output logic [31:0] DataOut,   //DB databus
    output logic [31:0] ALUA,      //alua
    output logic [31:0] ALUB,      //alub
    output logic [4:0]  rs,
    output logic [4:0]  rt
    );

    logic [31:0] InsOut;
    logic [31:0] WriteReg;
    logic [31:0] AddedPC;
    logic [31:0] WriteData;
    logic [31:0] ReadData2;
    logic [31:0] Extended;
    logic [31:0] Shifted;
    logic [31:0] jAddr;

    logic        zero;

    logic        SelSig;
    logic        PCWre;
    logic        ExtSel;
    logic        RegWre;
    logic        ALUSrcB;
    logic        DBDataSrc;
    logic        InsMemRW;
    logic        RD;
    logic        WR;
    logic        RegDst;
    logic        PCSrc;
    logic  [2:0] ALUOp;

    assign rs = InsOut[25:21];
    assign rt = InsOut[20:16];

    PC myPC(
        .clk(clk),
        .nextPC(nextPC),
        .PCWre(PCWre),
        .reset(reset),
        .curPC(curPC)
    );

    InsReg myInsReg(
        .PC(curPC),
        .InsMemRW(InsMemRW),
        .InsOut(InsOut)
    );

    Adder myPCAdd4(
        .a(4),
        .b(curPC),
        .out(AddedPC)
    );

    Mux2to1 WriteRegSel(
        .SelSig(RegDst),
        .zero(InsOut[20:16]),
        .one(InsOut[15:11]),
        .out(WriteReg)
    );

    Register myRegister(
        .clk(clk),
        .RegWre(RegWre),
        .ReadReg1(InsOut[25:21]),
        .ReadReg2(InsOut[20:16]),
        .WriteReg(WriteReg),
        .WriteData(WriteData),
        .ReadData1(ALUA),
        .ReadData2(ReadData2)
    );

    Extender myExtender(
        .ExtSel(ExtSel),
        .in(InsOut[15:0]),
        .out(Extended)
    );

    CtrUnit myCtrUnit(
        .Ins(InsOut[31:26]),
        .zero(zero),
        .PCWre(PCWre),
        .ALUSrcB(ALUSrcB),
        .DBDataSrc(DBDataSrc),
        .RegWre(RegWre),
        .InsMemRW(InsMemRW),
        .RD(RD),
        .WR(WR),
        .ExtSel(ExtSel),
        .RegDst(RegDst),
        .PCSrc(PCSrc),
        .ALUOp(ALUOp)
    );

    Mux2to1 ReadExtSel(
        .SelSig(ALUSrcB),
        .zero(ReadData2),
        .one(Extended),
        .out(ALUB)
    );

    ALU myALU(
        .ALUA(ALUA),
        .ALUB(ALUB),
        .ALUOp(ALUOp),
        .result(ALUResult),
        .zero(zero)
    );

    ShifterL myShifterL(
        .in(Extended),
        .out(Shifted)
    );

    Adder jumpAdd(
        .a(AddedPC),
        .b(Shifted),
        .out(jAddr)
    );

    Mux2to1 jNextSel(
        .SelSig(PCSrc),
        .zero(AddedPC),
        .one(jAddr),
        .out(nextPC)
    );

    DataReg myDateReg(
        .clk(clk),
        .DataAddr(ALUResult),
        .DataIn(ReadData2),
        .RD(RD),
        .WR(WR),
        .DataOut(DataOut)
    );

    Mux2to1 resultDataSel(
        .SelSig(DBDataSrc),
        .zero(ALUResult),
        .one(DataOut),
        .out(WriteData)
    );


endmodule
