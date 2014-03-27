`timescale 1 ns/1 ns
module tb_gauss_block
();

  wire test_rst;
  wire test_clk;
  wire test_enable;
  wire [1:0] test_shift;
  wire [7:0] test_in [0:8];
  wire [7:0] test_outs [0:6];
  //wire [71:0] test_in;
  //wire [647:0]test_outs;

`define NUM_TEST_CASES 60

  reg [5:0] test_number;
  reg tmp_rst;
  reg tmp_clk;
  reg tmp_enable;
  reg [1:0] tmp_shift;
  reg [7:0] tmp_in [0:8];

   gauss_block DUT(.clk(test_clk), .n_rst(test_rst), .nineXnine_enable(test_enable), .gauss_shift(test_shift), .sram_in(test_in), .gauss_out(test_outs));
   

  assign test_shift = tmp_shift;
  assign test_clk = tmp_clk;
  assign test_rst = tmp_rst;
  assign test_enable = tmp_enable;
 // assign test_in = {tmp_in[8],tmp_in[7],tmp_in[6],tmp_in[5],tmp_in[4],tmp_in[3],tmp_in[2],tmp_in[1],tmp_in[0]};
  assign test_in = tmp_in;

always begin
 	tmp_clk <= 0;
 	#5ns;
 	tmp_clk <= 1;
  #5ns;
  end
  

initial
	begin
	  #5ns
		for(test_number = 0; test_number < `NUM_TEST_CASES; test_number = test_number + 1)
		begin
			if(test_number == 0 | test_number == 58)begin
			tmp_rst = 0;
			end else begin
      tmp_rst = 1;
      end
     
      if(test_number < 2)begin
         tmp_shift = 2'b00;
         tmp_enable = 0;
      end else if(test_number >2 && test_number < 23)begin
         tmp_shift = 2'b01;
         tmp_enable = 1;
      end else if(test_number == 23)begin
          tmp_shift = 2'b00;
          tmp_enable = 0;
      end else if(test_number == 24)begin
          tmp_shift = 2'b11;
          tmp_enable = 1;
      end else if(test_number >24 && test_number < 45)begin
          tmp_shift = 2'b10;
          tmp_enable = 1;
      end else if(test_number == 45)begin
           tmp_shift = 2'b00;
           tmp_enable = 0;
      end else if(test_number == 46)begin
          tmp_shift = 2'b11;
          tmp_enable = 1;
      end else if(test_number >46 && test_number < 51)begin
          tmp_shift = 2'b01;
          tmp_enable = 0;
      end else begin
          tmp_shift = 2'b01;
          tmp_enable = 1;
      end
      
     tmp_in[0] = test_number;
     tmp_in[1] = test_number+2;
     tmp_in[2] = test_number+4;
     tmp_in[3] = test_number+6;
     tmp_in[4] = test_number+8;
     tmp_in[5] = test_number+10;
     tmp_in[6] = test_number+12;
     tmp_in[7] = test_number+14;
     tmp_in[8] = test_number+16;
     #10ns;
end
end

endmodule
      
