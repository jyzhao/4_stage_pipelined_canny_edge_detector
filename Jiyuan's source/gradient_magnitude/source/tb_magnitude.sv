module tb_magnitude
();
  
  reg [7:0] tb_gx;
  reg [7:0] tb_gy;
  reg [7:0] tb_gmag;
  
  magnitude
  DUT
  (
  .gx(tb_gx),
  .gy(tb_gy),
  .gmag(tb_gmag)
  );
  
  initial begin
  //testcase 1
  tb_gx = 0;
  tb_gy = 0;
  
  #100ns
  
  //testcase 2
  tb_gx = 192;
  tb_gy = 192;
  
  #100ns
  
  //testcase 3
  tb_gx = 1;
  tb_gy = 1;
  
  #100ns
  
  //testcase 4
  tb_gx = 191;
  tb_gy = 191;
  
  #100ns
  
  //testcase 5
  tb_gx = 95;
  tb_gy = 95;
  
  end
  
endmodule
  
  
  
  
