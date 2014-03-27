// $Id: $
// File name:   sram_interface.sv
// Created:     11/26/2013
// Author:      Eric Nielsen
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: SRAM interface demo

module sram_interface
(
	// Read SRAM
	input wire [7:0] read_data,

	// Write SRAM
	output wire [7:0] write_data
);

	// Locals
	reg [7:0] write_d;
	assign write_data = write_d;

	// Main
	always @ (*) begin: MAIN
		write_d <= read_data;
	end

endmodule
