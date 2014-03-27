`timescale 10ns / 10ns
module tb_non_maximal_suppression
();
	/*reg [7:0] test_Gx_a;
	reg [7:0] test_Gx_b;
	reg [7:0] test_Gx_c;
	reg [7:0] test_Gy_a;
	reg [7:0] test_Gy_b;
	reg [7:0] test_Gy_c;*/
	
	
	reg [7:0] test_Gx_buffer[0:4][0:4];
	reg [7:0] test_Gy_buffer[0:4][0:4];
	reg [7:0] test_five_buffer_in[0:4][0:4];
	reg [1:0] test_shift_dir;
	reg [7:0] test_non_max [0:2];

       /* reg [7:0] tmp_Gx_a;
	reg [7:0] tmp_Gx_b;
	reg [7:0] tmp_Gx_c;
        reg [7:0] tmp_Gy_a;
        reg [7:0] tmp_Gy_b;
        reg [7:0] tmp_Gy_c; */

	reg [1:0] tmp_shift_dir;
	reg [7:0] tmp_Gx_buffer[0:4][0:4];
	reg [7:0] tmp_Gy_buffer[0:4][0:4];
	reg [7:0] tmp_five_buffer_in[0:4][0:4];

      //  reg tmp_tangent;
   

        reg [7:0] expectedOutput [0:2];
   
	non_maximal_suppression DUT(.five_buffer_in(test_five_buffer_in),.Gx_buffer(test_Gx_buffer),.Gy_buffer(test_Gy_buffer),.shift_dir(test_shift_dir),.non_max(test_non_max));

      /*  assign test_Gx_a = tmp_Gx_a;
        assign test_Gx_b = tmp_Gx_b;
        assign test_Gx_c = tmp_Gx_c;
        assign test_Gy_a = tmp_Gy_a;
        assign test_Gy_b = tmp_Gy_b;
        assign test_Gy_c = tmp_Gy_c; */

	assign test_Gx_buffer = tmp_Gx_buffer;
	assign test_Gy_buffer = tmp_Gy_buffer;
	assign test_shift_dir = tmp_shift_dir;
	assign test_five_buffer_in = tmp_five_buffer_in;
	
       // assign test_tangent = tmp_tangent;
	  
	initial begin
	   tmp_five_buffer_in[0][0] = 8'b00000000;
	   tmp_five_buffer_in[0][1] = 8'b00000000;
	   tmp_five_buffer_in[0][2] = 8'b00000000;
	   tmp_five_buffer_in[0][3] = 8'b00010100;
	   tmp_five_buffer_in[0][4] = 8'b00000010;

	   tmp_five_buffer_in[1][0] = 8'b00000000;
	   tmp_five_buffer_in[1][1] = 8'b00000000;
	   tmp_five_buffer_in[1][2] = 8'b00000000;
	   tmp_five_buffer_in[1][3] = 8'b01101110;
	   tmp_five_buffer_in[1][4] = 8'b00000000;

	   tmp_five_buffer_in[2][0] = 8'b00000000;
	   tmp_five_buffer_in[2][1] = 8'b00011110;
	   tmp_five_buffer_in[2][2] = 8'b01011010;
	   tmp_five_buffer_in[2][3] = 8'b01011001;
	   tmp_five_buffer_in[2][4] = 8'b00000000;

	   tmp_five_buffer_in[3][0] = 8'b00000000;
	   tmp_five_buffer_in[3][1] = 8'b00110000;
	   tmp_five_buffer_in[3][2] = 8'b01000110;
	   tmp_five_buffer_in[3][3] = 8'b00001011;
	   tmp_five_buffer_in[3][4] = 8'b00000110;

	   tmp_five_buffer_in[4][0] = 8'b00100010;
	   tmp_five_buffer_in[4][1] = 8'b00011001;
	   tmp_five_buffer_in[4][2] = 8'b00010011;
	   tmp_five_buffer_in[4][3] = 8'b00000111;
	   tmp_five_buffer_in[4][4] = 8'b00000000;

	   tmp_Gx_buffer[1][3] = 8'b11001000;
	   tmp_Gx_buffer[2][3] = 8'b11111101;
	   tmp_Gx_buffer[3][3] = 8'b11001000;
	   tmp_Gy_buffer[1][3] = 8'b01000100;
	   tmp_Gy_buffer[2][3] = 8'b11111101;
	   tmp_Gy_buffer[3][3] = 8'b11001000;

	   tmp_Gx_buffer[1][1] = 8'b11001000;
	   tmp_Gx_buffer[2][1] = 8'b11111101;
	   tmp_Gx_buffer[3][1] = 8'b00110010;
	   tmp_Gy_buffer[1][1] = 8'b01000100;
	   tmp_Gy_buffer[2][1] = 8'b11111101;
	   tmp_Gy_buffer[3][1] = 8'b11001000;

	   tmp_Gx_buffer[3][1] = 8'b00110010;
	   tmp_Gx_buffer[3][2] = 8'b00110010;
	   tmp_Gx_buffer[3][3] = 8'b11001000;
	   tmp_Gy_buffer[3][1] = 8'b11001000;
	   tmp_Gy_buffer[3][2] = 8'b11001000;
	   tmp_Gy_buffer[3][3] = 8'b11001000;

	   tmp_shift_dir = 2'b00;
	

	//Test Case 1 ~ 3 : Left ---------------------------------------------

/*	//Test Case #1
	   tmp_shift_dir = 2'b01; //Right
	 //  tmp_Gy_a = 8'b01000100; //68
	 //  tmp_Gx_a = 8'b11001000; //200
	   // Degrees : 0 & 180
	   #10; 
	   expectedOutput[0] = 8'b01101110; //110
	   
	   if(expectedOutput[0] == test_non_max[0]) 
           begin
	      $display("Test case1 passed!");
	   end
	   else begin
	      $display("Test case1 failed!");
	   end
    
       //Test Case #2
	   tmp_shift_dir = 2'b01; //Left
	//   tmp_Gy_b = 8'b11111101; //253
	//   tmp_Gx_b = 8'b11111101; //253
	   // Degrees : 45 & 225
	   #10; 
	   expectedOutput[1] = 8'b01011001; //89
	   
	   if(expectedOutput[1] == test_non_max[1]) 
           begin
	      $display("Test case2 passed!");
	   end
	   else begin
	      $display("Tes case2 failed!");
	   end

	//Test Case #3
	   tmp_shift_dir = 2'b01;
	//   tmp_Gy_c = 8'b11001000; //200
	//   tmp_Gx_c = 8'b11001000; //200
	   // Degrees : 45 & 225
	   #10; 
	   expectedOutput[2] = 8'b00000000; //0
	   
	   if(expectedOutput[2] == test_non_max[2]) 
           begin
	      $display("Test case3 passed!");
	   end
	   else begin
	      $display("Tes case3 failed!");
	   end	   


  	//Test Case 4 ~ 6 : RIGHT ---------------------------------------------
	//Test Case #4
	   tmp_shift_dir = 2'b10; //Left
	//   tmp_Gy_a = 8'b01000100; //68
	//   tmp_Gx_a = 8'b11001000; //200
	   // Degrees : 0 & 180
	   #10; 
	   expectedOutput[0] = 8'b00000000; //0
	   
	   if(expectedOutput[0] == test_non_max[0]) 
           begin
	      $display("Test case4 passed!");
	   end
	   else begin
	      $display("Test case4 failed!");
	   end
    
       //Test Case #5
	   tmp_shift_dir = 2'b10; //Left
	//   tmp_Gy_b = 8'b11111101; //253
	//   tmp_Gx_b = 8'b11111101; //253
	   // Degrees : 45 & 225
	   #10; 
	   expectedOutput[1] = 8'b00011110; //89
	   
	   if(expectedOutput[1] == test_non_max[1]) 
           begin
	      $display("Test case5 passed!");
	   end
	   else begin
	      $display("Test case5 failed!");
	   end

	//Test Case #6
	   tmp_shift_dir = 2'b10;
	//   tmp_Gy_c = 8'b11001000; //200
	//   tmp_Gx_c = 8'b00110010; //50
	   // Degrees : 90
	   #10; 
	   expectedOutput[2] = 8'b00110000; //48
	   
	   if(expectedOutput[2] == test_non_max[2]) 
           begin
	      $display("Test case6 passed!");
	   end
	   else begin
	      $display("Test case6 failed!");
	   end
*/
	//Test Case 7 ~ 9 : DOWN ---------------------------------------------
	//Test Case #7
	   tmp_shift_dir = 2'b11; //Down
	//   tmp_Gy_a = 8'b11001000; //200
	//   tmp_Gx_a = 8'b00110010; //50
	   // Degrees : 90 & 270
	   #10; 
	   expectedOutput[0] = 8'b00110000; //48
	   
	   if(expectedOutput[0] == test_non_max[0]) 
           begin
	      $display("Test case7 passed!");
	   end
	   else begin
	      $display("Test case7 failed!");
	   end
    
       //Test Case #8
	   tmp_shift_dir = 2'b11; //Down
	//   tmp_Gy_b = 8'b11001000; //200
	//   tmp_Gx_b = 8'b00110010; //50
	   // Degrees : 90 & 279
	   #10; 
	   expectedOutput[1] = 8'b00000000; //70
	   
	   if(expectedOutput[1] == test_non_max[1]) 
           begin
	      $display("Test case8 passed!");
	   end
	   else begin
	      $display("Test case8 failed!");
	   end

	//Test Case #9
	   tmp_shift_dir = 2'b11; //Down
	//   tmp_Gy_c = 8'b11001000; //same
	//   tmp_Gx_c = 8'b11001000; //same
	   // Degrees : 45 & 225
	   #10; 
	   expectedOutput[2] = 8'b00000000; //0
	   
	   if(expectedOutput[2] == test_non_max[2]) 
           begin
	      $display("Test case9 passed!");
	   end
	   else begin
	      $display("Test case9 failed!");
	   end
	
	end
endmodule
