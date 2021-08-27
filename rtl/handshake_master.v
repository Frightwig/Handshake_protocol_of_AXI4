`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/26 19:05:08
// Design Name: 
// Module Name: handshake_master
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


module handshake_master(
    input clk,
    input rst_n,
    input ready,
    input en,
    output  reg valid,
    input [31:0] data_in,
    output [31:0] data_out
    );
    

    reg [31:0]   data_reg;         //传输数据
    assign       data_out = data_reg;  
      
    
    //数据有效信号
    always@(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            valid <= 1'd0;
        else if (valid && ready)           
            valid <= 1'd0;                  //valid和ready同时为1，传输数据，拉低有效位
        else if  (en)
            valid <= 1'd1;
        else 
            valid <= valid;
    end
    
    //传输数据
    always@(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            data_reg <= 32'd0;
        else if (en)           
            data_reg <= data_in;                  //使能信号发生时，输出数据至
        else 
            data_reg <= data_reg;
    end
     
endmodule
