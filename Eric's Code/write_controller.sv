// $Id: $
// File name:   write_controller.sv
// Created:     11/26/2013
// Author:      Eric Nielsen
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Write Controller Block

module write_controller
(
	input wire clk,
	input wire n_rst,   
	input wire hysteresis_result,
	input wire write_enable,
	input wire file_dump,
	input wire [9:0] x_value,
	input wire [9:0] y_value,
	output wire [7:0] output_data
);

	reg [17:0] address;
	reg [7:0] output_data_reg;
	assign output_data = output_data_reg;

	always @(hysteresis_result, x_value, y_value) begin: OUTPUT

		address = x_value + (512 * y_value);
		if (hysteresis_result == 0) 
			output_data_reg = 8'b00000000;
		else 
			output_data_reg = 8'b11111111;

	end

	off_chip_sram_write DUT
	(
		.mem_clr(!n_rst),
		.mem_init(1'b0),
		.mem_dump(file_dump),
		.verbose(1'b0),
		.init_file_number(1'b0),
		.dump_file_number(1'b0),
		.start_address(1'b0),
		.last_address(262143),
		.read_enable(1'b0),
		.write_enable(write_enable),
		.address(address),
		.data(output_data)
	);



endmodule




