`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2016/12/20 14:18:41
// Design Name:
// Module Name: display
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


module display(
    input  logic        clk256,
	input  logic [31:0] clkcnt,
    input  logic [15:0] content,
    output logic [6:0]  seg,
    output logic [3:0]  position,
    output logic        dp
    );

	logic [1:0] cnt;
    logic [3:0] nowContent;

	initial
		cnt = 0;

	//second dot contrl
	assign dp = 1;

	//decide the content to read
	always_comb
		case (cnt)
			0 : nowContent <= content[15:12];
			1 : nowContent <= content[11:8];
			2 : nowContent <= content[7:4];
			3 : nowContent <= content[3:0];
		endcase
	
	//decode to 7seg
	always_comb
		case (nowContent)
			4'h0 : seg <= 7'b0000001;
            4'h1 : seg <= 7'b1001111;
            4'h2 : seg <= 7'b0010010;
            4'h3 : seg <= 7'b0000110;
            4'h4 : seg <= 7'b1001100;
            4'h5 : seg <= 7'b0100100;
            4'h6 : seg <= 7'b0100000;
            4'h7 : seg <= 7'b0001111;
            4'h8 : seg <= 7'b0000000;
            4'h9 : seg <= 7'b0000100;
			4'ha : seg <= 7'b0001000;
			4'hb : seg <= 7'b1100000;
			4'hc : seg <= 7'b0110001;
			4'hd : seg <= 7'b1000010;
			4'he : seg <= 7'b0110000;
			4'hf : seg <= 7'b0111000;
		endcase
	
	//the position of output
	always_comb
	begin
		position = 4'b1111;
        position[cnt] = 0;
	end
		
	//count 4
	always_ff @ (posedge clkcnt[15])
		cnt <= cnt + 1;
	
endmodule