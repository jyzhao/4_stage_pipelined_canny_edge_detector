// $Id: $
// File name:   hysteresis.sv
// Created:     11/21/2013
// Author:      Eric Nielsen
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Hysteresis Block

module hysteresis
(
   input wire [7:0] input0,
	input wire [7:0] input1,
	input wire [7:0] input2,
	input wire [7:0] input3,
	input wire [7:0] input4,
	input wire [7:0] input5,
	input wire [7:0] input6,
	input wire [7:0] input7,
	input wire [7:0] input8,
	input wire [7:0] thresh_h,
	input wire [7:0] thresh_l,
	input wire hysteresis_enable,
   output wire hysteresis_out
);

	reg high_wire, low_wire, or1, and1, or2, tmp_hysteresis_out;
	assign hysteresis_out = tmp_hysteresis_out;
	
   always @(*) begin: main

		// input0 >? thresh_h ==> (A)
		if (input0 > thresh_h)
			high_wire = 1'b1;
		else
			high_wire = 1'b0;

		// input0 >? thresh_l ==> (B)
		if (input0 > thresh_l)
			low_wire = 1'b1;
		else
			low_wire = 1'b0;

		// input1-input8 >? thresh_h ==> (C)
		if ((input1 > thresh_h) | 
			 (input2 > thresh_h) | 
	 		 (input3 > thresh_h) | 
			 (input4 > thresh_h) |
			 (input5 > thresh_h) | 
			 (input6 > thresh_h) | 
			 (input7 > thresh_h) | 
			 (input8 > thresh_h))
			or1 = 1'b1;
		else
			or1 = 1'b0;

		// (B) and? (C) ==> (D)
		if ((low_wire == 1'b1) && (or1 == 1'b1))
			and1 = 1'b1;
		else
			and1 = 1'b0;

		// (A) or? (D) ==> (E)
		if (hysteresis_enable == 1'b0)
			tmp_hysteresis_out = 1'bZ;
		else if ((high_wire == 1'b1) | (and1 == 1'b1))
			tmp_hysteresis_out = 1'b1;
		else
			tmp_hysteresis_out = 1'b0;

	end
   
endmodule
   
   
   
