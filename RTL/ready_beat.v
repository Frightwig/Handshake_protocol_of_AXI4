`timescale 1ns / 1ps

//ready����
//��ֱ����ready�źŴ��ģ���ѹ���ӳ�һ�����ڣ�����������ݶ�ʧ��
//��Ҫ���һ���ݴ��ź�tmp�������ӳٹ����У����µ����ݵ�����ʹ��Ҳ�ܱ����ա�
//tmpֻ�ڳ���©�������ʹ�ã������������ʹ��
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
  
 reg         ready_reg;          //ready�źŴ���  
 reg         valid_reg;         //ֱ��ͨ·��Ч�ź�
 reg [31:0]  data_reg;         //ֱ��ͨ·����
 reg         valid_tmp;        //�ݴ��źŵ�valid
 reg         valid_tmp1;
 reg [31:0]  data_tmp;         //�ݴ��źŵ�����
 reg         key;               //���ط����ź�
 
//ready�źŴ��� 
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    ready_reg <= 1'b0;          
  else
    ready_reg <= ready_down;         //��slave���͵�ready�źŽ��д���
  end  
  
 
  //key�ź�,ֻ�б��ط������ſ��Ե���temp
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    key <= 1'b0;          
  else if (ready_down ^ ready_reg)
    key <= 1'b1;
  else
    key <= 1'b0;
  end  

    
//ֱ��ͨ·valid�ź�     
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    valid_reg <= 1'b0;          
  else if (ready_up)
    valid_reg <= valid_up;         //��master��validΪ1ʱ��ʼ�ձ���Ϊ1�����ܴ˿�ready�Ƿ�������ݣ�
  end                              //��masterû���µ���Ч���ݣ���slave���������ݡ������õͣ���ʾ��ǰ�����ѱ��ã���Ч                          

//ֱ��ͨ·����
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    data_reg <= 32'd0;          
  else if (ready_up)
    data_reg <= data_up;         //���Ѵ���һ����Ч���ݣ�ֻ�е��䱻slave���պ���ܽ����µ�����
end                               //��ready�źŵ���֮ǰ��ʼ�ձ��֡�      

//�ݴ��źŵ�valid
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    valid_tmp <= 1'b0;          
  else if (valid_tmp)
    valid_tmp <= ~ready_down;         //�ݴ��ź�����ʱ��������δ���գ����ܸı䣬�����ν���������
  else if (key)
    valid_tmp <= valid_up;      //�����δ�ݴ����ݣ���ֻ��ready�ź������ʱ������ݴ�
  end                           //��Ȼ���ֲ���
  
 //�ݴ��źŵ�����
always@(posedge clk or negedge rst_n)
begin
  if (!rst_n)
    data_tmp <= 32'd0;          
  else if (valid_tmp)
    data_tmp <=  ready_down ? 32'd0 : data_tmp;         //���ݴ���źű�ready���գ�����,��Ȼ���֡�
  else if (key)
    data_tmp <= data_up;      //���tmpû���ݴ����ݣ�ֻ��ready�ź�����ʱ���������ź�
  end 


assign  valid_down = valid_tmp || valid_reg;        //�����valid��Ч�ź�
assign  data_down = valid_tmp ? data_tmp : data_reg;    //�������ѡ��
assign  ready_up = ready_reg || (~valid_reg);      //���ݷ�ѹ��            
     
endmodule




