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
    input        clk,           //输入时钟
    input        rst_n,         //复位信号
    input [31:0] data_in,       //传入数据
    input        en,         //数据有效信号
    output [31:0] data_out      //输出数据    
    );
    

// 数据直连模式    
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
// valid打拍模式    
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
    .data_up (data_trans_1),           //master传入的数据
    .data_down    (data_trasn_2),         //传向slave的数据
    .valid_up   (valid_1),         //从master接收的有效信号
    .ready_up  (ready_1),         //输出回的master的准备信号
    .valid_down   (valid_2),       //输出至slave的有效信号
    .ready_down  (ready_2)       //从slave接收的准备信号
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
// ready打拍模式    
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
    .data_up (data_trans_1),           //master传入的数据
    .data_down    (data_trasn_2),         //传向slave的数据
    .valid_up   (valid_1),         //从master接收的有效信号
    .ready_up  (ready_1),         //输出回的master的准备信号
    .valid_down   (valid_2),       //输出至slave的有效信号
    .ready_down  (ready_2)       //从slave接收的准备信号
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
