`timescale 1ns / 1ps

//传输主机模块
module handshake_master(
    input clk,
    input rst_n,
    input ready,
    input en,
    output  reg valid,
    input [31:0] data_in,
    output [31:0] data_out
    );
    
    reg [31:0]   data_reg;         //传输数据
    assign       data_out = data_reg;  
          
    //数据有效信号
    always@(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            valid <= 1'd0;
        else 
            valid <= en;                   //由上游的数据使能信号决定当前数据是否有效
    end
    
    //传输数据
    always@(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
            data_reg <= 32'd0;
        else           
            data_reg <= data_in;                  //使能信号发生时，输入数据。              //若没有新的使能信号，代表没有新的有效数据。保持不变
    end
     
endmodule
