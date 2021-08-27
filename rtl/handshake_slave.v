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

//从机模块
module handshake_slave(
    input        clk,           //输入时钟
    input        rst_n,         //复位信号
    input [31:0] data_in,       //传入数据
    input        valid,         //数据有效信号
    output reg   ready,          //准备接收信号
    output [31:0] data_out      //输出数据
    );
    
    reg [31:0]   data_store;   //接收输入数据
    reg [1:0]    load_flag;    //数据接收完成标志
    
    assign       data_out = data_store;     
    
    //ready,从机准备接收信号
    always@ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            ready <= 1'b0;                 //复位清零
        else if (ready && valid)
            ready <= 1'b0;                  //valid和ready同时有效时，ready拉低
        else if (load_flag == 2'd3)
            ready <= 1'b1;                  //数据接收后计数3个clk后，从机再次准备接收
        else
            ready <= ready;
    end
    
    //load_flag 接收完成信号
    always@ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            load_flag <= 1'b0;                 //复位清零
        else if (ready && valid)
            load_flag <= 1'b0;                  //valid和ready同时有效时，ready拉低
        else if (load_flag >= 2'd3)
            load_flag <= 2'd3;                  //数据接收3个clk后，从机再次准备接收
        else
            load_flag <= load_flag + 3'd1;
    end    

    //接收数据信号
    always@ (posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            data_store <= 32'd0;                 //复位清零
        else if (ready && valid)
            data_store <= data_in;              //valid和ready同时有效时，输入数据
        else 
            data_store <= data_store;
    end                    
    
endmodule
