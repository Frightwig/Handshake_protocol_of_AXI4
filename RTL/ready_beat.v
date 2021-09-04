`timescale 1ns / 1ps

//ready打拍
//若直接用ready信号打拍，因反压会延迟一个周期，可能造成数据丢失。
//需要设计一个暂存信号tmp，若在延迟过程中，有新的数据到来，使其也能被接收。
//tmp只在出现漏数据情况使用，其他情况都不使用
module ready_beat       
    (
    input clk,
    input rst_n,
    input valid_up,
    output ready_up,
    input [31:0] data_up,
    output valid_down,
    input ready_down,
    output [31:0] data_down
    );
  
 reg         ready_reg;          //ready信号打拍  
 reg         valid_reg;         //直接通路有效信号
 reg [31:0]  data_reg;         //直接通路数据
 reg         valid_tmp;        //暂存信号的valid
 reg         valid_tmp1;
 reg [31:0]  data_tmp;         //暂存信号的数据
 reg         key;               //边沿发生信号
 
//ready信号打拍 
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    ready_reg <= 1'b0;          
  else
    ready_reg <= ready_down;         //对slave发送的ready信号进行打拍
  end  
  
 
  //key信号,只有边沿发生，才可以调高temp
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    key <= 1'b0;          
  else if (ready_down ^ ready_reg)
    key <= 1'b1;
  else
    key <= 1'b0;
  end  

    
//直接通路valid信号     
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    valid_reg <= 1'b0;          
  else if (ready_up)
    valid_reg <= valid_up;         //若master的valid为1时。始终保持为1（不管此刻ready是否接收数据）
  end                              //当master没有新的有效数据，且slave接收了数据。将其置低，表示当前数据已被用，无效                          

//直接通路数据
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    data_reg <= 32'd0;          
  else if (ready_up)
    data_reg <= data_up;         //若已存入一个有效数据，只有等其被slave接收后才能接收新的数据
end                               //在ready信号到来之前，始终保持。      

//暂存信号的valid
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    valid_tmp <= 1'b0;          
  else if (valid_tmp)
    valid_tmp <= ~ready_down;         //暂存信号启用时，若下游未接收，则不能改变，若下游接收则拉低
  else if (key)
    valid_tmp <= valid_up;      //如果还未暂存数据，则只有ready信号跳变的时候可以暂存
  end                           //不然保持不变
  
 //暂存信号的数据
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    data_tmp <= 32'd0;          
  else if (valid_tmp)
    data_tmp <=  ready_down ? 32'd0 : data_tmp;         //若暂存的信号被ready接收，拉低,不然保持。
  else if (key)
    data_tmp <= data_up;      //如果tmp没有暂存数据，只有ready信号跳变时接收数据信号
  end 


assign  valid_down = valid_tmp || valid_reg;        //输出的valid有效信号
assign  data_down = valid_tmp ? data_tmp : data_reg;    //输出数据选择
assign  ready_up = ready_reg || (~valid_reg);      //数据反压，            
     
endmodule




