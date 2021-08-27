`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/28 02:28:21
// Design Name: 
// Module Name: valid_ready_beat
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

//?ready?valid????????????
module valid_ready_beat(
    input              clk,
    input              rst_n,
    input      [31:0]  data_up,           //master?????
    output     [31:0]  data_down,         //??slave???
    input               valid_up,         //?master???????
    output    reg       ready_up,         //????master?????
    output    reg       valid_down,       //???slave?????
    input               ready_down        //?slave???????
     );

reg         valid_tmp0,valid_tmp1,valid_tmp2;
reg         valid_delay;
reg [31:0]  data_tmp0;

//valid??????valid??ready?????????   
always @(posedge clk or negedge rst_n)begin
   if (rst_n == 1'd0)
       valid_tmp0 <= 1'd0;
   else if (valid_up == 1'd1 && ready_down == 1'd0 && valid_tmp0 == 1'd0 )
       valid_tmp0 <=  1'd1;
   else if (ready_down == 1'd1)
       valid_tmp0 <=  1'd0;
end

//?valid??????
always @(posedge clk or negedge rst_n)begin
    if (rst_n == 1'd0)
       valid_delay <= 1'd0;
   else 
       valid_delay <= valid_up;
end

//valid_down??
always @(posedge clk or negedge rst_n)begin
    if (rst_n == 1'd0)
       valid_down <= 1'd0;
   else if(valid_down == 1'd0 && valid_delay == 1'd1 && valid_tmp0 == 1'd0)
       valid_down <= 1'd1;
   else 
        valid_down <= 1'd0;
end
 
 //???????????????????????
always @(posedge clk or negedge rst_n)begin
    if (rst_n == 1'd0)
       data_tmp0 <= 32'd0;
   else if (valid_up == 1'd1 && ready_down == 1'd0 && valid_tmp0 == 1'd0)
       data_tmp0 <=  data_up;
end

//??????
always @(posedge clk or negedge rst_n)begin
    if (rst_n == 1'd0)
    begin
       valid_tmp1 <= 1'd0;
       valid_tmp2 <= 1'd0;
    end
    else 
    begin
       valid_tmp1 <=  valid_tmp0;
       valid_tmp2 <=  valid_tmp1;
    end
end

assign  data_down = (valid_tmp0 == 1'd1 || valid_tmp1 == 1'd1 || valid_tmp2 == 1'd1) ? data_tmp0 : data_up; //??????
   

//?ready?????? 
always @(posedge clk or negedge rst_n)begin
   if (rst_n == 1'd0)
       ready_up <= 1'd0;
   else
       ready_up <=  ready_down;
end 
endmodule

