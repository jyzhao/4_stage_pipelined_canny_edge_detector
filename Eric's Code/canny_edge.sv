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
	output wire write_enable_r,
	output wire mem_clr_r,
	output wire mem_init_r,
	output wire mem_dump_r,
	output wire verbose_r,
	output wire init_file_number_r,
	output wire dump_file_number_r,
	output wire start_address_r,
	output wire last_address_r,

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
	output wire read_enable_w,
	output wire write_enable_w,
	output wire mem_clr_w,
	output wire mem_init_w,
	output wire mem_dump_w,
	output wire verbose_w,
	output wire init_file_number_w,
	output wire dump_file_number_w,
	output wire start_address_w,
	output wire last_address_w,
	output wire [17:0] write_address,
	output wire [7:0] write_data
);

	// Hard-wired read SRAM wires
	assign write_enable_r = 1'b0;
	assign mem_clr_r = 1'b0;
	assign mem_init_r = 1'b0;
	assign mem_dump_r = 1'b0;
	assign verbose_r = 1'b0;
	assign init_file_number_r = 1'b0;
	assign dump_file_number_r = 1'b0;
	assign start_address_r = 1'b0;
	assign last_address_r = 270399;

	// Hard-wired write SRAM wires
	assign read_enable_w = 1'b0;
	assign mem_init_w = 1'b0;
	assign verbose_w = 1'b0;
	assign init_file_number_w = 1'b0;
	assign dump_file_number_w = 1'b0;
	assign start_address_w = 1'b0;
	assign last_address_w = 262143;

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
	wire [7:0] sram_in [0:8];
	assign sram_in = {read_a, read_b, read_c, read_d, read_e, read_f, read_g, read_h, read_i};
	wire [7:0] non_max_out [0:2];
   wire [7:0] buff3x3_out [0:2][0:2];
   wire [7:0] buff5x5_out [0:4][0:4];
   wire [7:0] buff7x7_in [0:6];

	// Hysteresis thresholds
	wire [7:0] thresh_h;
	wire [7:0] thresh_l;
	assign thresh_h = 8'b10010110;		// 150 decimal
	assign thresh_l = 8'b01100100;		// 100 decimal
	

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
	.ready_max(ready_max),
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

	nine_buffer instance_2
	(
   .clk(clk),
   .n_rst(n_rst),
   .nineXnine_enable(enable9x9),
   .gauss_shift(gauss_buffer),
   .sram_in(sram_in),
   output wire [7:0] nine_buffer_output [0:8][0:8]
	);

	gauss_block instance_3
	(
   .clk(clk),
   .n_rst(n_rst),
   .nineXnine_enable(enable9x9),
   .gauss_shift(gauss_buffer),
	input wire [7:0] sram_in [0:8],
	.gauss_out(buff7x7_in)
	);
	
	buffer7x7 instance_4
	(
   .clk(clk),
   .n_rst(n_rst),
   .shift_enable(enable7x7),
   .shift_direction(grad_buffer),
   .buffer_input(buff7x7_in),
   output wire [7:0] buffer_output [0:6][0:6] 
	);

	grad_block instance_5
	(

	);

	buffer5x5 instance_6
	(
   .clk(clk),
   .n_rst(n_rst),
   .shift_enable(enable5x5),
   .shift_direction(supp_buffer),
   input wire [7:0] buffer_input [0:4],
   .buffer_output(buff5x5_out)
	);

	supp_block instance_7
	(
	input wire [7:0] Gx_a,
	input wire [7:0] Gx_b,
	input wire [7:0] Gx_c,
	input wire [7:0] Gy_a,
	input wire [7:0] Gy_b,
	input wire [7:0] Gy_c,
	.five_buffer_in(buff5x5_out),
   .shift_dir(supp_buffer),
	.non_max(non_max_out)
	);

	buffer3x3 instance_8
	(	
   .clk(clk),
   .n_rst(n_rst),
   .shift_enable(enable3x3),
   .shift_direction(hyst_buffer),
   .buffer_input(non_max_out),
   .buffer_output(buff3x3_out)
	);

	hysteresis instance_9
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
	.hysteresis_enable(hyst_buffer),
   .hysteresis_out(hysteresis_out)
	);

	write_controller instance_10
	(
	.clk(clk),
	.n_rst(n_rst),   
	.hysteresis_result(hysteresis_out),
	.write_enable(write_enable_w),
	.file_dump(file_dump),
	.output_data(write_data),
	.write_address(write_address)
	);

	off_chip_sram_write instance_11
	(
		.mem_clr(!n_rst),
		.mem_init(mem_init_w),
		.mem_dump(file_dump),
		.verbose(verbose_w),
		.init_file_number(init_file_number_w),
		.dump_file_number(dump_file_number_w),
		.start_address(start_address_w),
		.last_address(last_address_w),
		.read_enable(read_enable_w),
		.write_enable(write_enable_w),
		.address(write_address),
		.data(write_data)
	);

	off_chip_sram_read instance_a
	(
		.mem_clr(mem_clr_r),
		.mem_init(mem_init_r),
		.mem_dump(mem_dump_r),
		.verbose(verbose_r),
		.init_file_number(init_file_number_r),
		.dump_file_number(dump_file_number_r),
		.start_address(start_address_r),
		.last_address(last_address_r),
		.read_enable(read_enable_r),
		.write_enable(write_enable_r),
		.address(add_a),
		.data(read_a)
	);

	off_chip_sram_read instance_b
	(
		.mem_clr(mem_clr_r),
		.mem_init(mem_init_r),
		.mem_dump(mem_dump_r),
		.verbose(verbose_r),
		.init_file_number(init_file_number_r),
		.dump_file_number(dump_file_number_r),
		.start_address(start_address_r),
		.last_address(last_address_r),
		.read_enable(read_enable_r),
		.write_enable(write_enable_r),
		.address(add_b),
		.data(read_b)
	);

	off_chip_sram_read instance_c
	(
		.mem_clr(mem_clr_r),
		.mem_init(mem_init_r),
		.mem_dump(mem_dump_r),
		.verbose(verbose_r),
		.init_file_number(init_file_number_r),
		.dump_file_number(dump_file_number_r),
		.start_address(start_address_r),
		.last_address(last_address_r),
		.read_enable(read_enable_r),
		.write_enable(write_enable_r),
		.address(add_c),
		.data(read_c)
	);

	off_chip_sram_read instance_d
	(
		.mem_clr(mem_clr_r),
		.mem_init(mem_init_r),
		.mem_dump(mem_dump_r),
		.verbose(verbose_r),
		.init_file_number(init_file_number_r),
		.dump_file_number(dump_file_number_r),
		.start_address(start_address_r),
		.last_address(last_address_r),
		.read_enable(read_enable_r),
		.write_enable(write_enable_r),
		.address(add_d),
		.data(read_d)
	);

	off_chip_sram_read instance_e
	(
		.mem_clr(mem_clr_r),
		.mem_init(mem_init_r),
		.mem_dump(mem_dump_r),
		.verbose(verbose_r),
		.init_file_number(init_file_number_r),
		.dump_file_number(dump_file_number_r),
		.start_address(start_address_r),
		.last_address(last_address_r),
		.read_enable(read_enable_r),
		.write_enable(write_enable_r),
		.address(add_e),
		.data(read_e)
	);

	off_chip_sram_read instance_f
	(
		.mem_clr(mem_clr_r),
		.mem_init(mem_init_r),
		.mem_dump(mem_dump_r),
		.verbose(verbose_r),
		.init_file_number(init_file_number_r),
		.dump_file_number(dump_file_number_r),
		.start_address(start_address_r),
		.last_address(last_address_r),
		.read_enable(read_enable_r),
		.write_enable(write_enable_r),
		.address(add_f),
		.data(read_f)
	);

	off_chip_sram_read instance_g
	(
		.mem_clr(mem_clr_r),
		.mem_init(mem_init_r),
		.mem_dump(mem_dump_r),
		.verbose(verbose_r),
		.init_file_number(init_file_number_r),
		.dump_file_number(dump_file_number_r),
		.start_address(start_address_r),
		.last_address(last_address_r),
		.read_enable(read_enable_r),
		.write_enable(write_enable_r),
		.address(add_g),
		.data(read_g)
	);

	off_chip_sram_read instance_h
	(
		.mem_clr(mem_clr_r),
		.mem_init(mem_init_r),
		.mem_dump(mem_dump_r),
		.verbose(verbose_r),
		.init_file_number(init_file_number_r),
		.dump_file_number(dump_file_number_r),
		.start_address(start_address_r),
		.last_address(last_address_r),
		.read_enable(read_enable_r),
		.write_enable(write_enable_r),
		.address(add_h),
		.data(read_h)
	);

	off_chip_sram_read instance_i
	(
		.mem_clr(mem_clr_r),
		.mem_init(mem_init_r),
		.mem_dump(mem_dump_r),
		.verbose(verbose_r),
		.init_file_number(init_file_number_r),
		.dump_file_number(dump_file_number_r),
		.start_address(start_address_r),
		.last_address(last_address_r),
		.read_enable(read_enable_r),
		.write_enable(write_enable_r),
		.address(add_i),
		.data(read_i)
	);


endmodule

