`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/18 18:21:24
// Design Name: 
// Module Name: DataReg
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


module DataReg(
    input  logic        clk,
    input  logic [31:0] DataAddr,
    input  logic [31:0] DataIn,
    input  logic        RD,
    input  logic        WR,
    output logic [31:0] DataOut
    );

    logic [7:0] DataMem [0:255];

    always_ff @ (negedge clk)
    begin
        case(WR)   
            0 :
            begin
                DataOut <= 32'bz;
                {DataMem[4*DataAddr], DataMem[4*DataAddr+1], DataMem[4*DataAddr+2], DataMem[4*DataAddr+3]} <= DataIn;
            end
            1 :
                DataOut <= 32'bz;
        endcase
    end

    always_comb
    begin
        case(RD)
            0 : DataOut <= {DataMem[4*DataAddr], DataMem[4*DataAddr+1], DataMem[4*DataAddr+2], DataMem[4*DataAddr+3]};
            1 : DataOut <= 32'bz;
        endcase
    end

endmodule
