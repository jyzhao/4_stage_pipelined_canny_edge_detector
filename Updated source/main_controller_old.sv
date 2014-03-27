// $Id: $
// File name:   main_controller.sv
// Created:     11/27/2013
// Author:      Eric Nielsen
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Main Controller Block

module main_controller
(
	input wire clk,
	input wire n_rst,
	input wire start,
	input wire gaussian_fill_done,
	input wire gradient_fill_done,
	input wire suppression_fill_done,
	input wire hysteresis_fill_done,
	input wire readx_up_max,
	input wire readx_down_min,
	input wire ready_done,
	output wire enable9x9,
	output wire enable7x7,
	output wire enable5x5,
	output wire enable3x3,
	output wire [1:0] gaussian_buffer,
	output wire [1:0] gradient_buffer,
	output wire [1:0] suppression_buffer,
	output wire [1:0] hysteresis_buffer,
	output wire write_enable
);

	// Outputs
	reg enable9x9_reg;
	reg enable7x7_reg;
	reg enable5x5_reg;
	reg enable3x3_reg;
	reg [1:0] gaussian_buffer_reg;
	reg [1:0] gradient_buffer_reg;
	reg [1:0] suppression_buffer_reg;
	reg [1:0] hysteresis_buffer_reg;
	reg write_enable_reg;
	assign enable9x9 = enable9x9_reg;
	assign enable7x7 = enable7x7_reg;
	assign enable5x5 = enable5x5_reg;
	assign enable3x3 = enable3x3_reg;
	assign gaussian_buffer = gaussian_buffer_reg;
	assign gradient_buffer = gradient_buffer_reg;
	assign suppression_buffer = suppression_buffer_reg;
	assign hysteresis_buffer = hysteresis_buffer_reg;
	assign write_enable = write_enable_reg;
    
	// States
	typedef enum bit [4:0] {idle, prep_stage, prep_stage2, prep_stage3, gauss_fill, grad_fill, supp_fill, hyst_fill, run_right, hold_left_gauss, down_left_gauss, down_left_grad, down_left_supp, down_left_hyst, run_left, hold_right_gauss, down_right_gauss, down_right_grad, down_right_supp, down_right_hyst, gauss_end, grad_end, supp_end, hyst_end} stateType;

	stateType state;
	stateType nxt_state;

	always @ (posedge clk, negedge n_rst) begin: RST

    	if (n_rst == 1'b0) begin
			state <= idle;
      end else begin
         state <= nxt_state;
      end
        
	end

	always @ (state, start, gaussian_fill_done, gradient_fill_done, suppression_fill_done, 
				 hysteresis_fill_done, readx_up_max, readx_down_min, ready_done) begin: NXT

		nxt_state = state;
        
		case(state)
			idle:
				begin
				if (start == 1'b1)
				nxt_state = prep_stage;
				//nxt_state = gauss_fill;
				end
			prep_stage:
				begin
				nxt_state = prep_stage2;
				end
      prep_stage2:
				begin
				nxt_state = prep_stage3;
				end
      prep_stage3:
				begin
				nxt_state = gauss_fill;
				end
			gauss_fill:
				begin
				if (gaussian_fill_done == 1'b1)
					nxt_state = grad_fill;
				end
			grad_fill:
				begin
				if (gradient_fill_done == 1'b1)
					nxt_state = supp_fill;
				end
			supp_fill:
				begin
				if (suppression_fill_done == 1'b1)
					nxt_state = hyst_fill;
				end
			hyst_fill:
				begin
				if (hysteresis_fill_done == 1'b1)
					nxt_state = run_right;
				end
			run_right:
				begin
				if (readx_up_max == 1'b1)
					nxt_state = hold_left_gauss;
				end
			hold_left_gauss:
				begin
            nxt_state = down_left_gauss;
				end               
			down_left_gauss:
				begin
            nxt_state = down_left_grad;
				end
			down_left_grad:
				begin
            nxt_state = down_left_supp;
				end 
			down_left_supp:
				begin
            nxt_state = down_left_hyst;
				end 
			down_left_hyst:
				begin
            nxt_state = run_left;
				end             
			run_left:
				begin
				if (readx_down_min == 1'b1)
					nxt_state = hold_right_gauss;
				end
			hold_right_gauss:
				begin
				if (ready_done == 1'b0)
            	nxt_state = down_right_gauss;
				else 
					nxt_state = gauss_end;
				end               
			down_right_gauss:
				begin
            nxt_state = down_right_grad;
				end
			down_right_grad:
				begin
            nxt_state = down_right_supp;
				end 
			down_right_supp:
				begin
            nxt_state = down_right_hyst;
				end 
			down_right_hyst:
				begin
            nxt_state = run_right;
				end
			gauss_end:
				begin
            nxt_state = grad_end;
				end
			grad_end:
				begin
            nxt_state = supp_end;
				end 
			supp_end:
				begin
            nxt_state = hyst_end;
				end 
			hyst_end:
				begin
            nxt_state = idle;
				end
		endcase
	end

	always @ (state) begin: OUT

		enable9x9_reg = 1'b0;
		enable7x7_reg = 1'b0;
		enable5x5_reg = 1'b0;
		enable3x3_reg = 1'b0;
		gaussian_buffer_reg = 2'b00;
		gradient_buffer_reg = 2'b00;
		suppression_buffer_reg = 2'b00;
		hysteresis_buffer_reg = 2'b00;
		write_enable_reg = 1'b0;
        
		case(state)
			idle:
				begin
				end
			prep_stage:
				begin
        enable9x9_reg = 1'b1;
				end
      prep_stage2:
				begin
        enable9x9_reg = 1'b1;
				end
      prep_stage3:
				begin
        enable9x9_reg = 1'b1;
				end
			gauss_fill:
				begin
				enable9x9_reg = 1'b1;
        		gaussian_buffer_reg = 2'b01;
				end
			grad_fill:
				begin
        		enable9x9_reg = 1'b1;
        		enable7x7_reg = 1'b1;
        		gaussian_buffer_reg = 2'b01;
        		gradient_buffer_reg = 2'b01;
				end
			supp_fill:
				begin
        		enable9x9_reg = 1'b1;
        		enable7x7_reg = 1'b1;
        		enable5x5_reg = 1'b1;
        		gaussian_buffer_reg = 2'b01;
        		gradient_buffer_reg = 2'b01;
        		suppression_buffer_reg = 2'b01;
				end
			hyst_fill:
				begin
        		enable9x9_reg = 1'b1;
        		enable7x7_reg = 1'b1;
        		enable5x5_reg = 1'b1;
        		enable3x3_reg = 1'b1;
        		gaussian_buffer_reg = 2'b01;
        		gradient_buffer_reg = 2'b01;
        		suppression_buffer_reg = 2'b01;
        		hysteresis_buffer_reg = 2'b01;
				end
			run_right:
				begin
        		enable9x9_reg = 1'b1;
        		enable7x7_reg = 1'b1;
        		enable5x5_reg = 1'b1;
        		enable3x3_reg = 1'b1;
        		gaussian_buffer_reg = 2'b01;
        		gradient_buffer_reg = 2'b01;
        		suppression_buffer_reg = 2'b01;
        		hysteresis_buffer_reg = 2'b01;
        		write_enable_reg = 1'b1;
				end
			hold_left_gauss:
				begin
        		enable7x7_reg = 1'b1;
        		enable5x5_reg = 1'b1;
        		enable3x3_reg = 1'b1;
        		gradient_buffer_reg = 2'b01;
        		suppression_buffer_reg = 2'b01;
        		hysteresis_buffer_reg = 2'b01;
        		write_enable_reg = 1'b1;        
				end               
			down_left_gauss:
				begin
        		enable9x9_reg = 1'b1;
        		enable5x5_reg = 1'b1;
        		enable3x3_reg = 1'b1;
        		gaussian_buffer_reg = 2'b11;
        		suppression_buffer_reg = 2'b01;
        		hysteresis_buffer_reg = 2'b01;
        		write_enable_reg = 1'b1;
				end
			down_left_grad:
				begin
        		enable9x9_reg = 1'b1;
        		enable7x7_reg = 1'b1;
        		enable3x3_reg = 1'b1;
        		gaussian_buffer_reg = 2'b10;
        		gradient_buffer_reg = 2'b11;
        		hysteresis_buffer_reg = 2'b01;
        		write_enable_reg = 1'b1;
				end
			down_left_supp:
				begin
        		enable9x9_reg = 1'b1;
        		enable7x7_reg = 1'b1;
        		enable5x5_reg = 1'b1;
        		gaussian_buffer_reg = 2'b10;
        		gradient_buffer_reg = 2'b10;
        		suppression_buffer_reg = 2'b11;
        		write_enable_reg = 1'b1;
				end
			down_left_hyst:
				begin
        		enable9x9_reg = 1'b1;
        		enable7x7_reg = 1'b1;
        		enable5x5_reg = 1'b1;
        		enable3x3_reg = 1'b1;
        		gaussian_buffer_reg = 2'b10;
        		gradient_buffer_reg = 2'b10;
        		suppression_buffer_reg = 2'b10;
        		hysteresis_buffer_reg = 2'b11;
				end
			run_left:
				begin
        		enable9x9_reg = 1'b1;
        		enable7x7_reg = 1'b1;
        		enable5x5_reg = 1'b1;
        		enable3x3_reg = 1'b1;
        		gaussian_buffer_reg = 2'b10;
        		gradient_buffer_reg = 2'b10;
		     	suppression_buffer_reg = 2'b10;
		     	hysteresis_buffer_reg = 2'b10;
        		write_enable_reg = 1'b1;
				end
			hold_right_gauss:
				begin
		     	enable7x7_reg = 1'b1;
		     	enable5x5_reg = 1'b1;
		     	enable3x3_reg = 1'b1;
		     	gradient_buffer_reg = 2'b10;
		     	suppression_buffer_reg = 2'b10;
		     	hysteresis_buffer_reg = 2'b10;
		     	write_enable_reg = 1'b1;
				end
			down_right_gauss:
				begin
		     	enable9x9_reg = 1'b1;
		     	enable5x5_reg = 1'b1;
		     	enable3x3_reg = 1'b1;
		     	gaussian_buffer_reg = 2'b11;
		     	suppression_buffer_reg = 2'b10;
		     	hysteresis_buffer_reg = 2'b10;
		     	write_enable_reg = 1'b1;
				end
			down_right_grad:
				begin
		     	enable9x9_reg = 1'b1;
		     	enable7x7_reg = 1'b1;
		     	enable3x3_reg = 1'b1;
		     	gaussian_buffer_reg = 2'b01;
		     	gradient_buffer_reg = 2'b11;
		     	hysteresis_buffer_reg = 2'b10;
		     	write_enable_reg = 1'b1;
				end
			down_right_supp:
				begin
		     	enable9x9_reg = 1'b1;
		     	enable7x7_reg = 1'b1;
		     	enable5x5_reg = 1'b1;
		     	gaussian_buffer_reg = 2'b01;
		     	gradient_buffer_reg = 2'b01;
		     	suppression_buffer_reg = 2'b11;
		     	write_enable_reg = 1'b1;
				end
			down_right_hyst:
				begin
		     	enable9x9_reg = 1'b1;
		     	enable7x7_reg = 1'b1;
		     	enable5x5_reg = 1'b1;
		     	enable3x3_reg = 1'b1;
		     	gaussian_buffer_reg = 2'b01;
		     	gradient_buffer_reg = 2'b01;
		     	suppression_buffer_reg = 2'b01;
		     	hysteresis_buffer_reg = 2'b11;
				end
			gauss_end:
				begin
		     	enable7x7_reg = 1'b1;
		     	enable5x5_reg = 1'b1;
		     	enable3x3_reg = 1'b1;
		     	gradient_buffer_reg = 2'b10;
		     	suppression_buffer_reg = 2'b10;
		     	hysteresis_buffer_reg = 2'b10;
		     	write_enable_reg = 1'b1;
				end
			grad_end:
				begin
		     	enable5x5_reg = 1'b1;
		     	enable3x3_reg = 1'b1;
		     	suppression_buffer_reg = 2'b10;
		     	hysteresis_buffer_reg = 2'b10;
		     	write_enable_reg = 1'b1;
				end
			supp_end:
				begin
		     	enable3x3_reg = 1'b1;
		     	hysteresis_buffer_reg = 2'b10;
		     	write_enable_reg = 1'b1;
				end
			hyst_end:
				begin
        		write_enable_reg = 1'b1;
				end
		endcase       
	end

endmodule
