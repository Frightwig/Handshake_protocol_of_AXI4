

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
		data_in = 32'd0;
		
		#10
		rst_n = 1;
		#2
		en = 1;
		data_in = 32'd55;
		#2
		en = 0;
		data_in = 32'd56;
    #2
		en = 1;
		data_in = 32'd57;
		#2
		en = 0;
		data_in = 32'd58;
		#2
		en = 0;
		data_in = 32'd59;
		#2
		en = 1;
		data_in = 32'd60;
		#2
		en = 0;
		data_in = 32'd61;
		#2
		en = 0;
		data_in = 32'd62;
		#2
		en = 0;
		data_in = 32'd63;
		#2
		en = 1;
		data_in = 32'd64;
		#2
		en = 0;
		data_in =32'd65;
		

	end
	
	//------------------------------------------------------
	//????
	top top_m0(
	.clk (clk),
	.rst_n (rst_n),
	.en (en),
	.data_in(data_in),
	.data_out(data_out)
	);
	
	endmodule
