module tb_gradient_magnitude_wrapper
();
  
  reg [7:0] tb_p2;
  reg [7:0] tb_p5;
  reg [7:0] tb_p8;
  reg [7:0] tb_p4;
  reg [7:0] tb_p6;
  reg [7:0] tb_gx;
  reg [7:0] tb_gy;
  reg [7:0] tb_gmag;
  
  gradient_magnitude_wrapper
  DUT
  (
  .wrapper_p2(tb_p2),
  .wrapper_p5(tb_p5),
  .wrapper_p8(tb_p8),
  .wrapper_p4(tb_p4),
  .wrapper_p6(tb_p6),
  .wrapper_gx(tb_gx),
  .wrapper_gy(tb_gy),
  .wrapper_gmag(tb_gmag)
  );
  
  initial begin
  //testcase 1
  tb_p2 = 0;
  tb_p5 = 0;
  tb_p8 = 0;
  tb_p4 = 0;
  tb_p6 = 0;
  
  #50ns
  
  //testcase 2
  tb_p2 = 255;
  tb_p5 = 255;
  tb_p8 = 255;
  tb_p4 = 255;
  tb_p6 = 255;
  
  #50ns
  
  //testcase 3
  tb_p2 = 1;
  tb_p5 = 1;
  tb_p8 = 1;
  tb_p4 = 1;
  tb_p6 = 1;
  
  #50ns
  
  //testcase 4
  tb_p2 = 254;
  tb_p5 = 254;
  tb_p8 = 254;
  tb_p4 = 254;
  tb_p6 = 254;
  
  #50ns
  
  //testcase 5
  tb_p2 = 128;
  tb_p5 = 128;
  tb_p8 = 128;
  tb_p4 = 128;
  tb_p6 = 128;
  
  

  end
  
endmodule
  
  
  
  
