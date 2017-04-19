`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 18:21:24
// Design Name: 
// Module Name: CtrUnit
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


module CtrUnit(
    input  logic [5:0] Ins,
    input  logic       zero,
    output logic       PCWre,
    output logic       ALUSrcB,
    output logic       DBDataSrc,
    output logic       RegWre,
    output logic       InsMemRW,
    output logic       RD,
    output logic       WR,
    output logic       ExtSel,
    output logic       RegDst,
    output logic       PCSrc,
    output logic [2:0] ALUOp
    );

    /*always_comb  : InstructionContrl
    begin
        case(Ins)
            6'b000000 : //addu
            begin
                PCWre <= 1;
                ALUSrcB <= 0;
                DBDataSrc <= 0;
                RegWre <= 1;
                InsMemRW <= 1;
                RD <= 1;
                WR <= 1;
                ExtSel <= 0;
                RegDst <= 1;
                PCSrc <= 0;
                ALUOp <= 3'b000;
            end
            6'b000001 : //addiu
            begin
                PCWre <= 1;
                ALUSrcB <= 1;
                DBDataSrc <= 0;
                RegWre <= 1;
                InsMemRW <= 1;
                RD <= 1;
                WR <= 1;
                ExtSel <= 0;
                RegDst <= 0;
                PCSrc <= 0;
                ALUOp <= 3'b000;
            end
            6'b000010 : //subu
            begin
                PCWre <= 1;
                ALUSrcB <= 0;
                DBDataSrc <= 0;
                RegWre <= 1;
                InsMemRW <= 1;
                RD <= 1;
                WR <= 1;
                ExtSel <= 0;
                RegDst <= 1;
                PCSrc <= 0;
                ALUOp <= 3'b001;
            end
            6'b010000 : // ori
            begin
                PCWre <= 1;
                ALUSrcB <= 1;
                DBDataSrc <= 0;
                RegWre <= 1;
                InsMemRW <= 1;
                RD <= 1;
                WR <= 1;
                ExtSel <= 0;
                RegDst <= 0;
                PCSrc <= 0;
                ALUOp <= 3'b011;
            end
            6'b010001 : //and
            begin
                PCWre <= 1;
                ALUSrcB <= 0;
                DBDataSrc <= 0;
                RegWre <= 1;
                InsMemRW <= 1;
                RD <= 1;
                WR <= 1;
                ExtSel <= 0;
                RegDst <= 1;
                PCSrc <= 0;
                ALUOp <= 3'b100;
            end
            6'b010010 : //or
            begin
                PCWre <= 1;
                ALUSrcB <= 1;
                DBDataSrc <= 0;
                RegWre <= 1;
                InsMemRW <= 1;
                RD <= 1;
                WR <= 1;
                ExtSel <= 1;
                RegDst <= 0;
                PCSrc <= 0
                ALUOp <= 3'b000;
            end
            6'b100110 : //sw
            begin
                PCWre <= 1;
                ALUSrcB <= 1;
                DBDataSrc <= 0;
                RegWre <= 0;
                InsMemRW <= 1;
                RD <= 1;
                WR <= 0;
                ExtSel <= 1;
                RegDst <= 0;
                PCSrc <= 0;
                ALUOp <= 3'b000;
            end
            6'b100111 : //lw
            begin
                PCWre <= 1;
                ALUSrcB <= 1;
                DBDataSrc <= 1;
                RegWre <= 1;
                InsMemRW <= 1;
                RD <= 0;
                WR <= 1;
                ExtSel <= 1;
                RegDst <= 0;
                PCSrc <= 0;
                ALUOp <= 3'b000;
            end
            6'b110000 : //bne
            begin
                PCWre <= 1;
                ALUSrcB <= 0;
                DBDataSrc <= 0;
                RegWre <= 0;
                InsMemRW <= 1;
                RD <= 1;
                WR <= 1;
                ExtSel <= 1;
                RegDst <= 0;
                if(zero)
                    PCSrc <= 0;
                else
                    PCSrc <= 1;
                ALUOp <= 3'b000;
            end
            6'b111111 : //halt
            begin
                PCWre <= 0;
                ALUSrcB <= 0;
                DBDataSrc <= 0;
                RegWre <= 0;
                InsMemRW <= 1;
                RD <= 1;
                WR <= 1;
                ExtSel <= 1;
                RegDst <= 0;
                PCSrc <= 0
                ALUOp <= 3'b000;
            end
            default :
            begin
                PCWre <= 0;
                ALUSrcB <= 1;
                DBDataSrc <= 0;
                RegWre <= 1;
                InsMemRW <= 1;
                RD <= 1;
                WR <= 1;
                ExtSel <= 1;
                RegDst <= 0;
                PCSrc <= 0
                ALUOp <= 3'b000;
            end
    end*/

    assign
    begin
        PCWre = !(Ins == 6'b111111);
        ALUSrcB = (Ins == 6'b000001 || Ins == 6'b010000, || Ins == 6'b100110 || Ins == 6'b100111);
        DBDataSrc = (Ins == 6'b100111);
        RegWre = !(Ins == 6'b100110 || Ins == 6'b110000 || Ins == 6'b111111);
        InsMemRW = 1;
        RD = !(Ins == 6'b100111);
        WR = !(Ins == 6'b100110);
        ExtSel = !(Ins == 6'b000001 || Ins == 6'b010000);
        RegDst = !(Ins == 6'b000001 || Ins == 6'b010000 || Ins == 6'b100111);
        PCSrc = !(Ins == 6'b110000 && !zero);
        ALUOp[2] = (Ins == 6'b010001); 
        ALUOp[1] = (Ins == 6'b010000);
        ALUOp[0] = (Ins == 6'b000010 || Ins == 6'b010000);
    end

endmodule
