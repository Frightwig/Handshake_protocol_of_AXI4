`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/26 12:56:05
// Design Name: 
// Module Name: handshake_slave
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

//�ӻ�ģ��
module handshake_slave(
    input        clk,           //����ʱ��
    input        rst_n,         //��λ�ź�
    input [31:0] data_in,       //��������
    input        valid,         //������Ч�ź�
    output reg   ready,          //׼�������ź�
    output [31:0] data_out      //�������
    );
    
    reg [31:0]   data_store;   //������������
    reg [1:0]    load_flag;    //���ݽ�����ɱ�־
    
    assign       data_out = data_store;     
    
    //ready,�ӻ�׼�������ź�
    always@ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            ready <= 1'b0;                 //��λ����
        else if (ready && valid)
            ready <= 1'b0;                  //valid��readyͬʱ��Чʱ��ready����
        else if (load_flag == 2'd3)
            ready <= 1'b1;                  //���ݽ��պ����3��clk�󣬴ӻ��ٴ�׼������
        else
            ready <= ready;
    end
    
    //load_flag ��������ź�
    always@ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            load_flag <= 1'b0;                 //��λ����
        else if (ready && valid)
            load_flag <= 1'b0;                  //valid��readyͬʱ��Чʱ��ready����
        else if (load_flag >= 2'd3)
            load_flag <= 2'd3;                  //���ݽ���3��clk�󣬴ӻ��ٴ�׼������
        else
            load_flag <= load_flag + 3'd1;
    end    

    //���������ź�
    always@ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            data_store <= 32'd0;                 //��λ����
        else if (ready && valid)
            data_store <= data_in;              //valid��readyͬʱ��Чʱ����������
        else 
            data_store <= data_store;
    end                    
    
endmodule
