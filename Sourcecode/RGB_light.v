`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/30 11:10:37
// Design Name: 
// Module Name: RGB_light
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


module RGB_light(
    output RGB_LED_tri_o,                    //RGB 输出 
    input clk_100MHz,                         //输入时钟信号 100MHz
    input [23:0]RGB_Data 
); 
 
wire clk_10MHz;                             //时钟信号 
wire clk_1kHz;                              //时钟信号 
 
reg [30:0]Clk_Divide_1kHz=100000;         //分频周期 
reg [30:0]Clk_Divide_10MHz=10;            //分频周期 
reg [7:0]R_In1=0;                         //RGB 数值预置 
reg [7:0]G_In1=0;                           //RGB 数值预置 
reg [7:0]B_In1=255;                           //RGB 数值预置 
reg [7:0]R_In2=0;                         //RGB 数值预置 
reg [7:0]G_In2=0;                           //RGB 数值预置 
reg [7:0]B_In2=255;                           //RGB 数值预置 
reg Rst=1;                                  //复位信号,低电平有效 

integer Cnt=0;

Clk_Division_0 Clk_Division0(.clk_100MHz(clk_100MHz),.clk_mode(Clk_Divide_10MHz),.clk_out(clk_10MHz)); 
Clk_Division_0 Clk_Division1(.clk_100MHz(clk_100MHz),.clk_mode(Clk_Divide_1kHz),.clk_out(clk_1kHz)); 
//周期性改变 RGB 预置值 
always @(posedge clk_1kHz) 
    begin 
        if(Cnt==1) 
            begin 
                R_In1<=RGB_Data[23:16]; 
                G_In1<=RGB_Data[15:8]; 
                B_In1<=RGB_Data[7:0]; 
                R_In2<=RGB_Data[23:16]; 
                G_In2<=RGB_Data[15:8]; 
                B_In2<=RGB_Data[7:0]; 
                Rst=0; 
            end 
        else if(Cnt==8000) 
            begin 
                R_In1<=RGB_Data[23:16]; 
                G_In1<=RGB_Data[15:8]; 
                B_In1<=RGB_Data[7:0]; 
                R_In2<=RGB_Data[23:16]; 
                G_In2<=RGB_Data[15:8]; 
                B_In2<=RGB_Data[7:0]; 
                Rst=0; 
            end 
        else if(Cnt==16000) 
            begin 
                Cnt=0; 
                Rst=1; 
            end 
        else 
            Rst=1; 
             
        Cnt=Cnt+1; 
    end 
Driver_SK6805_0 driver(
    .R_In1(R_In1),
    .G_In1(G_In1),
    .B_In1(B_In1),
    .R_In2(R_In2),
    .G_In2(G_In2),
    .B_In2(B_In2),
    .clk_10MHz(clk_10MHz),
    .Rst(Rst),
    .LED_IO(RGB_LED_tri_o)
    );
endmodule 

