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
    input  logic       clk,
    input  logic       reset,
    input  logic [5:0] Ins,
    input  logic       zero,
    output logic       PCWre,
    output logic       ALUSrcA,
    output logic       ALUSrcB,
    output logic       DBDataSrc,
    output logic       RegWre,
    output logic       WrRegData,
    output logic       InsMemRW,
    output logic       RD,
    output logic       WR,
    output logic       IRWre,
    output logic       ExtSel,
    output logic [1:0] PCSrc,
    output logic [1:0] RegDst,
    output logic [2:0] ALUOp
    );

    logic [2:0] state;

    parameter [5:0] Iadd  = 6'b000000,
                    Isub  = 6'b000001,
                    Iaddi = 6'b000010,
                    Ior   = 6'b010000,
                    Iand  = 6'b010001,
                    Iori  = 6'b010010,
                    Isll  = 6'b011000,
                    Islt  = 6'b100110,
                    Isltu = 6'b100111,
                    Isw   = 6'b110000,
                    Ilw   = 6'b110001,
                    Ibeq  = 6'b110100,
                    Ibne  = 6'b110101,
                    Ij    = 6'b111000,
                    Ijr   = 6'b111001,
                    Ijal  = 6'b111010,
                    Ihalt = 6'b111111;

    always_ff @ (posedge clk, negedge reset)
    begin
        if(!reset)
            state <= 3'b000;
        else
            case(state)
            3'b000 : state <= 3'b001;
            3'b001 : 
            begin
                if(Ins == Ibeq || Ins == Ibne)
                    state <= 3'b101;
                else if(Ins == Isw || Ins == Ilw)
                    state <= 3'b010;
                else if(Ins == Ij || Ins == Ijal || Ins == Ijr || Ins == Ihalt)
                    state <= 3'b000;
                else
                    state <= 3'b110;
            end
            3'b010 : state <= 3'b011;
            3'b011 :
            begin
                if(Ins == Isw)
                    state <= 3'b000;
                else
                    state <= 3'b100;
            end
            3'b100 : state <= 3'b000;
            3'b101 : state <= 3'b000;
            3'b110 : state <= 3'b111;
            3'b111 : state <= 3'b000;
            endcase
    end

    always_comb
    begin
        PCWre <=  (Ins != Ihalt && state == 3'b000);
        ALUSrcA <= (Ins == Isll);
        ALUSrcB <= (Ins == Iaddi || Ins == Iori || Ins == Ilw || Ins == Isw);
        DBDataSrc <= (Ins == Ilw);
        RegWre <= (!(Ins == Ibeq || Ins == Ibne || Ins == Ij ||
                    Ins == Isw || Ins == Ijr || Ins == Ihalt) && (state == 3'b111 || state == 3'b100)) || Ins == Ijal;
        WrRegData <= !(Ins == Ijal);
        InsMemRW <= 1'b1;
        RD <= !(Ins == Ilw && state == 3'b011);
        WR <= !(Ins == Isw && state == 3'b011);
        IRWre <= (state == 3'b000);
        ExtSel <= !(Ins == Iori);
        PCSrc[1] <= (Ins == Ijr || Ins == Ij || Ins == Ijal);
        PCSrc[0] <= (Ins == Ij || Ins == Ijal || (Ins == Ibeq && zero) || (Ins == Ibne && !zero));
        RegDst[1] <= !(Ins == Ijal || Ins == Iaddi || Ins == Iori || Ins == Ilw);
        RegDst[0] <= (Ins == Iaddi || Ins == Iori || Ins == Ilw);
        ALUOp[2] <= (Ins == Ior || Ins == Iand || Ins == Iori || Ins == Isll);
        ALUOp[1] <= (Ins == Iand || Ins == Islt || Ins == Isltu);
        ALUOp[0] <= (Ins == Ior || Ins == Iori || Ins == Isub ||
                    Ins == Islt || Ins == Ibeq || Ins == Ibne);
    end

endmodule
