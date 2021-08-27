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

//当ready不满足时序时，进行打拍
module ready_beat(
    input              clk,
    input              rst_n,
    input      [31:0]  data_up,           //master传入的数据
    output     [31:0]  data_down,         //传向slave的数据
    input               valid_up,         //从master接收的有效信号
    output    reg       ready_up,         //输出回的master的准备信号
    output              valid_down,       //输出至slave的有效信号
    input               ready_down        //从slave接收的准备信号
     );

reg         valid_tmp0;
reg         valid_tmp1;
reg [31:0]  data_tmp0;

//valid暂存信号，若valid先于ready到来，暂存信号打开   
always @(posedge clk or negedge rst_n)begin
   if (rst_n == 1'd0)
       valid_tmp0 <= 1'd0;
   else if (valid_up == 1'd1 && ready_down == 1'd0 && valid_tmp0 == 1'd0 )
       valid_tmp0 <=  1'd1;
   else if (ready_down == 1'd1)
       valid_tmp0 <=  1'd0;
end
 
 //数据控制信号，是选取暂存的信号还是选取直接通路
always @(posedge clk or negedge rst_n)begin
    if (rst_n == 1'd0)
       data_tmp0 <= 32'd0;
   else if (valid_up == 1'd1 && ready_down == 1'd0 && valid_tmp0 == 1'd0)
       data_tmp0 <=  data_up;
end

always @(posedge clk or negedge rst_n)begin
    if (rst_n == 1'd0)
       valid_tmp1 <= 1'd0;
   else 
       valid_tmp1 <=  valid_tmp0;
end

assign  data_down = (valid_tmp0 == 1'd1 || valid_tmp1 == 1'd1) ? data_tmp0 : data_up;
assign  valid_down = valid_tmp0 ^ valid_up;

//对ready信号进行打拍 
always @(posedge clk or negedge rst_n)begin
   if (rst_n == 1'd0)
       ready_up <= 1'd0;
   else
       ready_up <=  ready_down;
end 
endmodule
