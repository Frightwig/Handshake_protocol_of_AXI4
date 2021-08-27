`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/08/26 19:56:32
// Design Name: 
// Module Name: top
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


module top(
    input        clk,           //����ʱ��
    input        rst_n,         //��λ�ź�
    input [31:0] data_in,       //��������
    input        en,         //������Ч�ź�
    output [31:0] data_out      //�������    
    );
    

// ����ֱ��ģʽ    
    wire [31:0]       data_trans;
    wire              ready;
    wire              valid;
    
handshake_master handshake_master_m0 (
    . clk (clk),
    . rst_n (rst_n),
    . ready (ready),
    . en    (en),
    . valid  (valid),
    . data_in  (data_in),
    . data_out  (data_trans)
    ); 
     
 handshake_slave handshake_slave_m0 (
    . clk (clk),
    . rst_n (rst_n),
    . ready (ready),
    . valid  (valid),
    . data_in  (data_trans),
    . data_out  (data_out)
    );  

/*    
// valid����ģʽ    
    wire [31:0]       data_trans_1;
    wire [31:0]       data_trans_2;
    wire              ready_1;
    wire              valid_1;
    wire              ready_2;
    wire              valid_2;
    
handshake_master handshake_master_m1 (
    . clk (clk),
    . rst_n (rst_n),
    . ready (ready_1),
    . en    (en),
    . valid  (valid_1),
    . data_in  (data_in),
    . data_out  (data_trans_1)
    ); 
  
valid_beat valid_beat_m0(
    .clk   (clk),
    .rst_n (rst_n),
    .data_up (data_trans_1),           //master���������
    .data_down    (data_trasn_2),         //����slave������
    .valid_up   (valid_1),         //��master���յ���Ч�ź�
    .ready_up  (ready_1),         //����ص�master��׼���ź�
    .valid_down   (valid_2),       //�����slave����Ч�ź�
    .ready_down  (ready_2)       //��slave���յ�׼���ź�
     );  
    
 handshake_slave handshake_slave_m1 (
    . clk (clk),
    . rst_n (rst_n),
    . ready (ready_2),
    . valid  (valid_2),
    . data_in  (data_trans_2),
    . data_out  (data_out)
    );  
    */
    
/*    
// ready����ģʽ    
    wire [31:0]       data_trans_1;
    wire [31:0]       data_trans_2;
    wire              ready_1;
    wire              valid_1;
    wire              ready_2;
    wire              valid_2;
    
handshake_master handshake_master_m2 (
    . clk (clk),
    . rst_n (rst_n),
    . ready (ready_1),
    . en    (en),
    . valid  (valid_1),
    . data_in  (data_in),
    . data_out  (data_trans_1)
    ); 
  
ready_beat ready_beat_m0(
    .clk   (clk),
    .rst_n (rst_n),
    .data_up (data_trans_1),           //master���������
    .data_down    (data_trasn_2),         //����slave������
    .valid_up   (valid_1),         //��master���յ���Ч�ź�
    .ready_up  (ready_1),         //����ص�master��׼���ź�
    .valid_down   (valid_2),       //�����slave����Ч�ź�
    .ready_down  (ready_2)       //��slave���յ�׼���ź�
     );  
    
 handshake_slave handshake_slave_m2 (
    . clk (clk),
    . rst_n (rst_n),
    . ready (ready_2),
    . valid  (valid_2),
    . data_in  (data_trans_2),
    . data_out  (data_out)
    ); 
    */      
      
endmodule
