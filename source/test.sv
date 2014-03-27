// $Id: $
// File name:   canny_edge.sv
// Created:     11/29/2013
// Author:      Eric Nielsen
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Canny Edge Detector - Top-level Block

module test   
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
	wire [7:0] nine_buffer_output [0:8][0:8];
   wire [7:0] buff [0:2][0:2];
	

	hysteresis instance_9
	(
   .input0(buff[1][1]),
   .input1(buff[0][0]),
   .input2(buff[0][1]),
   .input3(buff[0][2]),
   .input4(buff[1][0]),
   .input5(buff[1][2]),
   .input6(buff[2][0]),
   .input7(buff[2][1]),
   .input8(buff[2][2]),
	.thresh_h(thresh_h),
	.thresh_l(thresh_l),
	.hysteresis_enable(hyst_buffer),
   .hysteresis_out(hysteresis_out)
	);




endmodule

