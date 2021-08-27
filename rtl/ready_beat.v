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

//��ready������ʱ��ʱ�����д���
module ready_beat(
    input              clk,
    input              rst_n,
    input      [31:0]  data_up,           //master���������
    output     [31:0]  data_down,         //����slave������
    input               valid_up,         //��master���յ���Ч�ź�
    output    reg       ready_up,         //����ص�master��׼���ź�
    output              valid_down,       //�����slave����Ч�ź�
    input               ready_down        //��slave���յ�׼���ź�
     );

reg         valid_tmp0;
reg         valid_tmp1;
reg [31:0]  data_tmp0;

//valid�ݴ��źţ���valid����ready�������ݴ��źŴ�   
always @(posedge clk or negedge rst_n)begin
   if (rst_n == 1'd0)
       valid_tmp0 <= 1'd0;
   else if (valid_up == 1'd1 && ready_down == 1'd0 && valid_tmp0 == 1'd0 )
       valid_tmp0 <=  1'd1;
   else if (ready_down == 1'd1)
       valid_tmp0 <=  1'd0;
end
 
 //���ݿ����źţ���ѡȡ�ݴ���źŻ���ѡȡֱ��ͨ·
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

//��ready�źŽ��д��� 
always @(posedge clk or negedge rst_n)begin
   if (rst_n == 1'd0)
       ready_up <= 1'd0;
   else
       ready_up <=  ready_down;
end 
endmodule
