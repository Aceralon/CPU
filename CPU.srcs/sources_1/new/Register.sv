`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 18:19:11
// Design Name: 
// Module Name: Register
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


module Register(
    input  logic        clk,
    input  logic        RegWre,
    input  logic [4:0]  ReadReg1,  //rs
    input  logic [4:0]  ReadReg2,  //rt
    input  logic [4:0]  WriteReg,  //rd
    input  logic [31:0] WriteData,
    output logic [31:0] ReadData1,
    output logic [31:0] ReadData2
    );

    logic [31:0] Reg [0:31];

    always_ff (negedge clk)
    begin
        if (RegWre)
        begin
            Reg[{26 {1'b0}, WriteReg}] <= WriteData;
        end
        else
        begin
            ReadData1 <= Reg[{26 {1'b0}, ReadReg1}];
            ReadData2 <= Reg[{26 {1'b0}, ReadReg2}];
        end
    end

endmodule
