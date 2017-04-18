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

    always_ff (negedge clk)
    begin
        case({RD, WR})
            2'b00 : 
                DataOut <= 32'bz;
            2'b01 :
                DataOut <= {DataMem[DataAddr+3], DataMem[DataAddr+2], DataMem[DataAddr+1], DataMem[DataAddr]};
            2'b10 :
            begin
                DataOut <= 32'bz;
                {DataMem[DataAddr+3], DataMem[DataAddr+2], DataMem[DataAddr+1], DataMem[DataAddr]} <= DataIn;
            end
            2'b11 :
                DataOut <= 32'bz;
        endcase
    end

endmodule
