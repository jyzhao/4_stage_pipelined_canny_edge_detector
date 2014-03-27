// $Id: $
// File name:   tb_main_controller.sv
// Created:     11/29/2013
// Author:      Eric Nielsen
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Main Controller Block

	`timescale 1 ns/1 ns
	module tb_main_controller ();

   // Constant parameters
   localparam CLK_PERIOD = 10;    //100 MHZ clock

	// Test variables
	reg tb_clk = 1'b0;
 	reg tb_n_rst = 1'b0;
	reg tb_start = 1'b0;
	reg tb_gaussian_fill_done = 1'b0;
	reg tb_gradient_fill_done = 1'b0;
	reg tb_suppression_fill_done = 1'b0;
	reg tb_hysteresis_fill_done = 1'b0;
	reg tb_readx_up_max = 1'b0;
	reg tb_readx_down_min = 1'b0;
	reg tb_ready_max = 1'b0;

	reg tb_enable9x9;
	reg tb_enable7x7;
	reg tb_enable5x5;
	reg tb_enable3x3;
	reg [1:0] tb_gaussian_buffer;
	reg [1:0] tb_gradient_buffer;
	reg [1:0] tb_suppression_buffer;
	reg [1:0] tb_hysteresis_buffer;
	reg tb_write_enable;

	reg exp_enable9x9;
	reg exp_enable7x7;
	reg exp_enable5x5;
	reg exp_enable3x3;
	reg [1:0] exp_gaussian_buffer;
	reg [1:0] exp_gradient_buffer;
	reg [1:0] exp_suppression_buffer;
	reg [1:0] exp_hysteresis_buffer;
	reg exp_write_enable;

	reg [4:0] exp_state = 4'b0000;
	wire [8:0] tb_exp_out;
	wire [8:0] tb_out;
	
	assign tb_exp_out = {exp_enable9x9, exp_enable7x7, exp_enable5x5, exp_enable3x3, exp_gaussian_buffer,
								exp_gradient_buffer, exp_suppression_buffer, exp_hysteresis_buffer, exp_write_enable};
   assign tb_out = {tb_enable9x9, tb_enable7x7, tb_enable5x5, tb_enable3x3, tb_gaussian_buffer,
								tb_gradient_buffer, tb_suppression_buffer, tb_hysteresis_buffer, tb_write_enable};

   // Port map
   main_controller dut
	(
	.clk(tb_clk),
	.n_rst(tb_n_rst),
	.start(tb_start),
	.gaussian_fill_done(tb_gaussian_fill_done),
	.gradient_fill_done(tb_gradient_fill_done),
	.suppression_fill_done(tb_suppression_fill_done),
	.hysteresis_fill_done(tb_hysteresis_fill_done),
	.readx_up_max(tb_readx_up_max),
	.readx_down_min(tb_readx_down_min),
	.ready_max(tb_ready_max),
	.enable9x9(tb_enable9x9),
	.enable7x7(tb_enable7x7),
	.enable5x5(tb_enable5x5),
	.enable3x3(tb_enable3x3),
	.gaussian_buffer(tb_gaussian_buffer),
	.gradient_buffer(tb_gradient_buffer),
	.suppression_buffer(tb_suppression_buffer),
	.hysteresis_buffer(tb_hysteresis_buffer),
	.write_enable(tb_write_enable)
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

	exp_enable9x9 = 1'b0;
	exp_enable7x7 = 1'b0;
	exp_enable5x5 = 1'b0;
	exp_enable3x3 = 1'b0;
	exp_gaussian_buffer = 2'b00;
	exp_gradient_buffer = 2'b00;
	exp_suppression_buffer = 2'b00;
	exp_hysteresis_buffer = 2'b00;
	exp_write_enable = 1'b0;

	// Reset system
	tb_n_rst = 1'b0;
	#CLK_PERIOD;
	#CLK_PERIOD;
	#CLK_PERIOD;
	tb_n_rst = 1'b1;
	#CLK_PERIOD;

	
	// idle
	exp_state = 0;
   if (tb_exp_out == tb_out) begin
		$display("Test case 1 passed!");
   end else begin
	 	$error("Test case 1 failed!");
   end

	// prep_stage
	tb_start = 1'b1;
	@(posedge tb_clk);
	exp_state = 1;
   if (tb_exp_out == tb_out) begin
		$display("Test case 2 passed!");
   end else begin
	 	$error("Test case 2 failed!");
   end

	// gauss_fill
	tb_start = 1'b0;
	@(posedge tb_clk);
	exp_state = 2;
	exp_enable9x9 = 1'b1;
	exp_gaussian_buffer = 2'b01;
   if (tb_exp_out == tb_out) begin
		$display("Test case 3 passed!");
   end else begin
	 	$error("Test case 3 failed!");
   end

	// grad_fill
	tb_gaussian_fill_done = 1'b1;
	@(posedge tb_clk);
	exp_state = 3;
	exp_enable7x7 = 1'b1;
	exp_gradient_buffer = 2'b01;
   if (tb_exp_out == tb_out) begin
		$display("Test case 4 passed!");
   end else begin
	 	$error("Test case 4 failed!");
   end

	// supp_fill
	tb_gaussian_fill_done = 1'b0;
	tb_gradient_fill_done = 1'b1;
	@(posedge tb_clk);
	exp_state = 4;
	exp_enable5x5 = 1'b1;
	exp_suppression_buffer = 2'b01;
   if (tb_exp_out == tb_out) begin
		$display("Test case 5 passed!");
   end else begin
	 	$error("Test case 5 failed!");
   end

	// hyst_fill
	tb_gradient_fill_done = 1'b0;
	tb_suppression_fill_done = 1'b1;
	@(posedge tb_clk);
	exp_state = 5;
	exp_enable3x3 = 1'b1;
	exp_hysteresis_buffer = 2'b01;
   if (tb_exp_out == tb_out) begin
		$display("Test case 6 passed!");
   end else begin
	 	$error("Test case 6 failed!");
   end

	// get to run_right
	tb_suppression_fill_done = 1'b0;
	tb_hysteresis_fill_done = 1'b1;
	@(posedge tb_clk);
	exp_state = 6;
	exp_write_enable = 1'b1;
   if (tb_exp_out == tb_out) begin
		$display("Test case 7 passed!");
   end else begin
	 	$error("Test case 7 failed!");
   end

	// stay run_right
	tb_hysteresis_fill_done = 1'b0;
	@(posedge tb_clk);
	exp_state = 6;
   if (tb_exp_out == tb_out) begin
		$display("Test case 8.1 passed!");
   end else begin
	 	$error("Test case 8.1 failed!");
   end

	// stay run_right
	#CLK_PERIOD;
	#CLK_PERIOD;
	#CLK_PERIOD;
	#CLK_PERIOD;
	#CLK_PERIOD;
	exp_state = 6;
   if (tb_exp_out == tb_out) begin
		$display("Test case 8.2 passed!");
   end else begin
	 	$error("Test case 8.2 failed!");
   end

	// hold_left_gauss
	tb_readx_up_max = 1'b1;
	#(CLK_PERIOD/2);
	@(posedge tb_clk);
	exp_state = 7;
	exp_enable9x9 = 1'b0;
	exp_gaussian_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 9 passed!");
   end else begin
	 	$error("Test case 9 failed!");
   end

	// down_left_gauss
	tb_readx_up_max = 1'b0;
	@(posedge tb_clk);
	exp_state = 8;
	exp_enable9x9 = 1'b1;
	exp_gaussian_buffer = 2'b11;
	exp_enable7x7 = 1'b0;
	exp_gradient_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 10 passed!");
   end else begin
	 	$error("Test case 10 failed!");
   end

	// down_left_grad
	@(posedge tb_clk);
	exp_state = 9;
	exp_gaussian_buffer = 2'b10;
	exp_enable7x7 = 1'b1;
	exp_gradient_buffer = 2'b11;
	exp_enable5x5 = 1'b0;
	exp_suppression_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 11 passed!");
   end else begin
	 	$error("Test case 11 failed!");
   end

	// down_left_supp
	@(posedge tb_clk);
	exp_state = 10;
	exp_gradient_buffer = 2'b10;
	exp_enable5x5 = 1'b1;
	exp_suppression_buffer = 2'b11;
	exp_enable3x3 = 1'b0;
	exp_hysteresis_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 12 passed!");
   end else begin
	 	$error("Test case 12 failed!");
   end

	// down_left_hyst
	@(posedge tb_clk);
	exp_state = 11;
	exp_suppression_buffer = 2'b10;
	exp_enable3x3 = 1'b1;
	exp_hysteresis_buffer = 2'b11;
	exp_write_enable = 1'b0;
   if (tb_exp_out == tb_out) begin
		$display("Test case 13 passed!");
   end else begin
	 	$error("Test case 13 failed!");
   end

	// get to run_left
	@(posedge tb_clk);
	exp_state = 12;
	exp_hysteresis_buffer = 2'b10;
	exp_write_enable = 1'b1;
   if (tb_exp_out == tb_out) begin
		$display("Test case 14.1 passed!");
   end else begin
	 	$error("Test case 14.1 failed!");
   end

	// stay run_left
	#CLK_PERIOD;
	#CLK_PERIOD;
	#CLK_PERIOD;
	#CLK_PERIOD;
	#CLK_PERIOD;
	exp_state = 12;
   if (tb_exp_out == tb_out) begin
		$display("Test case 14.2 passed!");
   end else begin
	 	$error("Test case 14.2 failed!");
   end

	// hold_right_gauss
	tb_readx_down_min = 1'b1;
	#(CLK_PERIOD/2);
	@(posedge tb_clk);
	exp_state = 13;
	exp_enable9x9 = 1'b0;
	exp_gaussian_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 15 passed!");
   end else begin
	 	$error("Test case 15 failed!");
   end

	// down_right_gauss
	tb_readx_down_min = 1'b0;
	@(posedge tb_clk);
	exp_state = 14;
	exp_enable9x9 = 1'b1;
	exp_gaussian_buffer = 2'b11;
	exp_enable7x7 = 1'b0;
	exp_gradient_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 16 passed!");
   end else begin
	 	$error("Test case 16 failed!");
   end

	// down_right_grad
	@(posedge tb_clk);
	exp_state = 15;
	exp_gaussian_buffer = 2'b01;
	exp_enable7x7 = 1'b1;
	exp_gradient_buffer = 2'b11;
	exp_enable5x5 = 1'b0;
	exp_suppression_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 17 passed!");
   end else begin
	 	$error("Test case 17 failed!");
   end

	// down_right_supp
	@(posedge tb_clk);
	exp_state = 16;
	exp_gradient_buffer = 2'b01;
	exp_enable5x5 = 1'b1;
	exp_suppression_buffer = 2'b11;
	exp_enable3x3 = 1'b0;
	exp_hysteresis_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 18 passed!");
   end else begin
	 	$error("Test case 18 failed!");
   end

	// down_right_hyst
	@(posedge tb_clk);
	exp_state = 17;
	exp_suppression_buffer = 2'b01;
	exp_enable3x3 = 1'b1;
	exp_hysteresis_buffer = 2'b11;
	exp_write_enable = 1'b0;
   if (tb_exp_out == tb_out) begin
		$display("Test case 19 passed!");
   end else begin
	 	$error("Test case 19 failed!");
   end

//////////////////////////////////////////////////////////////////////////////////////

// get to run_right
	@(posedge tb_clk);
	exp_state = 6;
	exp_hysteresis_buffer = 2'b01;
	exp_write_enable = 1'b1;
   if (tb_exp_out == tb_out) begin
		$display("Test case 20 passed!");
   end else begin
	 	$error("Test case 20 failed!");
   end

	// stay run_right
	tb_hysteresis_fill_done = 1'b0;
	@(posedge tb_clk);
	exp_state = 6;
   if (tb_exp_out == tb_out) begin
		$display("Test case 21 passed!");
   end else begin
	 	$error("Test case 21 failed!");
   end

	// stay run_right
	#CLK_PERIOD;
	#CLK_PERIOD;
	#CLK_PERIOD;
	#CLK_PERIOD;
	#CLK_PERIOD;
	exp_state = 6;
   if (tb_exp_out == tb_out) begin
		$display("Test case 22 passed!");
   end else begin
	 	$error("Test case 22 failed!");
   end

	// hold_left_gauss
	tb_readx_up_max = 1'b1;
	#(CLK_PERIOD/2);
	@(posedge tb_clk);
	exp_state = 7;
	exp_enable9x9 = 1'b0;
	exp_gaussian_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 23 passed!");
   end else begin
	 	$error("Test case 23 failed!");
   end

	// down_left_gauss
	tb_readx_up_max = 1'b0;
	@(posedge tb_clk);
	exp_state = 8;
	exp_enable9x9 = 1'b1;
	exp_gaussian_buffer = 2'b11;
	exp_enable7x7 = 1'b0;
	exp_gradient_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 24 passed!");
   end else begin
	 	$error("Test case 24 failed!");
   end

	// down_left_grad
	@(posedge tb_clk);
	exp_state = 9;
	exp_gaussian_buffer = 2'b10;
	exp_enable7x7 = 1'b1;
	exp_gradient_buffer = 2'b11;
	exp_enable5x5 = 1'b0;
	exp_suppression_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 25 passed!");
   end else begin
	 	$error("Test case 25 failed!");
   end

	// down_left_supp
	@(posedge tb_clk);
	exp_state = 10;
	exp_gradient_buffer = 2'b10;
	exp_enable5x5 = 1'b1;
	exp_suppression_buffer = 2'b11;
	exp_enable3x3 = 1'b0;
	exp_hysteresis_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 26 passed!");
   end else begin
	 	$error("Test case 26 failed!");
   end

	// down_left_hyst
	@(posedge tb_clk);
	exp_state = 11;
	exp_suppression_buffer = 2'b10;
	exp_enable3x3 = 1'b1;
	exp_hysteresis_buffer = 2'b11;
	exp_write_enable = 1'b0;
   if (tb_exp_out == tb_out) begin
		$display("Test case 27 passed!");
   end else begin
	 	$error("Test case 27 failed!");
   end

	// get to run_left
	@(posedge tb_clk);
	exp_state = 12;
	exp_hysteresis_buffer = 2'b10;
	exp_write_enable = 1'b1;
   if (tb_exp_out == tb_out) begin
		$display("Test case 28 passed!");
   end else begin
	 	$error("Test case 28 failed!");
   end

///////////////////////////////////////////////////////////////////////////////

	// gauss_end
	tb_readx_down_min = 1'b1;
	tb_ready_max = 1'b1;
	@(posedge tb_clk);
	exp_state = 18;
	exp_enable9x9 = 1'b0;
	exp_gaussian_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 29 passed!");
   end else begin
	 	$error("Test case 29 failed!");
   end

	// grad_end
	@(posedge tb_clk);
	exp_state = 19;
	exp_enable7x7 = 1'b0;
	exp_gradient_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 30 passed!");
   end else begin
	 	$error("Test case 30 failed!");
   end

	// supp_end
	@(posedge tb_clk);
	exp_state = 20;
	exp_enable5x5 = 1'b0;
	exp_suppression_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 31 passed!");
   end else begin
	 	$error("Test case 31 failed!");
   end

	// hyst_end
	@(posedge tb_clk);
	exp_state = 21;
	exp_enable3x3 = 1'b0;
	exp_hysteresis_buffer = 2'b00;
   if (tb_exp_out == tb_out) begin
		$display("Test case 32 passed!");
   end else begin
	 	$error("Test case 32 failed!");
   end

	// get to idle
	@(posedge tb_clk);
	exp_state = 0;
	exp_write_enable = 1'b0;
   if (tb_exp_out == tb_out) begin
		$display("Test case 33.1 passed!");
   end else begin
	 	$error("Test case 33.1 failed!");
   end

	// stay idle
	#CLK_PERIOD;
	#CLK_PERIOD;
	#CLK_PERIOD;
	#CLK_PERIOD;
	#CLK_PERIOD;
	exp_state = 0;
   if (tb_exp_out == tb_out) begin
		$display("Test case 33.2 passed!");
   end else begin
	 	$error("Test case 33.2 failed!");
   end



	end

endmodule





