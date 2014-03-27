/* 
(C) OOMusou 2008 http://oomusou.cnblogs.com

Filename    : DE2_70.v
Compiler    : Quartus II 8.0
Description : Demo how to implement Sobel Edge Detector on DE2-70
Release     : 08/25/2008 1.0
*/

module DE2_70 (
  //////////////////////// Clock Input ////////////////////////
  input          iCLK_28,           // 28.63636 MHz
  input          iCLK_50,           // 50 MHz
  input          iCLK_50_2,         // 50 MHz
  input          iCLK_50_3,         // 50 MHz
  input          iCLK_50_4,         // 50 MHz
  input          iEXT_CLOCK,        // External Clock
  //////////////////////// Push Button ////////////////////////
  input  [3:0]   iKEY,              // Pushbutton[3:0]
  //////////////////////// DPDT Switch ////////////////////////
  input  [17:0]  iSW,               // Toggle Switch[17:0]
  //////////////////////// 7-SEG Dispaly ////////////////////////
  output [6:0]   oHEX0_D,           // Seven Segment Digit 0
  output         oHEX0_DP,          // Seven Segment Digit 0 decimal point
  output [6:0]   oHEX1_D,           // Seven Segment Digit 1
  output         oHEX1_DP,          // Seven Segment Digit 1 decimal point
  output [6:0]   oHEX2_D,           // Seven Segment Digit 2
  output         oHEX2_DP,          // Seven Segment Digit 2 decimal point
  output [6:0]   oHEX3_D,           // Seven Segment Digit 3
  output         oHEX3_DP,          // Seven Segment Digit 3 decimal point
  output [6:0]   oHEX4_D,           // Seven Segment Digit 4
  output         oHEX4_DP,          // Seven Segment Digit 4 decimal point
  output [6:0]   oHEX5_D,           // Seven Segment Digit 5
  output         oHEX5_DP,          // Seven Segment Digit 5 decimal point
  output [6:0]   oHEX6_D,           // Seven Segment Digit 6
  output         oHEX6_DP,          // Seven Segment Digit 6 decimal point
  output [6:0]   oHEX7_D,           // Seven Segment Digit 7
  output         oHEX7_DP,          // Seven Segment Digit 7 decimal point
  //////////////////////////// LED ////////////////////////////
  output [8:0]   oLEDG,             // LED Green[8:0]
  output [17:0]  oLEDR,             // LED Red[17:0]
  //////////////////////////// UART ////////////////////////////
  output         oUART_TXD,         // UART Transmitter
  input          iUART_RXD,         // UART Receiver
  output         oUART_CTS,         // UART Clear To Send
  input          iUART_RTS,         // UART Requst To Send
  //////////////////////////// IRDA ////////////////////////////
  output         oIRDA_TXD,         // IRDA Transmitter
  input          iIRDA_RXD,         // IRDA Receiver
  /////////////////////// SDRAM Interface ////////////////////////
  inout   [31:0] DRAM_DQ,           // SDRAM Data bus 32 Bits
  output  [12:0] oDRAM0_A,          // SDRAM0 Address bus 13 Bits
  output  [12:0] oDRAM1_A,          // SDRAM1 Address bus 13 Bits
  output         oDRAM0_LDQM0,      // SDRAM0 Low-byte Data Mask 
  output         oDRAM1_LDQM0,      // SDRAM1 Low-byte Data Mask 
  output         oDRAM0_UDQM1,      // SDRAM0 High-byte Data Mask
  output         oDRAM1_UDQM1,      // SDRAM1 High-byte Data Mask
  output         oDRAM0_WE_N,       // SDRAM0 Write Enable
  output         oDRAM1_WE_N,       // SDRAM1 Write Enable
  output         oDRAM0_CAS_N,      // SDRAM0 Column Address Strobe
  output         oDRAM1_CAS_N,      // SDRAM1 Column Address Strobe
  output         oDRAM0_RAS_N,      // SDRAM0 Row Address Strobe
  output         oDRAM1_RAS_N,      // SDRAM1 Row Address Strobe
  output         oDRAM0_CS_N,       // SDRAM0 Chip Select
  output         oDRAM1_CS_N,       // SDRAM1 Chip Select
  output  [1:0]  oDRAM0_BA,         // SDRAM0 Bank Address
  output  [1:0]  oDRAM1_BA,         // SDRAM1 Bank Address
  output         oDRAM0_CLK,        // SDRAM0 Clock
  output         oDRAM1_CLK,        // SDRAM1 Clock
  output         oDRAM0_CKE,        // SDRAM0 Clock Enable
  output         oDRAM1_CKE,        // SDRAM1 Clock Enable
  //////////////////////// Flash Interface ////////////////////////
  inout   [14:0] FLASH_DQ,          // FLASH Data bus 15 Bits (0 to 14)
  inout          FLASH_DQ15_AM1,    // FLASH Data bus Bit 15 or Address A-1
  output  [21:0] oFLASH_A,          // FLASH Address bus 26 Bits
  output         oFLASH_WE_N,       // FLASH Write Enable
  output         oFLASH_RST_N,      // FLASH Reset
  output         oFLASH_WP_N,       // FLASH Write Protect /Programming Acceleration 
  input          iFLASH_RY_N,       // FLASH Ready/Busy output 
  output         oFLASH_BYTE_N,     // FLASH Byte/Word Mode Configuration
  output         oFLASH_OE_N,       // FLASH Output Enable
  output         oFLASH_CE_N,       // FLASH Chip Enable
  //////////////////////// SRAM Interface ////////////////////////
  inout   [31:0] SRAM_DQ,           // SRAM Data Bus 32 Bits
  inout   [3:0]  SRAM_DPA,          // SRAM Parity Data Bus
  output  [18:0] oSRAM_A,           // SRAM Address bus 21 Bits
  output         oSRAM_ADSC_N,      // SRAM Controller Address Status     
  output         oSRAM_ADSP_N,      // SRAM Processor Address Status
  output         oSRAM_ADV_N,       // SRAM Burst Address Advance
  output  [3:0]  oSRAM_BE_N,        // SRAM Byte Write Enable
  output         oSRAM_CE1_N,       // SRAM Chip Enable
  output         oSRAM_CE2,         // SRAM Chip Enable
  output         oSRAM_CE3_N,       // SRAM Chip Enable
  output         oSRAM_CLK,         // SRAM Clock
  output         oSRAM_GW_N,        // SRAM Global Write Enable
  output         oSRAM_OE_N,        // SRAM Output Enable
  output         oSRAM_WE_N,        // SRAM Write Enable
  //////////////////// ISP1362 Interface ////////////////////////
  inout   [15:0] OTG_D,             // ISP1362 Data bus 16 Bits
  output  [1:0]  oOTG_A,            // ISP1362 Address 2 Bits
  output         oOTG_CS_N,         // ISP1362 Chip Select
  output         oOTG_OE_N,         // ISP1362 Read
  output         oOTG_WE_N,         // ISP1362 Write
  output         oOTG_RESET_N,      // ISP1362 Reset
  inout          OTG_FSPEED,        // USB Full Speed,    0 = Enable, Z = Disable
  inout          OTG_LSPEED,        // USB Low Speed,     0 = Enable, Z = Disable
  input          iOTG_INT0,         // ISP1362 Interrupt 0
  input          iOTG_INT1,         // ISP1362 Interrupt 1
  input          iOTG_DREQ0,        // ISP1362 DMA Request 0
  input          iOTG_DREQ1,        // ISP1362 DMA Request 1
  output         oOTG_DACK0_N,      // ISP1362 DMA Acknowledge 0
  output         oOTG_DACK1_N,      // ISP1362 DMA Acknowledge 1
  //////////////////// LCD Module 16X2 ////////////////////////////
  inout   [7:0]  LCD_D,             // LCD Data bus 8 bits
  output         oLCD_ON,           // LCD Power ON/OFF
  output         oLCD_BLON,         // LCD Back Light ON/OFF
  output         oLCD_RW,           // LCD Read/Write Select, 0 = Write, 1 = Read
  output         oLCD_EN,           // LCD Enable
  output         oLCD_RS,           // LCD Command/Data Select, 0 = Command, 1 = Data
  //////////////////// SD Card Interface ////////////////////////
  inout          SD_DAT,            // SD Card Data
  inout          SD_DAT3,           // SD Card Data 3
  inout          SD_CMD,            // SD Card Command Signal
  output         oSD_CLK,           // SD Card Clock
  //////////////////////// I2C ////////////////////////////////
  inout          I2C_SDAT,          // I2C Data
  output         oI2C_SCLK,         // I2C Clock
  //////////////////////// PS2 ////////////////////////////////
  inout          PS2_KBDAT,         // PS2 Keyboard Data
  inout          PS2_KBCLK,         // PS2 Keyboard Clock
  inout          PS2_MSDAT,         // PS2 Mouse Data
  inout          PS2_MSCLK,         // PS2 Mouse Clock
  //////////////////////// VGA ////////////////////////////
  output         oVGA_CLOCK,        // VGA Clock
  output         oVGA_HS,           // VGA H_SYNC
  output         oVGA_VS,           // VGA V_SYNC
  output         oVGA_BLANK_N,      // VGA BLANK
  output         oVGA_SYNC_N,       // VGA SYNC
  output  [9:0]  oVGA_R,            // VGA Red[9:0]
  output  [9:0]  oVGA_G,            // VGA Green[9:0]
  output  [9:0]  oVGA_B,            // VGA Blue[9:0]
  //////////////// Ethernet Interface ////////////////////////////
  inout   [15:0] ENET_D,            // DM9000A DATA bus 16Bits
  output         oENET_CMD,         // DM9000A Command/Data Select, 0 = Command, 1 = Data
  output         oENET_CS_N,        // DM9000A Chip Select
  output         oENET_IOW_N,       // DM9000A Write
  output         oENET_IOR_N,       // DM9000A Read
  output         oENET_RESET_N,     // DM9000A Reset
  input          iENET_INT,         // DM9000A Interrupt
  output         oENET_CLK,         // DM9000A Clock 25 MHz
  //////////////////// Audio CODEC  ////////////////////////////
  inout          AUD_ADCLRCK,       // Audio CODEC ADC LR Clock
  input          iAUD_ADCDAT,       // Audio CODEC ADC Data
  inout          AUD_DACLRCK,       // Audio CODEC DAC LR Clock
  output         oAUD_DACDAT,       // Audio CODEC DAC Data
  inout          AUD_BCLK,          // Audio CODEC Bit-Stream Clock
  output         oAUD_XCK,          // Audio CODEC Chip Clock
  //////////////////// TV Devoder   ////////////////////////////
  input          iTD1_CLK27,        // TV Decoder1 Line_Lock Output Clock 
  input   [7:0]  iTD1_D,            // TV Decoder1 Data bus 8 bits
  input          iTD1_HS,           // TV Decoder1 H_SYNC
  input          iTD1_VS,           // TV Decoder1 V_SYNC
  output         oTD1_RESET_N,      // TV Decoder1 Reset
  input          iTD2_CLK27,        // TV Decoder2 Line_Lock Output Clock         
  input   [7:0]  iTD2_D,            // TV Decoder2 Data bus 8 bits
  input          iTD2_HS,           // TV Decoder2 H_SYNC
  input          iTD2_VS,           // TV Decoder2 V_SYNC
  output         oTD2_RESET_N,      // TV Decoder2 Reset
  //////////////////////// GPIO ////////////////////////////////
  inout   [31:0] GPIO_0,            // GPIO Connection 0 I/O
  input          GPIO_CLKIN_N0,     // GPIO Connection 0 Clock Input 0
  input          GPIO_CLKIN_P0,     // GPIO Connection 0 Clock Input 1
  inout          GPIO_CLKOUT_N0,    // GPIO Connection 0 Clock Output 0
  inout          GPIO_CLKOUT_P0,    // GPIO Connection 0 Clock Output 1
  inout   [31:0] GPIO_1,            // GPIO Connection 1 I/O
  input          GPIO_CLKIN_N1,     // GPIO Connection 1 Clock Input 0
  input          GPIO_CLKIN_P1,     // GPIO Connection 1 Clock Input 1
  inout          GPIO_CLKOUT_N1,    // GPIO Connection 1 Clock Output 0
  inout          GPIO_CLKOUT_P1     // GPIO Connection 1 Clock Output 1
);

wire  [11:0]  CCD_DATA;
wire          CCD_SDAT;
wire          CCD_SCLK;
wire          CCD_FLASH;
wire          CCD_FVAL;
wire          CCD_LVAL;
wire          CCD_PIXCLK;
wire          CCD_MCLK; //  CCD Master Clock

wire  [15:0]  Read_DATA1;
wire  [15:0]  Read_DATA2;
wire          VGA_CTRL_CLK;
wire  [11:0]  mCCD_DATA;
wire          mCCD_DVAL;
wire          mCCD_DVAL_d;
wire  [15:0]  X_Cont;
wire  [15:0]  Y_Cont;
wire  [9:0]   X_ADDR;
wire  [31:0]  Frame_Cont;
wire          DLY_RST_0;
wire          DLY_RST_1;
wire          DLY_RST_2;
wire          Read;
reg   [11:0]  rCCD_DATA;
reg           rCCD_LVAL;
reg           rCCD_FVAL;
wire  [11:0]  sCCD_R;
wire  [11:0]  sCCD_G;
wire  [11:0]  sCCD_B;
wire          sCCD_DVAL;
reg   [1:0]   rClk;
wire          sdram_ctrl_clk;


// Touch panel signal
wire  [7:0]   ltm_r;    //  LTM Red Data 8 Bits
wire  [7:0]   ltm_g;    //  LTM Green Data 8 Bits
wire  [7:0]   ltm_b;    //  LTM Blue Data 8 Bits
wire          ltm_nclk; //  LTM Clcok
wire          ltm_hd;
wire          ltm_vd;
wire          ltm_den;
wire          adc_dclk;
wire          adc_cs;
wire          adc_penirq_n;
wire          adc_busy;
wire          adc_din;
wire          adc_dout;
wire          adc_ltm_sclk;
wire          ltm_grst;
// LTM Config
wire          ltm_sclk;
wire          ltm_sda;
wire          ltm_scen;
wire          ltm_3wirebusy_n;

assign  CCD_DATA[0]     = GPIO_1[11];
assign  CCD_DATA[1]     = GPIO_1[10];
assign  CCD_DATA[2]     = GPIO_1[9];
assign  CCD_DATA[3]     = GPIO_1[8];
assign  CCD_DATA[4]     = GPIO_1[7];
assign  CCD_DATA[5]     = GPIO_1[6];
assign  CCD_DATA[6]     = GPIO_1[5];
assign  CCD_DATA[7]     = GPIO_1[4];
assign  CCD_DATA[8]     = GPIO_1[3];
assign  CCD_DATA[9]     = GPIO_1[2];
assign  CCD_DATA[10]    = GPIO_1[1];
assign  CCD_DATA[11]    = GPIO_1[0];
assign  GPIO_CLKOUT_N1  = CCD_MCLK;
assign  CCD_FVAL        = GPIO_1[18];
assign  CCD_LVAL        = GPIO_1[17];
assign  CCD_PIXCLK      = GPIO_CLKIN_N1;
assign  GPIO_1[15]      = 1'b1;  // tRIGGER
assign  GPIO_1[14]      = DLY_RST_1;

assign  oLEDR = iSW;
assign  oLEDG = Y_Cont;

assign  oTD1_RESET_N = 1'b1;
assign  oVGA_CLOCK   = VGA_CTRL_CLK;

assign CCD_MCLK = rClk[0];

assign  oUART_TXD = iUART_RXD;

assign  adc_penirq_n  = GPIO_CLKIN_N0;
assign  adc_dout      = GPIO_0[0];
assign  adc_busy      = GPIO_CLKIN_P0;
assign  GPIO_0[1]     = adc_din;
assign  GPIO_0[2]     = adc_ltm_sclk;
assign  GPIO_0[3]     = ltm_b[3];
assign  GPIO_0[4]     = ltm_b[2];
assign  GPIO_0[5]     = ltm_b[1];
assign  GPIO_0[6]     = ltm_b[0];
assign  GPIO_0[7]     =~ltm_nclk;
assign  GPIO_0[8]     =ltm_den;
assign  GPIO_0[9]     =ltm_hd;
assign  GPIO_0[10]    =ltm_vd;
assign  GPIO_0[11]    =ltm_b[4];
assign  GPIO_0[12]    =ltm_b[5];
assign  GPIO_0[13]    =ltm_b[6];
assign  GPIO_CLKOUT_N0=ltm_b[7];
assign  GPIO_0[14]    =ltm_g[0];
assign  GPIO_CLKOUT_P0=ltm_g[1];
assign  GPIO_0[15]    =ltm_g[2];
assign  GPIO_0[16]    =ltm_g[3];
assign  GPIO_0[17]    =ltm_g[4];
assign  GPIO_0[18]    =ltm_g[5];
assign  GPIO_0[19]    =ltm_g[6];
assign  GPIO_0[20]    =ltm_g[7];
assign  GPIO_0[21]    =ltm_r[0];
assign  GPIO_0[22]    =ltm_r[1];
assign  GPIO_0[23]    =ltm_r[2];
assign  GPIO_0[24]    =ltm_r[3];
assign  GPIO_0[25]    =ltm_r[4];
assign  GPIO_0[26]    =ltm_r[5];
assign  GPIO_0[27]    =ltm_r[6];
assign  GPIO_0[28]    =ltm_r[7];
assign  GPIO_0[29]    =ltm_grst;
assign  GPIO_0[30]    =ltm_scen;
assign  GPIO_0[31]    =ltm_sda;

assign  ltm_grst      = iKEY[0];
assign adc_ltm_sclk   = ltm_sclk ;






always@(posedge iCLK_50)
  rClk  <=  rClk+1;

always@(posedge CCD_PIXCLK) begin
  rCCD_DATA <=  CCD_DATA;
  rCCD_LVAL <=  CCD_LVAL;
  rCCD_FVAL <=  CCD_FVAL;
end

Reset_Delay reset0 (
  .iCLK(iCLK_50),
  .iRST(iKEY[0]),
  .oRST_0(DLY_RST_0),
  .oRST_1(DLY_RST_1),
  .oRST_2(DLY_RST_2)
);

CCD_Capture capture0 (
  .oDATA(mCCD_DATA),
  .oDVAL(mCCD_DVAL),
  .oX_Cont(X_Cont),
  .oY_Cont(Y_Cont),
  .oFrame_Cont(Frame_Cont),
  .iDATA(rCCD_DATA),
  .iFVAL(rCCD_FVAL),
  .iLVAL(rCCD_LVAL),
  .iSTART(!iKEY[3]),
  .iEND(!iKEY[2]),
  .iCLK(CCD_PIXCLK),
  .iRST(DLY_RST_2)
);

RAW2RGB raw0 (
  .iCLK(CCD_PIXCLK),
  .iRST_n(DLY_RST_1),
  .iData(mCCD_DATA),
  .iDval(mCCD_DVAL),
  .oRed(sCCD_R),
  .oGreen(sCCD_G),
  .oBlue(sCCD_B),
  .oDval(sCCD_DVAL),
  .iMIRROR(iSW[17]),
  .iX_Cont(X_Cont),
  .iY_Cont(Y_Cont)
);

SEG7_LUT_8 seg0 (
  .oSEG0(oHEX0_D),
  .oSEG1(oHEX1_D),
  .oSEG2(oHEX2_D),
  .oSEG3(oHEX3_D),
  .oSEG4(oHEX4_D),
  .oSEG5(oHEX5_D),
  .oSEG6(oHEX6_D),
  .oSEG7(oHEX7_D),
  .iDIG(Frame_Cont[31:0])
);

vga_pll vga_pll0 (
  .inclk0(iCLK_50_2),
  .c0(ltm_nclk)
);

sdram_pll sdram_pll0 (
  .inclk0(iCLK_50_3),
  .c0(sdram_ctrl_clk),
  .c1(oDRAM0_CLK),
  .c2(oDRAM1_CLK)
);

Sdram_Control_4Port sdram0 (
  //  HOST Side
  .REF_CLK(iCLK_50),
  .RESET_N(1'b1),
  .CLK(sdram_ctrl_clk),
  //  FIFO Write Side 1
  .WR1_DATA({sCCD_G[11:7],  sCCD_B[11:2]}),
  .WR1(sCCD_DVAL),
  .WR1_ADDR(0),
  .WR1_MAX_ADDR(800*480),
  .WR1_LENGTH(9'h100),
  .WR1_LOAD(!DLY_RST_0),
  .WR1_CLK(CCD_PIXCLK),
  //  FIFO Read Side 1
  .RD1_DATA(Read_DATA1),
  .RD1(wDAL_sobel),
  .RD1_ADDR(0),
  .RD1_MAX_ADDR(800*480),
  .RD1_LENGTH(9'h100),
  .RD1_LOAD(!DLY_RST_0),
  .RD1_CLK(~ltm_nclk),
  //  SDRAM Side
  .SA(oDRAM0_A[11:0]),
  .BA(oDRAM0_BA),
  .CS_N(oDRAM0_CS_N),
  .CKE(oDRAM0_CKE),
  .RAS_N(oDRAM0_RAS_N),
  .CAS_N(oDRAM0_CAS_N),
  .WE_N(oDRAM0_WE_N),
  .DQ(DRAM_DQ[15:0]),
  .DQM({oDRAM0_UDQM1,oDRAM0_LDQM0})
);

Sdram_Control_4Port sdram1 (
  //  HOST Side
  .REF_CLK(iCLK_50),
  .RESET_N(1'b1),
  .CLK(sdram_ctrl_clk),
  //  FIFO Write Side 1
  .WR1_DATA({sCCD_G[6:2], sCCD_R[11:2]}),
  .WR1(sCCD_DVAL),
  .WR1_ADDR(0),
  .WR1_MAX_ADDR(800*480),
  .WR1_LENGTH(9'h100),
  .WR1_LOAD(!DLY_RST_0),
  .WR1_CLK(CCD_PIXCLK),
  //  FIFO Read Side 1
  .RD1_DATA(Read_DATA2),
  .RD1(wDAL_sobel),
  .RD1_ADDR(0),
  .RD1_MAX_ADDR(800*480),
  .RD1_LENGTH(9'h100),
  .RD1_LOAD(!DLY_RST_0),
  .RD1_CLK(~ltm_nclk),
  //  SDRAM Side
  .SA(oDRAM1_A[11:0]),
  .BA(oDRAM1_BA),
  .CS_N(oDRAM1_CS_N),
  .CKE(oDRAM1_CKE),
  .RAS_N(oDRAM1_RAS_N),
  .CAS_N(oDRAM1_CAS_N),
  .WE_N(oDRAM1_WE_N),
  .DQ(DRAM_DQ[31:16]),
  .DQM({oDRAM1_UDQM1,oDRAM1_LDQM0})
);

I2C_CCD_Config  i2c_ccd_config0 (
  //  Host Side
  .iCLK(iCLK_50),
  .iRST_N(DLY_RST_1),
  .iEXPOSURE_ADJ(iKEY[1]),
  .iEXPOSURE_DEC_p(iSW[0]),
  .iMIRROR_SW(iSW[17]),
  //  I2C Side
  .I2C_SCLK(GPIO_1[20]),
  .I2C_SDAT(GPIO_1[19])
);

touch_tcon vga0 (
  .iCLK(ltm_nclk),
  .iRST_n(DLY_RST_2),
  // sdram side
  .iREAD_DATA1({wDISP_G[9:5], wDISP_B}),
  .iREAD_DATA2({wDISP_G[4:0], wISP_R}),
  .oREAD_SDRAM_EN(Read),
  // lcd side
  .oLCD_R(ltm_r),
  .oLCD_G(ltm_g),
  .oLCD_B(ltm_b),
  .oHD(ltm_hd),
  .oVD(ltm_vd),
  .oDEN(ltm_den)
);

lcd_3wire_config  lcd_config0 (
  // Host Side
  .iCLK(iCLK_50),
  .iRST_n(DLY_RST_0),
  // 3 wire Side
  .o3WIRE_SCLK(ltm_sclk),
  .io3WIRE_SDAT(ltm_sda),
  .o3WIRE_SCEN(ltm_scen),
  .o3WIRE_BUSY_n(ltm_3wirebusy_n)
);

// sobel ----------------------------------------------------
// RGB
wire [9:0] wVGA_R = Read_DATA2[9:0];
wire [9:0] wVGA_G = {Read_DATA1[14:10],Read_DATA2[14:10]};
wire [9:0] wVGA_B = Read_DATA1[9:0];

// sobel
wire       wDVAL_sobel;
wire [9:0] wSobel;

Sobel sobel0 (
  .iCLK(ltm_nclk),
  .iRST_N(DLY_RST_2),
  .iTHRESHOLD(iSW[9:2]),
  .iDVAL(Read),
  .iDATA(wVGA_G), // gray
  .oDVAL(wDAL_sobel),
  .oDATA(wSobel)
);

// gray
wire [9:0] wGray_R = wVGA_G;
wire [9:0] wGray_G = wVGA_G;
wire [9:0] wGray_B = wVGA_G;

// to display
wire [9:0] wDISP_R = iSW[15] ? wGray_R : // Gray
                     iSW[14] ? wSobel :  // Sobel
                               wVGA_R;   // Color
wire [9:0] wDISP_G = iSW[15] ? wGray_G : // Gray
                     iSW[14] ? wSobel :  // Sobel
                               wVGA_G;   // Color
wire [9:0] wDISP_B = iSW[15] ? wGray_B : // Gray
                     iSW[14] ? wSobel :  // Sobel
                               wVGA_B;   // Color

endmodule