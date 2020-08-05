`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/27 09:44:19
// Design Name: 
// Module Name: color_rec
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


module color_rec(
    input clk_100MHz, 
    input Clk_Rx_Data_N, 
    input Clk_Rx_Data_P, 
    input [1:0]Rx_Data_N, 
     input [1:0]Rx_Data_P, 
    input Data_N, 
    input Data_P, 
    inout Camera_IIC_SDA, 
    output Camera_IIC_SCL, 
    output Camera_GPIO, 
    output reg LED_R,
    output reg LED_G,
    output RGB_LED_tri_o
    ); 
    //时钟 
    wire clk_100MHz_system; 
    wire clk_200MHz; 
    wire clk_50MHz; 
    wire clk_10MHz; 
    wire clk_100MHz_out; 
    wire clk_Serial_out; 
    //IIC 数据 
    wire IIC_Rst; 
    wire [7:0]Address;         //IIC 通讯从机设备地址 
    wire [7:0]Data;            //IIC 写数据 
    wire [15:0]Reg_Addr;       //寄存器地址 
    wire [7:0]IIC_Read_Data; 
    wire IIC_Busy;      
    wire Reg2Addr; 
    wire IIC_Write; 
    reg IIC_Read=0; 
    wire Camera_IIC_SDA_I; 
    wire Camera_IIC_SDA_O; 
    wire Camera_IIC_SDA_T; 
    //HDMI 
    wire [23:0]RGB_Data; 
    wire RGB_HSync; 
    wire RGB_VSync; 
    wire RGB_VDE; 
    wire clk_system; 
    clk_wiz_0 clk_10(.clk_out1(clk_100MHz_system),.clk_out2(clk_200MHz),.clk_out3(clk_50MHz),.clk_out4(clk_10MHz),.clk_in1
(clk_100MHz)); 
    RGB_light RGB_LED(
    .RGB_LED_tri_o(RGB_LED_tri_o),                    //RGB 输出 
    .clk_100MHz(clk_100MHz),                         //输入时钟信号 100MHz
    .RGB_Data(RGB_Data) 
    ); 
    //三态门 
    IOBUF Camera_IIC_SDA_IOBUF 
           (.I(Camera_IIC_SDA_O), 
            .IO(Camera_IIC_SDA), 
            .O(Camera_IIC_SDA_I), 
            .T(~Camera_IIC_SDA_T)); 
    //摄像头驱动 
    Driver_MIPI_0 Driver_MIPI0( 
        .clk_200MHz(clk_200MHz), 
        .Clk_Rx_Data_N(Clk_Rx_Data_N), 
        .Clk_Rx_Data_P(Clk_Rx_Data_P), 
        .Rx_Data_N(Rx_Data_N), 
        .Rx_Data_P(Rx_Data_P), 
        .Data_N(Data_N), 
        .Data_P(Data_P), 
        .Camera_GPIO(Camera_GPIO), 
        .RGB_Data(RGB_Data), 
        .RGB_HSync(RGB_HSync), 
        .RGB_VSync(RGB_VSync), 
        .RGB_VDE(RGB_VDE), 
        .clk_100MHz_out(clk_100MHz_out) 
    ); 
    always @(*)
    begin
        if((RGB_Data == 24'hffffff)||((RGB_Data == 24'h000000)))
        begin
            LED_R<=1;
            LED_G<=0;
        end
        begin
            LED_G<=1;
            LED_R<=0;
        end
    end
  
    //IIC 驱动 
    Driver_IIC_0 Driver_IIC0( 
        .clk(clk_100MHz_system), 
        .Rst(IIC_Rst), 
        // 与控制器通信信号 
        .Addr(Address), 
        .Reg_Addr(Reg_Addr), 
        .Data(Data), 
        .IIC_Write(IIC_Write), 
        .IIC_Read(IIC_Read), 
        .IIC_Read_Data(IIC_Read_Data), 
        .IIC_Busy(IIC_Busy), 
        .Reg_2Addr(Reg2Addr), 
             // 外部信号 
        .IIC_SCL(Camera_IIC_SCL), 
        .IIC_SDA_In(Camera_IIC_SDA_I), 
        .SDA_Dir(Camera_IIC_SDA_T),// 控制数据方向,高电平为数据输出 
        .SDA_Out(Camera_IIC_SDA_O)// 输出数据 
    ); 
    //OV5647 摄像头初始化 
    OV5647_Init_0 Diver_OV5647_Init( 
        .clk_10MHz(clk_10MHz), 
        .IIC_Busy(IIC_Busy), 
        .Addr(Address), 
        .Reg_Addr(Reg_Addr), 
        .Reg_Data(Data), 
        .IIC_Write(IIC_Write), 
        .Reg2Addr(Reg2Addr), 
        .Ctrl_IIC(IIC_Rst) 
        ); 
endmodule 
