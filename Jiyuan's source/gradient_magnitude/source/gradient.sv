module gradient
  (
  input wire [7:0] p2, // pixel 2, 8 bits
  input wire [7:0] p5, // pixel 5, 8 bits
  input wire [7:0] p8, // pixel 8, 8 bits
  input wire [7:0] p4, // pixel 4, 8 bits
  input wire [7:0] p6, // pixel 6, 8 bits
  output reg [7:0] gx, // gradient x, 8 bits
  output reg [7:0] gy  // gradient y, 8 bits
  );
  
  assign gx = ((p2/2) + (p5/2) + (p8/2)) / 2;
  /*
  Convolution Kernel for x
  0 0.5 0
  0 0.5 0
  0 0.5 0
  
  Therefore, only p2, p5 and p8 is used in the calculation.
  */
  
  
  assign gy = ((p4/2) + (p5/2) + (p6/2)) / 2;
  /*
  Convolution Kernel for y
    0   0   0
  0.5 0.5 0.5
    0   0   0
  Therefore, only p4, p5 and p6 is used in the calculation.
  */
  
endmodule