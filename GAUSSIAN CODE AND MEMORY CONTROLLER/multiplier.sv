// $Id: $
// File name:   multiplier.sv
// Created:     11/20/2013
// Author:      Oluwatosin Adeosun
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Multiply Block.
// 

module multiplier
(
  input wire [1:0] gauss_shift,
  input wire [7:0] nine_buffer_in [0:8][0:8],
   //input wire [7:0][8:0][8:0] nine_buffer_in
  output wire [7:0] gauss_out [0:6]
);
   reg [9:0] mult_out0 [0:2][0:2];
   reg [9:0] mult_out1 [0:2][0:2];
   reg [9:0] mult_out2 [0:2][0:2];
   reg [9:0] mult_out3 [0:2][0:2];
   reg [9:0] mult_out4 [0:2][0:2];
   reg [9:0] mult_out5 [0:2][0:2];
   reg [9:0] mult_out6 [0:2][0:2];
   reg [11:0] temp_out0, temp_out1, temp_out2, temp_out3, temp_out4, temp_out5, temp_out6;
   reg [7:0] result [0:6];

   assign gauss_out = result;

always @* begin
    if(gauss_shift == 2'b01) begin
       mult_out0[0][0]= {1'b0,1'b0,nine_buffer_in[0][6]};
       mult_out0[0][1]= {1'b0,nine_buffer_in[0][7],1'b0};
       mult_out0[0][2]= {1'b0,1'b0,nine_buffer_in[0][8]};
       mult_out0[1][0]= {1'b0,nine_buffer_in[1][6],1'b0};
       mult_out0[1][1]= {nine_buffer_in[1][7],1'b0,1'b0};
       mult_out0[1][2]= {1'b0,nine_buffer_in[1][8],1'b0};
       mult_out0[2][0]= {1'b0,1'b0,nine_buffer_in[2][6]};
       mult_out0[2][1]= {1'b0,nine_buffer_in[2][7],1'b0};
       mult_out0[2][2]= {1'b0,1'b0,nine_buffer_in[2][8]};
       temp_out0 = mult_out0[0][0]+mult_out0[0][1]+mult_out0[0][2]+mult_out0[1][0]+mult_out0[1][1]+mult_out0[1][2]+mult_out0[2][0]+mult_out0[2][1]+mult_out0[2][2];
      result[0] = temp_out0[11:4];
     //  gauss_out[0] = '{temp_out0[11],temp_out0[10],temp_out0[9],temp_out0[8],temp_out0[7],temp_out0[6],temp_out0[5],temp_out0[4]};

       mult_out1[0][0]= {1'b0,1'b0,nine_buffer_in[1][6]};
       mult_out1[0][1]= {1'b0,nine_buffer_in[1][7],1'b0};
       mult_out1[0][2]= {1'b0,1'b0,nine_buffer_in[1][8]};
       mult_out1[1][0]= {1'b0,nine_buffer_in[2][6],1'b0};
       mult_out1[1][1]= {nine_buffer_in[2][7],1'b0,1'b0};
       mult_out1[1][2]= {1'b0,nine_buffer_in[2][8],1'b0};
       mult_out1[2][0]= {1'b0,1'b0,nine_buffer_in[3][6]};
       mult_out1[2][1]= {1'b0,nine_buffer_in[3][7],1'b0};
       mult_out1[2][2]= {1'b0,1'b0,nine_buffer_in[3][8]};
       temp_out1 = mult_out1[0][0]+mult_out1[0][1]+mult_out1[0][2]+mult_out1[1][0]+mult_out1[1][1]+mult_out1[1][2]+mult_out1[2][0]+mult_out1[2][1]+mult_out1[2][2];
       result[1] = temp_out1[11:4];


       mult_out2[0][0]= {1'b0,1'b0,nine_buffer_in[2][6]};
       mult_out2[0][1]= {1'b0,nine_buffer_in[2][7],1'b0};
       mult_out2[0][2]= {1'b0,1'b0,nine_buffer_in[2][8]};
       mult_out2[1][0]= {1'b0,nine_buffer_in[3][6],1'b0};
       mult_out2[1][1]= {nine_buffer_in[3][7],1'b0,1'b0};
       mult_out2[1][2]= {1'b0,nine_buffer_in[3][8],1'b0};
       mult_out2[2][0]= {1'b0,1'b0,nine_buffer_in[4][6]};
       mult_out2[2][1]= {1'b0,nine_buffer_in[4][7],1'b0};
       mult_out2[2][2]= {1'b0,1'b0,nine_buffer_in[4][8]};
       temp_out2 = mult_out2[0][0]+mult_out2[0][1]+mult_out2[0][2]+mult_out2[1][0]+mult_out2[1][1]+mult_out2[1][2]+mult_out2[2][0]+mult_out2[2][1]+mult_out2[2][2];
       result[2] = temp_out2[11:4];


       mult_out3[0][0]= {1'b0,1'b0,nine_buffer_in[3][6]};
       mult_out3[0][1]= {1'b0,nine_buffer_in[3][7],1'b0};
       mult_out3[0][2]= {1'b0,1'b0,nine_buffer_in[3][8]};
       mult_out3[1][0]= {1'b0,nine_buffer_in[4][6],1'b0};
       mult_out3[1][1]= {nine_buffer_in[4][7],1'b0,1'b0};
       mult_out3[1][2]= {1'b0,nine_buffer_in[4][8],1'b0};
       mult_out3[2][0]= {1'b0,1'b0,nine_buffer_in[5][6]};
       mult_out3[2][1]= {1'b0,nine_buffer_in[5][7],1'b0};
       mult_out3[2][2]= {1'b0,1'b0,nine_buffer_in[5][8]};
       temp_out3 = mult_out3[0][0]+mult_out3[0][1]+mult_out3[0][2]+mult_out3[1][0]+mult_out3[1][1]+mult_out3[1][2]+mult_out3[2][0]+mult_out3[2][1]+mult_out3[2][2];
       result[3] = temp_out3[11:4];


       mult_out4[0][0]= {1'b0,1'b0,nine_buffer_in[4][6]};
       mult_out4[0][1]= {1'b0,nine_buffer_in[4][7],1'b0};
       mult_out4[0][2]= {1'b0,1'b0,nine_buffer_in[4][8]};
       mult_out4[1][0]= {1'b0,nine_buffer_in[5][6],1'b0};
       mult_out4[1][1]= {nine_buffer_in[5][7],1'b0,1'b0};
       mult_out4[1][2]= {1'b0,nine_buffer_in[5][8],1'b0};
       mult_out4[2][0]= {1'b0,1'b0,nine_buffer_in[6][6]};
       mult_out4[2][1]= {1'b0,nine_buffer_in[6][7],1'b0};
       mult_out4[2][2]= {1'b0,1'b0,nine_buffer_in[6][8]};
       temp_out4 = mult_out4[0][0]+mult_out4[0][1]+mult_out4[0][2]+mult_out4[1][0]+mult_out4[1][1]+mult_out4[1][2]+mult_out4[2][0]+mult_out4[2][1]+mult_out4[2][2];
       result[4] = temp_out4[11:4];


       mult_out5[0][0]= {1'b0,1'b0,nine_buffer_in[5][6]};
       mult_out5[0][1]= {1'b0,nine_buffer_in[5][7],1'b0};
       mult_out5[0][2]= {1'b0,1'b0,nine_buffer_in[5][8]};
       mult_out5[1][0]= {1'b0,nine_buffer_in[6][6],1'b0};
       mult_out5[1][1]= {nine_buffer_in[6][7],1'b0,1'b0};
       mult_out5[1][2]= {1'b0,nine_buffer_in[6][8],1'b0};
       mult_out5[2][0]= {1'b0,1'b0,nine_buffer_in[7][6]};
       mult_out5[2][1]= {1'b0,nine_buffer_in[7][7],1'b0};
       mult_out5[2][2]= {1'b0,1'b0,nine_buffer_in[7][8]};
       temp_out5 = mult_out5[0][0]+mult_out5[0][1]+mult_out5[0][2]+mult_out5[1][0]+mult_out5[1][1]+mult_out5[1][2]+mult_out5[2][0]+mult_out5[2][1]+mult_out5[2][2];
       result[5] = temp_out5[11:4];

       mult_out6[0][0]= {1'b0,1'b0,nine_buffer_in[6][6]};
       mult_out6[0][1]= {1'b0,nine_buffer_in[6][7],1'b0};
       mult_out6[0][2]= {1'b0,1'b0,nine_buffer_in[6][8]};
       mult_out6[1][0]= {1'b0,nine_buffer_in[7][6],1'b0};
       mult_out6[1][1]= {nine_buffer_in[7][7],1'b0,1'b0};
       mult_out6[1][2]= {1'b0,nine_buffer_in[7][8],1'b0};
       mult_out6[2][0]= {1'b0,1'b0,nine_buffer_in[8][6]};
       mult_out6[2][1]= {1'b0,nine_buffer_in[8][7],1'b0};
       mult_out6[2][2]= {1'b0,1'b0,nine_buffer_in[8][8]};
       temp_out6 = mult_out6[0][0]+mult_out6[0][1]+mult_out6[0][2]+mult_out6[1][0]+mult_out6[1][1]+mult_out6[1][2]+mult_out6[2][0]+mult_out6[2][1]+mult_out6[2][2];
       result[6] = temp_out6[11:4];
       
   end else if (gauss_shift == 2'b10) begin
       mult_out0[0][0]= {1'b0,1'b0,nine_buffer_in[0][0]};
       mult_out0[0][1]= {1'b0,nine_buffer_in[0][1],1'b0};
       mult_out0[0][2]= {1'b0,1'b0,nine_buffer_in[0][2]};
       mult_out0[1][0]= {1'b0,nine_buffer_in[1][0],1'b0};
       mult_out0[1][1]= {nine_buffer_in[1][1],1'b0,1'b0};
       mult_out0[1][2]= {1'b0,nine_buffer_in[1][2],1'b0};
       mult_out0[2][0]= {1'b0,1'b0,nine_buffer_in[2][0]};
       mult_out0[2][1]= {1'b0,nine_buffer_in[2][1],1'b0};
       mult_out0[2][2]= {1'b0,1'b0,nine_buffer_in[2][2]};
       temp_out0 = mult_out0[0][0]+mult_out0[0][1]+mult_out0[0][2]+mult_out0[1][0]+mult_out0[1][1]+mult_out0[1][2]+mult_out0[2][0]+mult_out0[2][1]+mult_out0[2][2];
       result[0] = temp_out0[11:4];

       mult_out1[0][0]= {1'b0,1'b0,nine_buffer_in[1][0]};
       mult_out1[0][1]= {1'b0,nine_buffer_in[1][1],1'b0};
       mult_out1[0][2]= {1'b0,1'b0,nine_buffer_in[1][2]};
       mult_out1[1][0]= {1'b0,nine_buffer_in[2][0],1'b0};
       mult_out1[1][1]= {nine_buffer_in[2][1],1'b0,1'b0};
       mult_out1[1][2]= {1'b0,nine_buffer_in[2][2],1'b0};
       mult_out1[2][0]= {1'b0,1'b0,nine_buffer_in[3][0]};
       mult_out1[2][1]= {1'b0,nine_buffer_in[3][1],1'b0};
       mult_out1[2][2]= {1'b0,1'b0,nine_buffer_in[3][2]};
       temp_out1 = mult_out1[0][0]+mult_out1[0][1]+mult_out1[0][2]+mult_out1[1][0]+mult_out1[1][1]+mult_out1[1][2]+mult_out1[2][0]+mult_out1[2][1]+mult_out1[2][2];
       result[1] = temp_out1[11:4];


       mult_out2[0][0]= {1'b0,1'b0,nine_buffer_in[2][0]};
       mult_out2[0][1]= {1'b0,nine_buffer_in[2][1],1'b0};
       mult_out2[0][2]= {1'b0,1'b0,nine_buffer_in[2][2]};
       mult_out2[1][0]= {1'b0,nine_buffer_in[3][0],1'b0};
       mult_out2[1][1]= {nine_buffer_in[3][1],1'b0,1'b0};
       mult_out2[1][2]= {1'b0,nine_buffer_in[3][2],1'b0};
       mult_out2[2][0]= {1'b0,1'b0,nine_buffer_in[4][0]};
       mult_out2[2][1]= {1'b0,nine_buffer_in[4][1],1'b0};
       mult_out2[2][2]= {1'b0,1'b0,nine_buffer_in[4][2]};
       temp_out2 = mult_out2[0][0]+mult_out2[0][1]+mult_out2[0][2]+mult_out2[1][0]+mult_out2[1][1]+mult_out2[1][2]+mult_out2[2][0]+mult_out2[2][1]+mult_out2[2][2];
       result[2] = temp_out2[11:4];


       mult_out3[0][0]= {1'b0,1'b0,nine_buffer_in[3][0]};
       mult_out3[0][1]= {1'b0,nine_buffer_in[3][1],1'b0};
       mult_out3[0][2]= {1'b0,1'b0,nine_buffer_in[3][2]};
       mult_out3[1][0]= {1'b0,nine_buffer_in[4][0],1'b0};
       mult_out3[1][1]= {nine_buffer_in[4][1],1'b0,1'b0};
       mult_out3[1][2]= {1'b0,nine_buffer_in[4][2],1'b0};
       mult_out3[2][0]= {1'b0,1'b0,nine_buffer_in[5][0]};
       mult_out3[2][1]= {1'b0,nine_buffer_in[5][1],1'b0};
       mult_out3[2][2]= {1'b0,1'b0,nine_buffer_in[5][2]};
       temp_out3 = mult_out3[0][0]+mult_out3[0][1]+mult_out3[0][2]+mult_out3[1][0]+mult_out3[1][1]+mult_out3[1][2]+mult_out3[2][0]+mult_out3[2][1]+mult_out3[2][2];
       result[3] = temp_out3[11:4];


       mult_out4[0][0]= {1'b0,1'b0,nine_buffer_in[4][0]};
       mult_out4[0][1]= {1'b0,nine_buffer_in[4][1],1'b0};
       mult_out4[0][2]= {1'b0,1'b0,nine_buffer_in[4][2]};
       mult_out4[1][0]= {1'b0,nine_buffer_in[5][0],1'b0};
       mult_out4[1][1]= {nine_buffer_in[5][1],1'b0,1'b0};
       mult_out4[1][2]= {1'b0,nine_buffer_in[5][2],1'b0};
       mult_out4[2][0]= {1'b0,1'b0,nine_buffer_in[6][0]};
       mult_out4[2][1]= {1'b0,nine_buffer_in[6][1],1'b0};
       mult_out4[2][2]= {1'b0,1'b0,nine_buffer_in[6][2]};
       temp_out4 = mult_out4[0][0]+mult_out4[0][1]+mult_out4[0][2]+mult_out4[1][0]+mult_out4[1][1]+mult_out4[1][2]+mult_out4[2][0]+mult_out4[2][1]+mult_out4[2][2];
       result[4] = temp_out4[11:4];


       mult_out5[0][0]= {1'b0,1'b0,nine_buffer_in[5][0]};
       mult_out5[0][1]= {1'b0,nine_buffer_in[5][1],1'b0};
       mult_out5[0][2]= {1'b0,1'b0,nine_buffer_in[5][2]};
       mult_out5[1][0]= {1'b0,nine_buffer_in[6][0],1'b0};
       mult_out5[1][1]= {nine_buffer_in[6][1],1'b0,1'b0};
       mult_out5[1][2]= {1'b0,nine_buffer_in[6][2],1'b0};
       mult_out5[2][0]= {1'b0,1'b0,nine_buffer_in[7][0]};
       mult_out5[2][1]= {1'b0,nine_buffer_in[7][1],1'b0};
       mult_out5[2][2]= {1'b0,1'b0,nine_buffer_in[7][2]};
       temp_out5 = mult_out5[0][0]+mult_out5[0][1]+mult_out5[0][2]+mult_out5[1][0]+mult_out5[1][1]+mult_out5[1][2]+mult_out5[2][0]+mult_out5[2][1]+mult_out5[2][2];
       result[5] = temp_out5[11:4];

       mult_out6[0][0]= {1'b0,1'b0,nine_buffer_in[6][0]};
       mult_out6[0][1]= {1'b0,nine_buffer_in[6][1],1'b0};
       mult_out6[0][2]= {1'b0,1'b0,nine_buffer_in[6][2]};
       mult_out6[1][0]= {1'b0,nine_buffer_in[7][0],1'b0};
       mult_out6[1][1]= {nine_buffer_in[7][1],1'b0,1'b0};
       mult_out6[1][2]= {1'b0,nine_buffer_in[7][2],1'b0};
       mult_out6[2][0]= {1'b0,1'b0,nine_buffer_in[8][0]};
       mult_out6[2][1]= {1'b0,nine_buffer_in[8][1],1'b0};
       mult_out6[2][2]= {1'b0,1'b0,nine_buffer_in[8][2]};
       temp_out6 = mult_out6[0][0]+mult_out6[0][1]+mult_out6[0][2]+mult_out6[1][0]+mult_out6[1][1]+mult_out6[1][2]+mult_out6[2][0]+mult_out6[2][1]+mult_out6[2][2];
       result[6] = temp_out6[11:4];

  end else if (gauss_shift == 2'b11) begin
       mult_out0[0][0]= {1'b0,1'b0,nine_buffer_in[6][0]};
       mult_out0[0][1]= {1'b0,nine_buffer_in[6][1],1'b0};
       mult_out0[0][2]= {1'b0,1'b0,nine_buffer_in[6][2]};
       mult_out0[1][0]= {1'b0,nine_buffer_in[7][0],1'b0};
       mult_out0[1][1]= {nine_buffer_in[7][1],1'b0,1'b0};
       mult_out0[1][2]= {1'b0,nine_buffer_in[7][2],1'b0};
       mult_out0[2][0]= {1'b0,1'b0,nine_buffer_in[8][0]};
       mult_out0[2][1]= {1'b0,nine_buffer_in[8][1],1'b0};
       mult_out0[2][2]= {1'b0,1'b0,nine_buffer_in[8][2]};
       temp_out0 = mult_out0[0][0]+mult_out0[0][1]+mult_out0[0][2]+mult_out0[1][0]+mult_out0[1][1]+mult_out0[1][2]+mult_out0[2][0]+mult_out0[2][1]+mult_out0[2][2];
       result[0] = temp_out0[11:4];

       mult_out1[0][0]= {1'b0,1'b0,nine_buffer_in[6][1]};
       mult_out1[0][1]= {1'b0,nine_buffer_in[6][2],1'b0};
       mult_out1[0][2]= {1'b0,1'b0,nine_buffer_in[6][3]};
       mult_out1[1][0]= {1'b0,nine_buffer_in[7][1],1'b0};
       mult_out1[1][1]= {nine_buffer_in[7][2],1'b0,1'b0};
       mult_out1[1][2]= {1'b0,nine_buffer_in[7][3],1'b0};
       mult_out1[2][0]= {1'b0,1'b0,nine_buffer_in[8][1]};
       mult_out1[2][1]= {1'b0,nine_buffer_in[8][2],1'b0};
       mult_out1[2][2]= {1'b0,1'b0,nine_buffer_in[8][3]};
       temp_out1 = mult_out1[0][0]+mult_out1[0][1]+mult_out1[0][2]+mult_out1[1][0]+mult_out1[1][1]+mult_out1[1][2]+mult_out1[2][0]+mult_out1[2][1]+mult_out1[2][2];
       result[1] = temp_out1[11:4];

       mult_out2[0][0]= {1'b0,1'b0,nine_buffer_in[6][2]};
       mult_out2[0][1]= {1'b0,nine_buffer_in[6][3],1'b0};
       mult_out2[0][2]= {1'b0,1'b0,nine_buffer_in[6][4]};
       mult_out2[1][0]= {1'b0,nine_buffer_in[7][2],1'b0};
       mult_out2[1][1]= {nine_buffer_in[7][3],1'b0,1'b0};
       mult_out2[1][2]= {1'b0,nine_buffer_in[7][4],1'b0};
       mult_out2[2][0]= {1'b0,1'b0,nine_buffer_in[8][2]};
       mult_out2[2][1]= {1'b0,nine_buffer_in[8][3],1'b0};
       mult_out2[2][2]= {1'b0,1'b0,nine_buffer_in[8][4]};
       temp_out2 = mult_out2[0][0]+mult_out2[0][1]+mult_out2[0][2]+mult_out2[1][0]+mult_out2[1][1]+mult_out2[1][2]+mult_out2[2][0]+mult_out2[2][1]+mult_out2[2][2];
       result[2] = temp_out2[11:4];

       mult_out3[0][0]= {1'b0,1'b0,nine_buffer_in[6][3]};
       mult_out3[0][1]= {1'b0,nine_buffer_in[6][4],1'b0};
       mult_out3[0][2]= {1'b0,1'b0,nine_buffer_in[6][5]};
       mult_out3[1][0]= {1'b0,nine_buffer_in[7][3],1'b0};
       mult_out3[1][1]= {nine_buffer_in[7][4],1'b0,1'b0};
       mult_out3[1][2]= {1'b0,nine_buffer_in[7][5],1'b0};
       mult_out3[2][0]= {1'b0,1'b0,nine_buffer_in[7][3]};
       mult_out3[2][1]= {1'b0,nine_buffer_in[7][4],1'b0};
       mult_out3[2][2]= {1'b0,1'b0,nine_buffer_in[7][5]};
       temp_out3 = mult_out3[0][0]+mult_out3[0][1]+mult_out3[0][2]+mult_out3[1][0]+mult_out3[1][1]+mult_out3[1][2]+mult_out3[2][0]+mult_out3[2][1]+mult_out3[2][2];
       result[3] = temp_out3[11:4];

       mult_out4[0][0]= {1'b0,1'b0,nine_buffer_in[6][4]};
       mult_out4[0][1]= {1'b0,nine_buffer_in[6][5],1'b0};
       mult_out4[0][2]= {1'b0,1'b0,nine_buffer_in[6][6]};
       mult_out4[1][0]= {1'b0,nine_buffer_in[7][4],1'b0};
       mult_out4[1][1]= {nine_buffer_in[7][5],1'b0,1'b0};
       mult_out4[1][2]= {1'b0,nine_buffer_in[7][6],1'b0};
       mult_out4[2][0]= {1'b0,1'b0,nine_buffer_in[8][4]};
       mult_out4[2][1]= {1'b0,nine_buffer_in[8][5],1'b0};
       mult_out4[2][2]= {1'b0,1'b0,nine_buffer_in[8][6]};
       temp_out4 = mult_out4[0][0]+mult_out4[0][1]+mult_out4[0][2]+mult_out4[1][0]+mult_out4[1][1]+mult_out4[1][2]+mult_out4[2][0]+mult_out4[2][1]+mult_out4[2][2];
       result[4] = temp_out4[11:4];

       mult_out5[0][0]= {1'b0,1'b0,nine_buffer_in[6][5]};
       mult_out5[0][1]= {1'b0,nine_buffer_in[6][6],1'b0};
       mult_out5[0][2]= {1'b0,1'b0,nine_buffer_in[6][7]};
       mult_out5[1][0]= {1'b0,nine_buffer_in[7][5],1'b0};
       mult_out5[1][1]= {nine_buffer_in[7][6],1'b0,1'b0};
       mult_out5[1][2]= {1'b0,nine_buffer_in[7][7],1'b0};
       mult_out5[2][0]= {1'b0,1'b0,nine_buffer_in[8][5]};
       mult_out5[2][1]= {1'b0,nine_buffer_in[8][6],1'b0};
       mult_out5[2][2]= {1'b0,1'b0,nine_buffer_in[8][7]};
       temp_out5 = mult_out5[0][0]+mult_out5[0][1]+mult_out5[0][2]+mult_out5[1][0]+mult_out5[1][1]+mult_out5[1][2]+mult_out5[2][0]+mult_out5[2][1]+mult_out5[2][2];
       result[5] = temp_out5[11:4];

       mult_out6[0][0]= {1'b0,1'b0,nine_buffer_in[6][6]};
       mult_out6[0][1]= {1'b0,nine_buffer_in[6][7],1'b0};
       mult_out6[0][2]= {1'b0,1'b0,nine_buffer_in[6][8]};
       mult_out6[1][0]= {1'b0,nine_buffer_in[7][6],1'b0};
       mult_out6[1][1]= {nine_buffer_in[7][7],1'b0,1'b0};
       mult_out6[1][2]= {1'b0,nine_buffer_in[7][8],1'b0};
       mult_out6[2][0]= {1'b0,1'b0,nine_buffer_in[8][6]};
       mult_out6[2][1]= {1'b0,nine_buffer_in[8][7],1'b0};
       mult_out6[2][2]= {1'b0,1'b0,nine_buffer_in[8][8]};
       temp_out6 = mult_out6[0][0]+mult_out6[0][1]+mult_out6[0][2]+mult_out6[1][0]+mult_out6[1][1]+mult_out6[1][2]+mult_out6[2][0]+mult_out6[2][1]+mult_out6[2][2];
       result[6] = temp_out6[11:4];

end else begin
      mult_out0 = '{'{0,0,0},'{0,0,0},'{0,0,0}};
      temp_out0 = 0;
      result[0] = 0;

      mult_out1 = '{'{0,0,0},'{0,0,0},'{0,0,0}};
      temp_out1 = 0;
      result[1] = 0;
     
      mult_out2 = '{'{0,0,0},'{0,0,0},'{0,0,0}};
      temp_out2 = 0;
      result[2] = 0;

      mult_out3 = '{'{0,0,0},'{0,0,0},'{0,0,0}};
      temp_out3 = 0;
      result[3] = 0;

      mult_out4 = '{'{0,0,0},'{0,0,0},'{0,0,0}};
      temp_out4 = 0;
      result[4] = 0;

      mult_out5 = '{'{0,0,0},'{0,0,0},'{0,0,0}};
      temp_out5 = 0;
      result[5] = 0;

      mult_out6 = '{'{0,0,0},'{0,0,0},'{0,0,0}};
      temp_out6 = 0;
      result[6] = 0;

end
end
endmodule
