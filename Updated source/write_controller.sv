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
	input wire [7:0] test_data,
	//output wire file_dump,
	output wire [7:0] output_data,
	output wire [17:0] write_address
);

	reg [17:0] address;
	assign write_address = address;
	reg [7:0] output_data_reg;
	assign output_data = output_data_reg;
	reg file_dump_reg;
	assign file_dump = file_dump_reg;
	reg [9:0] x_value;
	reg [9:0] y_value;
	reg direction;

	// State register
	always @ (posedge clk, negedge n_rst) begin

   	if (n_rst == 0) begin
	 		x_value = 0;
			y_value = 0;
			direction = 1'b0;
    	end else begin
	 		if (write_enable == 1'b1) begin
				if (direction == 1'b0) begin
					if (x_value < 511)
						x_value = x_value + 1;
					else begin
						y_value = y_value + 1;
						direction = 1'b1;
					end
				end else begin
					if (x_value > 0)
						x_value = x_value - 1;
					else begin
						y_value = y_value + 1;
						direction = 0;
					end
    			end
			end
		end
	end

	// Output to SRAM
	always @(hysteresis_result, x_value, y_value, direction) begin: OUTPUT

		address = x_value + (512 * y_value);
		//output_data_reg = test_data;
		if (hysteresis_result == 0) 
			output_data_reg = 8'b00000000;
		else 
			output_data_reg = 8'b11111111;
		/*if (address == 261632)
			file_dump_reg = 1'b1;
		else
			file_dump_reg = 1'b0;*/

	end

	/*off_chip_sram_write DUT
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
	);*/



endmodule




