## Clock signal 100 MHz 
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports clk_100MHz] 
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk_100MHz] 
#MIPI 
set_property PACKAGE_PIN M12 [get_ports Camera_GPIO] 
set_property IOSTANDARD LVCMOS33 [get_ports Camera_GPIO] 
 
set_property -dict {PACKAGE_PIN K11 IOSTANDARD LVCMOS33} [get_ports Camera_IIC_SCL] 
set_property -dict {PACKAGE_PIN K12 IOSTANDARD LVCMOS33} [get_ports Camera_IIC_SDA] 
 
set_property PULLUP true [get_ports Camera_IIC_SCL] 
set_property PULLUP true [get_ports Camera_IIC_SDA] 
 
set_property INTERNAL_VREF 0.6 [get_iobanks 14] 
 
set_property -dict {PACKAGE_PIN C10 IOSTANDARD HSUL_12} [get_ports Data_N] 
set_property -dict {PACKAGE_PIN D10 IOSTANDARD HSUL_12} [get_ports Data_P] 
 
set_property -dict {PACKAGE_PIN F11 IOSTANDARD LVDS_25} [get_ports Clk_Rx_Data_N] 
set_property -dict {PACKAGE_PIN G11 IOSTANDARD LVDS_25} [get_ports Clk_Rx_Data_P] 
 
set_property -dict {PACKAGE_PIN J12 IOSTANDARD LVDS_25} [get_ports {Rx_Data_N[0]}] 
set_property -dict {PACKAGE_PIN J11 IOSTANDARD LVDS_25} [get_ports {Rx_Data_P[0]}] 
set_property -dict {PACKAGE_PIN P11 IOSTANDARD LVDS_25} [get_ports {Rx_Data_N[1]}] 
set_property -dict {PACKAGE_PIN P10 IOSTANDARD LVDS_25} [get_ports {Rx_Data_P[1]}] 
 
create_clock -period 4.761 -name dphy_hs_clock_p -waveform {0.000 2.380} [get_ports Clk_Rx_Data_P] 

create_clock -period 13.468 -name pclk -waveform {0.000 6.734} -add [get_pins Driver_MIPI0/clk_100MHz_out] 
 
set_property -dict {PACKAGE_PIN N11 IOSTANDARD LVCMOS33} [get_ports RGB_LED_tri_o]
set_property -dict {PACKAGE_PIN J1 IOSTANDARD LVCMOS33} [get_ports LED_G]
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports LED_R]