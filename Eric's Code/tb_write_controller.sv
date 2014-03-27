// $Id: $
// File name:   tb_write_controller.sv
// Created:     4/16/2013
// Author:      foo
// Lab Section: 99
// Version:     1.0  Initial Design Entry
// Description: A simple verilog test bench for the VHDL off-chip sram wrapper.

`timescale 1ns / 100ps

module tb_write_controller ();

   // Constant parameters
   localparam CLK_PERIOD = 12;    //100 MHZ clock
	
	reg tb_clk;   
	reg tb_n_rst;   
	reg tb_hysteresis_result;
	reg tb_write_enable;
	reg tb_file_dump;
	reg [9:0] tb_x_value;
	reg [9:0] tb_y_value;
	reg [18:0] tb_count;
	reg [7:0] tb_output_data;

	// Port map
	write_controller DUT
	(
	.clk(tb_clk),
	.n_rst(tb_n_rst),   
	.hysteresis_result(tb_hysteresis_result),
	.write_enable(tb_write_enable),
	.file_dump(tb_file_dump),
	.x_value(tb_x_value),
	.y_value(tb_y_value),
	.output_data(tb_output_data)
	);
		
	initial begin : TEST_BENCH

		// Reset the SRAM
		tb_n_rst = 1'b0;
		#CLK_PERIOD;
		tb_n_rst = 1'b1;

		// Initialize x,y values
		tb_x_value = 0;
		tb_y_value = 0;
		tb_hysteresis_result = 0;
	
		// Loop through all pixels
		for (tb_count = 0; tb_count <= 262143; tb_count = tb_count + 1) begin
			
			// Update x,y values
			if (tb_x_value < 511)
				tb_x_value = tb_x_value + 1;
			else begin
				tb_x_value = 0;
				tb_y_value = tb_y_value + 1;
			end

			// Update data value
			if (tb_hysteresis_result == 1'b0)
				tb_hysteresis_result = 1'b1;
			else
				tb_hysteresis_result = 1'b0;

			// Clock it
			tb_write_enable = 1'b1;
			#CLK_PERIOD;
			tb_write_enable = 1'b0;
			

		end

		// Dump data to output file
			tb_file_dump = 1'b1;
			#CLK_PERIOD;
			tb_file_dump = 1'b0;

		$display("Memory Dumped!");
		
	end
	
endmodule
