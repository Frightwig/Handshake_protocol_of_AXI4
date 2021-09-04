`timescale 1ns / 1ps

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
    valid_down <= 1'b1;         //��master��validΪ1ʱ��ʼ�ձ���Ϊ1�����ܴ˿�ready�Ƿ�������ݣ�
  else if (ready_down)
    valid_down <= 1'b0;         //��masterû���µ���Ч���ݣ���slave���������ݡ������õͣ���ʾ��ǰ�����ѱ��ã���Ч
  end                           //��ready�źŵ���֮ǰ��ʼ�ձ��֡�

//���ݴ���
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    data_down <= 32'd0;          
  else if (ready_up)
    data_down <= data_up;         //���Ѵ���һ����Ч���ݣ�ֻ�е��䱻slave���պ���ܽ����µ�����
end                               //��ready�źŵ���֮ǰ��ʼ�ձ��֡�             

assign  ready_up = ready_down || (~valid_down);      //���ݷ�ѹ��            
     
endmodule
