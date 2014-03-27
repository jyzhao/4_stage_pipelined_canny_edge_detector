// $Id: $
// File name:   tb_buffer5x5.sv
// Created:     11/22/2013
// Author:      Eric Nielsen
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Top-level Block

	`timescale 1 ns/1 ns
	module tb_buffer5x5 ();

   // Constant parameters
   localparam CLK_PERIOD = 10;    //100 MHZ clock

	// Test variables
 	reg tb_clk;
 	reg tb_n_rst;
 	reg [1:0] tb_shift_direction;
 	reg tb_shift_enable;
 	reg [7:0] tb_input [0:4];
 	reg [7:0] tb_output [0:4][0:4];
	reg [3:0] test_number;

   // Port map
   buffer5x5 dut
	(
   .clk(tb_clk),
   .n_rst(tb_n_rst),
   .shift_enable(tb_shift_enable),
   .shift_direction(tb_shift_direction),
   .buffer_input(tb_input),
   .buffer_output(tb_output)
	);

   // Generate tb_clk
   always begin
      tb_clk = 1'b0;
      #(CLK_PERIOD/2);
      tb_clk = 1'b1;
      #(CLK_PERIOD/2);
   end

	// Test block
	initial begin

	// Reset system
	tb_n_rst = 1'b0;
	#CLK_PERIOD;
	tb_n_rst = 1'b1;

	// Try to shift in value when enable is not active
	test_number = 4'b0001;
	tb_shift_enable = 1'b0;
	tb_input[0] = 8'b11110001;
	tb_input[1] = 8'b11110001;
	tb_input[2] = 8'b11110001;
	tb_input[3] = 8'b11110001;
	tb_input[4] = 8'b11110001;
	@(posedge tb_clk);
	#CLK_PERIOD;

	// Try to shift in value when enable is active but shift direction is 00
	test_number = 4'b0010;
	tb_shift_enable = 1'b1;
	tb_shift_direction = 2'b00;
	tb_input[0] = 8'b11110001;
	tb_input[1] = 8'b11110001;
	tb_input[2] = 8'b11110001;
	tb_input[3] = 8'b11110001;
	tb_input[4] = 8'b11110001;
	@(posedge tb_clk);
	#CLK_PERIOD;

	// Reset system
	#CLK_PERIOD;
	tb_n_rst = 1'b0;
	#CLK_PERIOD;
	tb_n_rst = 1'b1;
	#CLK_PERIOD;

	// Watch 5 columns of values be shifted in (moving right)
	test_number = 4'b0011;
	tb_shift_enable = 1'b1;
	tb_shift_direction = 2'b01;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b00000001;
	tb_input[2] = 8'b00000001;
	tb_input[3] = 8'b00000001;
	tb_input[4] = 8'b00000001;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000010;
	tb_input[1] = 8'b00000010;
	tb_input[2] = 8'b00000010;
	tb_input[3] = 8'b00000010;
	tb_input[4] = 8'b00000010;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000011;
	tb_input[1] = 8'b00000011;
	tb_input[2] = 8'b00000011;
	tb_input[3] = 8'b00000011;
	tb_input[4] = 8'b00000011;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000100;
	tb_input[1] = 8'b00000100;
	tb_input[2] = 8'b00000100;
	tb_input[3] = 8'b00000100;
	tb_input[4] = 8'b00000100;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000101;
	tb_input[1] = 8'b00000101;
	tb_input[2] = 8'b00000101;
	tb_input[3] = 8'b00000101;
	tb_input[4] = 8'b00000101;
	@(posedge tb_clk);

	// Reset system
	#CLK_PERIOD;
	tb_n_rst = 1'b0;
	#CLK_PERIOD;
	tb_n_rst = 1'b1;
	#CLK_PERIOD;

	// Watch 5 rows of values being shifted in (moving down)
	test_number = 4'b0100;
	tb_shift_enable = 1'b1;
	tb_shift_direction = 2'b11;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b00000001;
	tb_input[2] = 8'b00000001;
	tb_input[3] = 8'b00000001;
	tb_input[4] = 8'b00000001;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000010;
	tb_input[1] = 8'b00000010;
	tb_input[2] = 8'b00000010;
	tb_input[3] = 8'b00000010;
	tb_input[4] = 8'b00000010;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000011;
	tb_input[1] = 8'b00000011;
	tb_input[2] = 8'b00000011;
	tb_input[3] = 8'b00000011;
	tb_input[4] = 8'b00000011;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000100;
	tb_input[1] = 8'b00000100;
	tb_input[2] = 8'b00000100;
	tb_input[3] = 8'b00000100;
	tb_input[4] = 8'b00000100;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000101;
	tb_input[1] = 8'b00000101;
	tb_input[2] = 8'b00000101;
	tb_input[3] = 8'b00000101;
	tb_input[4] = 8'b00000101;
	@(posedge tb_clk);

	// Reset system
	#CLK_PERIOD;
	tb_n_rst = 1'b0;
	#CLK_PERIOD;
	tb_n_rst = 1'b1;
	#CLK_PERIOD;

	// Watch 5 rows of values being shifted in (moving left)
	test_number = 4'b0101;
	tb_shift_enable = 1'b1;
	tb_shift_direction = 2'b10;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b00000001;
	tb_input[2] = 8'b00000001;
	tb_input[3] = 8'b00000001;
	tb_input[4] = 8'b00000001;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000010;
	tb_input[1] = 8'b00000010;
	tb_input[2] = 8'b00000010;
	tb_input[3] = 8'b00000010;
	tb_input[4] = 8'b00000010;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000011;
	tb_input[1] = 8'b00000011;
	tb_input[2] = 8'b00000011;
	tb_input[3] = 8'b00000011;
	tb_input[4] = 8'b00000011;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000100;
	tb_input[1] = 8'b00000100;
	tb_input[2] = 8'b00000100;
	tb_input[3] = 8'b00000100;
	tb_input[4] = 8'b00000100;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000101;
	tb_input[1] = 8'b00000101;
	tb_input[2] = 8'b00000101;
	tb_input[3] = 8'b00000101;
	tb_input[4] = 8'b00000101;
	@(posedge tb_clk);

	// Reset system
	#CLK_PERIOD;
	tb_n_rst = 1'b0;
	#CLK_PERIOD;
	tb_n_rst = 1'b1;

	end

endmodule




