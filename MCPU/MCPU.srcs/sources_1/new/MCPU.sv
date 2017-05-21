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

module MCPU(
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
    logic [31:0] InsOutOld;
    logic [31:0] WriteReg;
    logic [31:0] AddedPC;
    logic [31:0] WriteData;
    logic [31:0] WriteDataR;
    logic [31:0] ReadData1;
    logic [31:0] ReadData2;
    logic [31:0] ReadData1R;
    logic [31:0] ReadData2R;
    logic [31:0] Extended;
    logic [31:0] Shifted;
    logic [31:0] jAddr;
    logic [31:0] processedPC;
    logic [31:0] ALUResultR;
    logic [31:0] DBData;
    logic [31:0] DBDataR;

    logic        zero;

    logic        WrRegData;  
    logic        PCWre;
    logic        ExtSel;
    logic        RegWre;
    logic        ALUSrcA;
    logic        ALUSrcB;
    logic        DBDataSrc;
    logic        InsMemRW;
    logic        RD;
    logic        WR;
    logic        IRWre;
    logic  [1:0] RegDst;
    logic  [1:0] PCSrc;
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
        .InsOut(InsOutOld)
    );

    Adder myPCAdd4(
        .a(4),
        .b(curPC),
        .out(AddedPC)
    );

    IR myIR(
        .clk(clk),
        .in(InsOutOld),
        .IRWre(IRWre),
        .out(InsOut)
    );

    PCprocess myPCprocess(
        .prePC(InsOut[25:0]),
        .PC4(curPC[31:28]),
        .outPC(processedPC)
    );

    Mux4to1 writeRegSel(
        .SelSig(RegDst),
        .zero(31),
        .one(InsOut[20:16]),
        .two(InsOut[15:11]),
        .out(WriteReg)
    );

    Mux2to1 WriteDataSel(
        .SelSig(WrRegData),
        .zero(AddedPC),
        .one(DBDataR),
        .out(WriteData)
    );

    Register myRegister(
        .clk(clk),
        .RegWre(RegWre),
        .ReadReg1(InsOut[25:21]),
        .ReadReg2(InsOut[20:16]),
        .WriteReg(WriteReg),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );

    Extender myExtender(
        .ExtSel(ExtSel),
        .in(InsOut[15:0]),
        .out(Extended)
    );

    CtrUnit myCtrUnit(
        .clk(clk),
        .reset(reset),
        .Ins(InsOut[31:26]),
        .zero(zero),
        .PCWre(PCWre),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .DBDataSrc(DBDataSrc),
        .RegWre(RegWre),
        .WrRegData(WrRegData),
        .InsMemRW(InsMemRW),
        .RD(RD),
        .WR(WR),
        .IRWre(IRWre),
        .ExtSel(ExtSel),
        .PCSrc(PCSrc),
        .RegDst(RegDst),
        .ALUOp(ALUOp)
    );

    NegR ADR(
        .clk(clk),
        .in(ReadData1),
        .out(ReadData1R)
    );

    NegR BDR(
        .clk(clk),
        .in(ReadData2),
        .out(ReadData2R)
    );

    Mux2to1 Read1Sel(
        .SelSig(ALUSrcA),
        .zero(ReadData1R),
        .one({27'b0,InsOut[10:6]}),
        .out(ALUA)
    );

    Mux2to1 Read2Sel(
        .SelSig(ALUSrcB),
        .zero(ReadData2R),
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

    Mux4to1 PCSel(
        .SelSig(PCSrc),
        .zero(AddedPC),
        .one(jAddr),
        .two(ReadData1),
        .three(processedPC),
        .out(nextPC)
    );

    NegR ALUR(
        .clk(clk),
        .in(ALUResult),
        .out(ALUResultR)
    );

    DataReg myDateReg(
        .clk(clk),
        .DataAddr(ALUResultR),
        .DataIn(ReadData2),
        .RD(RD),
        .WR(WR),
        .DataOut(DataOut)
    );

    Mux2to1 resultDataSel(
        .SelSig(DBDataSrc),
        .zero(ALUResult),
        .one(DataOut),
        .out(DBData)
    );

    NegR DBDR(
        .clk(clk),
        .in(DBData),
        .out(DBDataR)
    );

endmodule
