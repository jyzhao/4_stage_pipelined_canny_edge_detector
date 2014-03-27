// $Id: $
// File name:   canny_edge.sv
// Created:     11/29/2013
// Author:      Eric Nielsen
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Canny Edge Detector - Top-level Block

module canny_edge   
(
	// General   
	input wire clk,
   input wire n_rst,
	input wire start,
   output wire error,

	// Common to all read SRAMs
	output wire read_enable_r,
	input wire mem_init_r,

	// For specific read SRAMs
	output wire [18:0] add_a,
	output wire [18:0] add_b,
	output wire [18:0] add_c,
	output wire [18:0] add_d,
	output wire [18:0] add_e,
	output wire [18:0] add_f,
	output wire [18:0] add_g,
	output wire [18:0] add_h,
	output wire [18:0] add_i,
	input wire [7:0] read_a,
	input wire [7:0] read_b,
	input wire [7:0] read_c,
	input wire [7:0] read_d,
	input wire [7:0] read_e,
	input wire [7:0] read_f,
	input wire [7:0] read_g,
	input wire [7:0] read_h,
	input wire [7:0] read_i,

	// For write SRAM
	output wire write_enable_w,
	output wire mem_clr_w,
	input wire mem_dump_w,
	output wire [17:0] write_address,
	output wire [7:0] write_data
	
);

	// Inner wires
	wire file_dump;
	wire hysteresis_out;
	wire gauss_fill_done;
	wire grad_fill_done;
	wire supp_fill_done;
	wire hyst_fill_done;
	wire readx_up_max;
	wire readx_down_min;
	wire ready_max;
	wire enable9x9;
	wire enable7x7;
	wire enable5x5;
	wire enable3x3;
	wire [1:0] gauss_buffer;
	wire [1:0] grad_buffer;
	wire [1:0] supp_buffer;
	wire [1:0] hyst_buffer;
	wire [7:0] non_max_out [0:2];
   wire [7:0] buff3x3_out [0:2][0:2];
   wire [7:0] buff5x5_gmag_out [0:4][0:4];
   wire [7:0] buff5x5_gx_out [0:4][0:4];
   wire [7:0] buff5x5_gy_out [0:4][0:4];
   wire [7:0] buff7x7_in [0:6];
   wire [7:0] buff7x7_out [0:6][0:6]; 
   wire [7:0] gmag_out [0:4];
   wire [7:0] gx_out [0:4];
   wire [7:0] gy_out [0:4];
  
  wire [7:0] in_out [0:8][0:8];

	wire [7:0] test_out;
	assign test_out = in_out [4][4];



	// Hysteresis thresholds
	wire [7:0] thresh_h;
	wire [7:0] thresh_l;
	assign thresh_h = 40;		// 35 decimal
	assign thresh_l = 35;		// 28 decimal
	

	main_controller instance_0
	(
	.clk(clk),
	.n_rst(n_rst),
	.start(start),
	.gaussian_fill_done(gauss_fill_done),
	.gradient_fill_done(grad_fill_done),
	.suppression_fill_done(supp_fill_done),
	.hysteresis_fill_done(hyst_fill_done),
	.readx_up_max(readx_up_max),
	.readx_down_min(readx_down_min),
	.ready_done(ready_max),
	.enable9x9(enable9x9),
	.enable7x7(enable7x7),
	.enable5x5(enable5x5),
	.enable3x3(enable3x3),
	.gaussian_buffer(gauss_buffer),
	.gradient_buffer(grad_buffer),
	.suppression_buffer(supp_buffer),
	.hysteresis_buffer(hyst_buffer),
	.write_enable(write_enable_w)
	);

	mem_controller instance_1
	(
  	.clk(clk),
  	.n_rst(n_rst),
  	.start(start),
  	.add_a(add_a),
	.add_b(add_b),
	.add_c(add_c),
	.add_d(add_d),
	.add_e(add_e),
	.add_f(add_f),
	.add_g(add_g),
	.add_h(add_h),
	.add_i(add_i),
  	.read_enable(read_enable_r),
  	.write_enable(write_enable_r),
  	.gauss_fill_done(gauss_fill_done),
  	.grad_fill_done(grad_fill_done),
  	.supp_fill_done(supp_fill_done),
  	.hyst_fill_done(hyst_fill_done),
  	.readx_up_done(readx_up_max), 
  	.readx_down_done(readx_down_min),
  	.ready_done(ready_max)
	);

	gauss_block instance_2
	(
   .clk(clk),
   .n_rst(n_rst),
   .nineXnine_enable(enable9x9),
   .gauss_shift(gauss_buffer),
	.sram_inA(read_a),
	.sram_inB(read_b),
	.sram_inC(read_c), 
	.sram_inD(read_d),
	.sram_inE(read_e),
	.sram_inF(read_f),
	.sram_inG(read_g),
	.sram_inH(read_h),
	.sram_inI(read_i),
	.gauss_out(buff7x7_in),
  .temp_out(in_out)
	);
	
	buffer7x7 instance_3
	(
   .clk(clk),
   .n_rst(n_rst),
   .shift_enable(enable7x7),
   .shift_direction(grad_buffer),
   .buffer_input(buff7x7_in),
   .buffer_output(buff7x7_out) 
	);

	gradient_magnitude_wrapper instance_4
	(
   .clk(clk),
  .n_rst(n_rst),
   .seven_buffer_in(buff7x7_out),
	.grad_shift(grad_buffer),
	.gmag(gmag_out),
	.gx(gx_out),
	.gy(gy_out)
	);

	buffer5x5 instance_Gmag
	(
   .clk(clk),
   .n_rst(n_rst),
   .shift_enable(enable5x5),
   .shift_direction(supp_buffer),
   .buffer_input(gmag_out),
   .buffer_output(buff5x5_gmag_out)
	);

	buffer5x5 instance_Gx
	(
   .clk(clk),
   .n_rst(n_rst),
   .shift_enable(enable5x5),
   .shift_direction(supp_buffer),
   .buffer_input(gx_out),
   .buffer_output(buff5x5_gx_out)
	);

	buffer5x5 instance_Gy
	(
   .clk(clk),
   .n_rst(n_rst),
   .shift_enable(enable5x5),
   .shift_direction(supp_buffer),
   .buffer_input(gy_out),
   .buffer_output(buff5x5_gy_out)
	);

	non_maximal_suppression instance_5
	(
	.five_buffer_in(buff5x5_gmag_out),
	.Gx_buffer(buff5x5_gx_out),
	.Gy_buffer(buff5x5_gy_out),
   .shift_dir(supp_buffer),
	.non_max(non_max_out)
	);

	buffer3x3 instance_6
	(	
   .clk(clk),
   .n_rst(n_rst),
   .shift_enable(enable3x3),
   .shift_direction(hyst_buffer),
   .buffer_input(non_max_out),
   .buffer_output(buff3x3_out)
	);

	hysteresis instance_7
	(
   .input0(buff3x3_out[1][1]),
   .input1(buff3x3_out[0][0]),
   .input2(buff3x3_out[0][1]),
   .input3(buff3x3_out[0][2]),
   .input4(buff3x3_out[1][0]),
   .input5(buff3x3_out[1][2]),
   .input6(buff3x3_out[2][0]),
   .input7(buff3x3_out[2][1]),
   .input8(buff3x3_out[2][2]),
	.thresh_h(thresh_h),
	.thresh_l(thresh_l),
	.hysteresis_enable(enable3x3),
   .hysteresis_out(hysteresis_out)
	);

	write_controller instance_8
	(
	.clk(clk),
	.n_rst(n_rst),   
	.hysteresis_result(hysteresis_out),
	.write_enable(write_enable_w),
	.test_data(test_out),
	//.file_dump(file_dump),
	.output_data(write_data),
	.write_address(write_address)
	);



endmodule

