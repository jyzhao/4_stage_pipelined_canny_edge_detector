
module sensor_b ( sensors, error );
  input [3:0] sensors;
  output error;
  wire   N0, n3, n4, n5;
  assign error = N0;

  NAND2X1 U4 ( .A(sensors[1]), .B(sensors[3]), .Y(n5) );
  NAND2X1 U5 ( .A(sensors[2]), .B(sensors[1]), .Y(n4) );
  INVX2 U6 ( .A(sensors[0]), .Y(n3) );
  NAND3X1 U7 ( .A(n3), .B(n4), .C(n5), .Y(N0) );
endmodule

