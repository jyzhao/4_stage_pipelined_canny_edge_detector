
module stp_sr ( clk, n_rst, shift_enable, serial_in, parallel_out );
  output [3:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n8, n10, n12, n14, n15, n16, n17, n18;

  DFFSR \parallel_out_reg[0]  ( .D(n14), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  DFFSR \parallel_out_reg[1]  ( .D(n12), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \parallel_out_reg[2]  ( .D(n10), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \parallel_out_reg[3]  ( .D(n8), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  INVX1 U16 ( .A(n15), .Y(n8) );
  MUX2X1 U17 ( .B(parallel_out[3]), .A(parallel_out[2]), .S(shift_enable), .Y(
        n15) );
  INVX1 U18 ( .A(n16), .Y(n14) );
  MUX2X1 U19 ( .B(parallel_out[0]), .A(serial_in), .S(shift_enable), .Y(n16)
         );
  INVX1 U20 ( .A(n17), .Y(n12) );
  MUX2X1 U21 ( .B(parallel_out[1]), .A(parallel_out[0]), .S(shift_enable), .Y(
        n17) );
  INVX1 U22 ( .A(n18), .Y(n10) );
  MUX2X1 U23 ( .B(parallel_out[2]), .A(parallel_out[1]), .S(shift_enable), .Y(
        n18) );
endmodule

