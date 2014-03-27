// $Id: $
// File name:   gauss_block
// Created:     11/23/2013
// Author:      Oluwatosin Adeosun
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Gaussian Block.
module gauss_block
(
   input wire clk,
   input wire n_rst,
   input wire nineXnine_enable,
   input wire [1:0] gauss_shift,
   input wire [7:0] sram_inA, sram_inB, sram_inC, sram_inD, sram_inE, sram_inF, sram_inG, sram_inH, sram_inI,
   output wire [7:0] gauss_out [0:6],
   output wire [7:0] temp_out [0:8][0:8]
);

  reg [7:0] buffer_out [0:8][0:8];
  assign temp_out = buffer_out;

nine_buffer COREA(
    .clk(clk),
    .n_rst(n_rst),
    .nineXnine_enable(nineXnine_enable),
    .gauss_shift(gauss_shift),
    .sram_inA(sram_inA),
    .sram_inB(sram_inB),
    .sram_inC(sram_inC),
    .sram_inD(sram_inD),
    .sram_inE(sram_inE),
    .sram_inF(sram_inF),
    .sram_inG(sram_inG),
    .sram_inH(sram_inH),
    .sram_inI(sram_inI),
    .nine_buffer_output(buffer_out)
);

multiplier COREB(
    .gauss_shift(gauss_shift),
    .nine_buffer_in(buffer_out),
    .gauss_out(gauss_out)
);

  reg [7:0] fill1_out [0:6];

  reg [7:0] fill2_out [0:6];

multiplier fill1(
    .gauss_shift(gauss_shift),
    .nine_buffer_in(buffer_out),
    .gauss_out(fill1_out)
);

multiplier fill2(
    .gauss_shift(gauss_shift),
    .nine_buffer_in(buffer_out),
    .gauss_out(fill2_out)
);

endmodule
