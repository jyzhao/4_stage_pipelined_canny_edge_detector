// $Id: $
// File name:   tb_project_test.sv
// Created:     11/22/2013
// Author:      Eric Nielsen
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Top-level Block

	`timescale 1 ns/1 ns
	module tb_project_test ();

   // Constant parameters
   localparam CLK_PERIOD = 10;    //100 MHZ clock

	// Test variables
 	reg tb_clk;
 	reg tb_n_rst;
 	reg [1:0] tb_shift_direction;
 	reg tb_shift_enable;
   reg [7:0] tb_input [0:2];
 	reg [7:0] tb_thresh_h = 8'b11110000;
	reg [7:0] tb_thresh_l = 8'b00001111;
	reg hysteresis_enable;
	reg tb_hysteresis_out;
	reg [3:0] test_number;
	reg expected_out;

   // Port map
   project_test dut
	(
   .clk(tb_clk),
   .n_rst(tb_n_rst),
	.shift_direction(tb_shift_direction),
	.shift_enable(tb_shift_enable),	
   .buffer_input(tb_input),
	.thresh_h(tb_thresh_h),
	.thresh_l(tb_thresh_l),
	.hysteresis_enable(hysteresis_enable),
   .hysteresis_out(tb_hysteresis_out)
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
	@(posedge tb_clk);
	#CLK_PERIOD;

	// Try to shift in value when enable is active but shift direction is 00
	test_number = 4'b0010;
	tb_shift_enable = 1'b1;
	tb_shift_direction = 2'b00;
	tb_input[0] = 8'b11110001;
	tb_input[1] = 8'b11110001;
	tb_input[2] = 8'b11110001;
	@(posedge tb_clk);
	#CLK_PERIOD;

	// Reset system
	#CLK_PERIOD;
	tb_n_rst = 1'b0;
	#CLK_PERIOD;
	tb_n_rst = 1'b1;
	hysteresis_enable = 1'b0;
	#CLK_PERIOD

	// Watch 3 columns of values be shifted in (moving right)
	test_number = 4'b0011;
	tb_shift_enable = 1'b1;
	tb_shift_direction = 2'b01;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b00000001;
	tb_input[2] = 8'b00000001;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000010;
	tb_input[1] = 8'b00000010;
	tb_input[2] = 8'b00000010;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000011;
	tb_input[1] = 8'b00000011;
	tb_input[2] = 8'b00000011;
	@(posedge tb_clk);
	hysteresis_enable = 1'b1;

	// Reset system
	#CLK_PERIOD;
	tb_n_rst = 1'b0;
	#CLK_PERIOD;
	tb_n_rst = 1'b1;
	hysteresis_enable = 1'b0;
	#CLK_PERIOD

	// Watch 3 rows of values being shifted in (moving down)
	test_number = 4'b0100;
	tb_shift_enable = 1'b1;
	tb_shift_direction = 2'b11;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b00000001;
	tb_input[2] = 8'b00000001;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000010;
	tb_input[1] = 8'b00000010;
	tb_input[2] = 8'b00000010;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000011;
	tb_input[1] = 8'b00000011;
	tb_input[2] = 8'b00000011;
	@(posedge tb_clk);
	hysteresis_enable = 1'b1;

	// Reset system
	#CLK_PERIOD;
	tb_n_rst = 1'b0;
	#CLK_PERIOD;
	tb_n_rst = 1'b1;
	hysteresis_enable = 1'b0;
	#CLK_PERIOD;

	// Watch 3 rows of values being shifted in (moving left)
	test_number = 4'b0101;
	tb_shift_enable = 1'b1;
	tb_shift_direction = 2'b10;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b00000001;
	tb_input[2] = 8'b00000001;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000010;
	tb_input[1] = 8'b00000010;
	tb_input[2] = 8'b00000010;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000011;
	tb_input[1] = 8'b00000011;
	tb_input[2] = 8'b00000011;
	@(posedge tb_clk);
	hysteresis_enable = 1'b1;

	// Reset system
	#CLK_PERIOD;
	tb_n_rst = 1'b0;
	#CLK_PERIOD;
	tb_n_rst = 1'b1;
	hysteresis_enable = 1'b0;
	#CLK_PERIOD;

	// Shift right, middle pixel < thresh_l, check hysteresis_out value
	test_number = 4'b0110;
	tb_shift_enable = 1'b1;
	tb_shift_direction = 2'b01;
	@(posedge tb_clk);
	tb_input[0] = 8'b11110001;
	tb_input[1] = 8'b11110001;
	tb_input[2] = 8'b11110001;
	@(posedge tb_clk);
	tb_input[0] = 8'b11110010;
	tb_input[1] = 8'b00000001;
	tb_input[2] = 8'b11110010;
	@(posedge tb_clk);
	tb_input[0] = 8'b11110011;
	tb_input[1] = 8'b11110011;
	tb_input[2] = 8'b11110011;
	@(posedge tb_clk);
	hysteresis_enable = 1'b1;
	expected_out = 1'b0;
	#(CLK_PERIOD/2);
   if (tb_hysteresis_out == expected_out) begin
		$display("Test case 1.1 passed!");
   end else begin
	 	$error("Test case 1.1 failed!");
   end

	// Shift right, middle pixel > thresh_h, check hysteresis_out value
	test_number = 4'b0111;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b00000001;
	tb_input[2] = 8'b00000001;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b11110010;
	tb_input[2] = 8'b00000001;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b00000001;
	tb_input[2] = 8'b00000001;
	@(posedge tb_clk);
	hysteresis_enable = 1'b1;
	expected_out = 1'b1;
	#(CLK_PERIOD/2);
   if (tb_hysteresis_out == expected_out) begin
		$display("Test case 1.2 passed!");
   end else begin
	 	$error("Test case 1.2 failed!");
   end

	// Shift right, thresh_h > middle pixel > thresh_l, other pixel is > thresh_h check hysteresis_out value
	test_number = 4'b1000;
	@(posedge tb_clk);
	tb_input[0] = 8'b11110001;
	tb_input[1] = 8'b00000001;
	tb_input[2] = 8'b00000001;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b00011111;
	tb_input[2] = 8'b00000001;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b00000001;
	tb_input[2] = 8'b00000001;
	@(posedge tb_clk);
	hysteresis_enable = 1'b1;
	expected_out = 1'b1;
	#(CLK_PERIOD/2);
   if (tb_hysteresis_out == expected_out) begin
		$display("Test case 1.3 passed!");
   end else begin
	 	$error("Test case 1.3 failed!");
   end

	// Shift right, thresh_h > middle pixel > thresh_l, no other pixel is > thresh_h check hysteresis_out value
	test_number = 4'b1001;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b00000001;
	tb_input[2] = 8'b00000001;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b00011111;
	tb_input[2] = 8'b00000001;
	@(posedge tb_clk);
	tb_input[0] = 8'b00000001;
	tb_input[1] = 8'b00000001;
	tb_input[2] = 8'b00000001;
	@(posedge tb_clk);
	hysteresis_enable = 1'b1;
	expected_out = 1'b0;
	#(CLK_PERIOD/2);
   if (tb_hysteresis_out == expected_out) begin
		$display("Test case 1.4 passed!");
   end else begin
	 	$error("Test case 1.4 failed!");
   end

	end

endmodule




