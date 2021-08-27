

`timescale 1ns / 1ps
module handshack_tb(
 
    );
	
	reg clk, rst_n;
	reg en;
	reg [31:0] data_in;
	wire [31:0] data_out;
	
	//--------------------------------------------------
	//????
	initial clk = 0;
	
	always begin
		#1 clk = ~clk; 
	end
	
	//------------------------------------------------------
	//???
	initial begin
		rst_n = 0;
		en = 0;
		
		#6
		rst_n = 1;
		#4
		data_in = 32'd55;
		#2
		en = 1;
		#2
		en =0;
		#6
		data_in = 32'd66;

	end
	
	//------------------------------------------------------
	//????
	handshack handshack_m0(
	.clk (clk),
	.rst_n (rst_n),
	.en (en),
	.datain(datain),
	.dataout(dataout)
	);
	
	endmodule
