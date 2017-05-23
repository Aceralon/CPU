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

    initial
        Reg[0] = 32'b0;

    assign ReadData1 = Reg[ReadReg1];
    assign ReadData2 = Reg[ReadReg2];

    always_ff @ (negedge clk)
    begin
        if (RegWre && WriteReg != 0)
            Reg[WriteReg] <= WriteData;
    end

endmodule
