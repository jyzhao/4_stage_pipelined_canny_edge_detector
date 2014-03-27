// $Id: $
// File name:   nine_buffer.sv
// Created:     11/20/2013
// Author:      Oluwatosin Adeosun
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: 9X9 input buffer

module nine_buffer
(
   input wire clk,
   input wire n_rst,
   input wire nineXnine_enable,
   input wire [1:0] gauss_shift,
   input wire [7:0] sram_inA, sram_inB, sram_inC, sram_inD, sram_inE, sram_inF, sram_inG, sram_inH, sram_inI,
   output wire [7:0] nine_buffer_output [0:8][0:8] 
);

  reg [7:0] q [0:8][0:8];
  reg [7:0] d [0:8][0:8];
  reg [7:0] inputs_A;
  reg [7:0] inputs_B;
  reg [7:0] inputs_C;
  reg [7:0] inputs_D;
  reg [7:0] inputs_E;
  reg [7:0] inputs_F;
  reg [7:0] inputs_G;
  reg [7:0] inputs_H;
  reg [7:0] inputs_I;
  
 
  
assign nine_buffer_output = q;
assign inputs_A = sram_inA;
assign inputs_B = sram_inB;
assign inputs_C = sram_inC;
assign inputs_D = sram_inD;
assign inputs_E = sram_inE;
assign inputs_F = sram_inF;
assign inputs_G = sram_inG;
assign inputs_H = sram_inH;
assign inputs_I = sram_inI;


always @ (posedge clk,negedge n_rst) begin
    if (n_rst == 0) begin
        q <= '{'{0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0},'{0,0,0,0,0,0,0,0,0}};
    end else begin
          q <= d;
    end
end

always @* begin
     if (nineXnine_enable == 1) begin
        if (gauss_shift == 2'b00) begin
              d = q;
        end else if (gauss_shift == 2'b01) begin
              //for (i=0; i<9; i=i+1) begin
                 // for(j=0; j<9; j=j+1) begin
                  //  if (j != 8) begin
                 //      d[i][j] = q[i][j+1];
                 //   end else begin
                  //     d[i][j] = inputs[i];
                 //   end
               //   end
          //    end
               d = '{'{q[0][1],q[0][2],q[0][3],q[0][4],q[0][5],q[0][6],q[0][7],q[0][8],inputs_A},
                     '{q[1][1],q[1][2],q[1][3],q[1][4],q[1][5],q[1][6],q[1][7],q[1][8],inputs_B},
                     '{q[2][1],q[2][2],q[2][3],q[2][4],q[2][5],q[2][6],q[2][7],q[2][8],inputs_C},
                     '{q[3][1],q[3][2],q[3][3],q[3][4],q[3][5],q[3][6],q[3][7],q[3][8],inputs_D},
                     '{q[4][1],q[4][2],q[4][3],q[4][4],q[4][5],q[4][6],q[4][7],q[4][8],inputs_E},
                     '{q[5][1],q[5][2],q[5][3],q[5][4],q[5][5],q[5][6],q[5][7],q[5][8],inputs_F},
                     '{q[6][1],q[6][2],q[6][3],q[6][4],q[6][5],q[6][6],q[6][7],q[6][8],inputs_G},
                     '{q[7][1],q[7][2],q[7][3],q[7][4],q[7][5],q[7][6],q[7][7],q[7][8],inputs_H},
                     '{q[8][1],q[8][2],q[8][3],q[8][4],q[8][5],q[8][6],q[8][7],q[8][8],inputs_I}};      
       end else if (gauss_shift == 2'b10) begin
               d = '{'{inputs_A,q[0][0],q[0][1],q[0][2],q[0][3],q[0][4],q[0][5],q[0][6],q[0][7]},
                     '{inputs_B,q[1][0],q[1][1],q[1][2],q[1][3],q[1][4],q[1][5],q[1][6],q[1][7]},
                     '{inputs_C,q[2][0],q[2][1],q[2][2],q[2][3],q[2][4],q[2][5],q[2][6],q[2][7]},
                     '{inputs_D,q[3][0],q[3][1],q[3][2],q[3][3],q[3][4],q[3][5],q[3][6],q[3][7]},
                     '{inputs_E,q[4][0],q[4][1],q[4][2],q[4][3],q[4][4],q[4][5],q[4][6],q[4][7]},
                     '{inputs_F,q[5][0],q[5][1],q[5][2],q[5][3],q[5][4],q[5][5],q[5][6],q[5][7]},
                     '{inputs_G,q[6][0],q[6][1],q[6][2],q[6][3],q[6][4],q[6][5],q[6][6],q[6][7]},
                     '{inputs_H,q[7][0],q[7][1],q[7][2],q[7][3],q[7][4],q[7][5],q[7][6],q[7][7]},
                     '{inputs_I,q[8][0],q[8][1],q[8][2],q[8][3],q[8][4],q[8][5],q[8][6],q[8][7]}};    
       end else begin
               d = '{'{q[1][0],q[1][1],q[1][2],q[1][3],q[1][4],q[1][5],q[1][6],q[1][7],q[1][8]},
                     '{q[2][0],q[2][1],q[2][2],q[2][3],q[2][4],q[2][5],q[2][6],q[2][7],q[2][8]},
                     '{q[3][0],q[3][1],q[3][2],q[3][3],q[3][4],q[3][5],q[3][6],q[3][7],q[3][8]},
                     '{q[4][0],q[4][1],q[4][2],q[4][3],q[4][4],q[4][5],q[4][6],q[4][7],q[4][8]},
                     '{q[5][0],q[5][1],q[5][2],q[5][3],q[5][4],q[5][5],q[5][6],q[5][7],q[5][8]},
                     '{q[6][0],q[6][1],q[6][2],q[6][3],q[6][4],q[6][5],q[6][6],q[6][7],q[6][8]},
                     '{q[7][0],q[7][1],q[7][2],q[7][3],q[7][4],q[7][5],q[7][6],q[7][7],q[7][8]},
                     '{q[8][0],q[8][1],q[8][2],q[8][3],q[8][4],q[8][5],q[8][6],q[8][7],q[8][8]},
                     '{inputs_A,inputs_B,inputs_C,inputs_D,inputs_E,inputs_F,inputs_G,inputs_H,inputs_I}};     
       end
   end else begin
       d = q;
   end
end
endmodule

