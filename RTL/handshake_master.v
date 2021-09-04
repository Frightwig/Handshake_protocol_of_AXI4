`timescale 1ns / 1ps

//��������ģ��
module handshake_master(
    input clk,
    input rst_n,
    input ready,
    input en,
    output  reg valid,
    input [31:0] data_in,
    output [31:0] data_out
    );
    
    reg [31:0]   data_reg;         //��������
    assign       data_out = data_reg;  
          
    //������Ч�ź�
    always@(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            valid <= 1'd0;
        else 
            valid <= en;                   //�����ε�����ʹ���źž�����ǰ�����Ƿ���Ч
    end
    
    //��������
    always@(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            data_reg <= 32'd0;
        else           
            data_reg <= data_in;                  //ʹ���źŷ���ʱ���������ݡ�              //��û���µ�ʹ���źţ�����û���µ���Ч���ݡ����ֲ���
    end
     
endmodule
