`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/26 21:48:02
// Design Name: 
// Module Name: valid_beat
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

//当valid不满足时序时，进行打拍
module valid_beat(
    input              clk,
    input              rst_n,
    input      [31:0]  data_up,           //master传入的数据
    output reg [31:0]  data_down,         //传向slave的数据
    input               valid_up,         //从master接收的有效信号
    output              ready_up,         //输出回的master的准备信号
    output reg          valid_down,       //输出至slave的有效信号
    input               ready_down        //从slave接收的准备信号
     );
   
//valid信号打拍     
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    valid_down <= 1'b0;          
  else if (valid_up)
    valid_down <= 1'b1;         //若master的valid为1时。始终保持为1
  else if (ready_down)
    valid_down <= 1'b0;         //当来自slave的ready为1时，拉低，表示接收数据同时消去
  else
    valid_down <= valid_down;   //在ready信号到来之前，始终保持。
end

//数据打拍
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    data_down <= 32'd0;          
  else if (valid_up && ready_up)
    data_down <= data_up;         //确保只有在数据有效时，将数据存储，直到传入slave数据保持不变
  else
    data_down <= data_down;   //在ready信号到来之前，始终保持。
end           

assign  ready_up = ready_down || (~valid_down);      //数据反压，            
     
endmodule
