// $Id: $
// File name:   project_test.sv
// Created:     11/21/2013
// Author:      Eric Nielsen
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: 3x3 Buffer and Hysteresis Join Block

module project_test  
(
   input wire clk,
   input wire n_rst,
	input wire [1:0] shift_direction,
	input wire shift_enable,	
   input wire [7:0] buffer_input [0:2],
	input wire [7:0] thresh_h,
	input wire [7:0] thresh_l,
	input wire hysteresis_enable,
   output wire hysteresis_out
);

	// Connecting wires
	reg [7:0] buffer_output [0:2][0:2];

	buffer3x3 instance_1
	(
	.clk(clk),
	.n_rst(n_rst),
	.shift_enable(shift_enable),	
	.shift_direction(shift_direction),
	.buffer_input(buffer_input),
   .buffer_output(buffer_output)
	);

	hysteresis instance_0
	(
   .input0(buffer_output[1][1]),
	.input1(buffer_output[0][0]),
	.input2(buffer_output[0][1]),
	.input3(buffer_output[0][2]),
	.input4(buffer_output[1][0]),
	.input5(buffer_output[1][2]),
	.input6(buffer_output[2][0]),
	.input7(buffer_output[2][1]),
	.input8(buffer_output[2][2]),
	.thresh_h(thresh_h),
	.thresh_l(thresh_l),
	.hysteresis_enable(hysteresis_enable),
   .hysteresis_out(hysteresis_out)
	);

endmodule


