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

//��valid������ʱ��ʱ�����д���
module valid_beat(
    input              clk,
    input              rst_n,
    input      [31:0]  data_up,           //master���������
    output reg [31:0]  data_down,         //����slave������
    input               valid_up,         //��master���յ���Ч�ź�
    output              ready_up,         //����ص�master��׼���ź�
    output reg          valid_down,       //�����slave����Ч�ź�
    input               ready_down        //��slave���յ�׼���ź�
     );
   
//valid�źŴ���     
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    valid_down <= 1'b0;          
  else if (valid_up)
    valid_down <= 1'b1;         //��master��validΪ1ʱ��ʼ�ձ���Ϊ1
  else if (ready_down)
    valid_down <= 1'b0;         //������slave��readyΪ1ʱ�����ͣ���ʾ��������ͬʱ��ȥ
  else
    valid_down <= valid_down;   //��ready�źŵ���֮ǰ��ʼ�ձ��֡�
end

//���ݴ���
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    data_down <= 32'd0;          
  else if (valid_up && ready_up)
    data_down <= data_up;         //ȷ��ֻ����������Чʱ�������ݴ洢��ֱ������slave���ݱ��ֲ���
  else
    data_down <= data_down;   //��ready�źŵ���֮ǰ��ʼ�ձ��֡�
end           

assign  ready_up = ready_down || (~valid_down);      //���ݷ�ѹ��            
     
endmodule
