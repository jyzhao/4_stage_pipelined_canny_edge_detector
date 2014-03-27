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
	output wire [7:0] output_data,
	output wire [17:0] write_address,
	input wire final_image
);

	reg [17:0] address;
	assign write_address = address;
	reg [7:0] output_data_reg;
	assign output_data = output_data_reg;
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
		if (final_image == 0)
			output_data_reg = test_data;
		else begin
			if (hysteresis_result == 0) 
				output_data_reg = 8'b00000000;
			else 
				output_data_reg = 8'b11111111;
		end

	end

endmodule




