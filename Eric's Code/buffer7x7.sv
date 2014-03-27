// $Id: $
// File name:   buffer7x7.sv
// Created:     11/24/2013
// Author:      Eric Nielsen
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: 7X7 Buffer

module buffer7x7
#(
  parameter HEIGHT = 3'b111,
  parameter WIDTH = 3'b111
)
(
   input wire clk,
   input wire n_rst,
   input wire shift_enable,
   input wire [1:0] shift_direction,
   input wire [7:0] buffer_input [0:6],
   output wire [7:0] buffer_output [0:6][0:6] 
);

	// Local variables
	reg [7:0] buffer [0:6][0:6];
  	reg [7:0] nxt_buffer [0:6][0:6];
  	reg [3:0] row;
	reg [3:0] column;
	assign buffer_output = buffer;

	// State register
	always @ (posedge clk, negedge n_rst) begin
   	if (n_rst == 0) begin
	 		for (row = 0; row < HEIGHT; row = row + 1) begin
	 			for (column = 0; column < WIDTH; column = column + 1) begin
      			buffer[row][column] = 8'b00000000;
				end
			end
    	end else begin
	 		for (row = 0; row < HEIGHT; row = row + 1) begin
	 			for (column = 0; column < WIDTH; column = column + 1) begin
      			buffer[row][column] = nxt_buffer[row][column];
				end
			end
    	end
	end

	// Next state logic
	always @ (shift_enable, shift_direction, buffer_input[0], buffer_input[1], 
					buffer_input[2], buffer_input[3], buffer_input[4], buffer_input[5], buffer[6]) begin

		// No shift
		if (shift_enable == 1'b0 || shift_direction == 2'b00) begin		
			for (row = 0; row < HEIGHT; row = row + 1) begin
 				for (column = 0; column < WIDTH; column = column + 1) begin
	    			nxt_buffer[row][column] <= buffer[row][column];
				end 
	 		end

		// Right shift
		end else if (shift_direction == 2'b01) begin
			for (row = 0; row < HEIGHT; row = row + 1) begin
 				for (column = 0; column < (WIDTH-1); column = column + 1) begin
	    			nxt_buffer[row][column] <= buffer[row][column+1];
				end
			end
			for (row = 0; row < HEIGHT; row = row + 1) begin
	    		nxt_buffer[row][WIDTH-1] <= buffer_input[row];
			end

		// Down Shift
		end else if (shift_direction == 2'b11) begin
			for (row = 0; row < (HEIGHT-1); row = row + 1) begin
 				for (column = 0; column < WIDTH; column = column + 1) begin
	    			nxt_buffer[row][column] <= buffer[row+1][column];
				end
			end
			for (column = 0; column < WIDTH; column = column + 1) begin
	    		nxt_buffer[HEIGHT-1][column] <= buffer_input[column];
			end
		
		// Left Shift
		end else begin
			for (row = 0; row < HEIGHT; row = row + 1) begin
 				for (column = 1; column < WIDTH; column = column + 1) begin
	    			nxt_buffer[row][column] <= buffer[row][column-1];
				end
			end
			for (row = 0; row < HEIGHT; row = row + 1) begin
	    		nxt_buffer[row][0] <= buffer_input[row];
			end
		end 
end

endmodule

