`timescale 1ns / 1ps

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
    valid_down <= 1'b1;         //若master的valid为1时。始终保持为1（不管此刻ready是否接收数据）
  else if (ready_down)
    valid_down <= 1'b0;         //当master没有新的有效数据，且slave接收了数据。将其置低，表示当前数据已被用，无效
  end                           //在ready信号到来之前，始终保持。

//数据打拍
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    data_down <= 32'd0;          
  else if (ready_up)
    data_down <= data_up;         //若已存入一个有效数据，只有等其被slave接收后才能接收新的数据
end                               //在ready信号到来之前，始终保持。             

assign  ready_up = ready_down || (~valid_down);      //数据反压，            
     
endmodule
