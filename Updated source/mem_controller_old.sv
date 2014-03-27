// $Id: $
// File name:   mem_controller.sv
// Created:     11/26/2013
// Author:      Oluwatosin Adeosun
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Memory Controller and Timer.

module mem_controller
(
  input wire clk,
  input wire n_rst,
  input wire start,
  output reg [18:0] add_a, add_b, add_c, add_d, add_e, add_f, add_g, add_h, add_i,
  output reg read_enable,
  output reg write_enable,
  output reg gauss_fill_done,
  output reg grad_fill_done,
  output reg supp_fill_done,
  output reg hyst_fill_done,
  output reg readx_up_done, 
  output reg readx_down_done,
  output reg ready_done
);

reg init_rollover;
reg xup_rollover;
reg xdown_rollover;
reg y_rollover;
reg enable_init;
reg enable_xup;
reg enable_xdown;
reg enable_y;
reg reset_xup;
reg reset_xdown;
reg [9:0] init_value;
reg [9:0] xup_value;
reg [9:0] xdown_value;
reg [9:0] y_value;
reg [9:0] temp_xup_rollover;

typedef enum bit[3:0]
{idle, boot, boot2, grad_load, supp_load, hyst_load, right, holdLeft1, holdLeft2, downLeft, left, holdRight1, holdRight2, downRight, finale} state_type;

state_type state;
state_type nextstate;


counter_up
	#(
		.NUM_CNT_BITS(10)
		)
	COREC(
		.clk(clk),
		.n_rst(n_rst),
		.count_enable((enable_init)),
    .rollover_val(10'b1000000111),
    .sync_reset(1'b0),
		.rollover_flag(init_rollover),
    .value(init_value)
	);

counter_xup
	#(
		.NUM_CNT_BITS(10)
		)
	CORED(
		.clk(clk),
		.n_rst(n_rst),
		.count_enable(enable_xup),
    .rollover_val(10'b1000000111),
    .sync_reset(reset_xup),
		.rollover_flag(xup_rollover),
    .value(xup_value)
	);

counter_down
	#(
		.NUM_CNT_BITS(10)
		)
	COREE(
		.clk(clk),
		.n_rst(n_rst),
		.count_enable(enable_xdown),
    .rollover_val(10'b0111111110),
    .sync_reset(reset_xdown),
		.rollover_flag(xdown_rollover),
    .value(xdown_value)
	);

counter_up
	#(
		.NUM_CNT_BITS(10)
		)
	COREF(
		.clk(clk),
		.n_rst(n_rst),
		.count_enable(enable_y),
    .rollover_val(10'b0111111111),
    .sync_reset(1'b0),
		.rollover_flag(y_rollover),
    .value(y_value)
	);

//assign readx_up_done = xup_rollover;
//assign readx_down_done = xdown_rollover;

assign temp_xup_rollover = y_value*520-2;

always @ (posedge clk,negedge n_rst) begin
    if (n_rst == 0) begin
         state <= idle;
    end else begin
          state <= nextstate;
    end
end

always @* begin
 case (state)
   idle: begin
     read_enable = 1'b0;
     write_enable = 1'b0;
     enable_init = 1'b0;
     enable_xup = 1'b0;
     enable_xdown = 1'b0;
     enable_y = 1'b0;
     reset_xup = 1'b0;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = 0;
     add_b = 0;
     add_c = 0 ;
     add_d = 0;
     add_e = 0;
     add_f = 0;
     add_g = 0;
     add_h = 0;
     add_i = 0;
     if (start == 1) begin
        nextstate = boot;
     end else begin
        nextstate = idle;
     end
     end
  boot: begin
     read_enable = 1'b1;
     write_enable = 1'b0;
     enable_init = 1'b1;
     enable_xup = 1'b0;
     enable_xdown = 1'b0;
     enable_y = 1'b0;
     reset_xup = 1'b0;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = init_value;
     add_b = init_value + 520;
     add_c = init_value + 1040 ;
     add_d = init_value + 1560;
     add_e = init_value + 2080;
     add_f = init_value + 2600;
     add_g = init_value + 3120;
     add_h = init_value + 3640;
     add_i = init_value + 4160;
     nextstate = boot2;
     end
 boot2: begin
     read_enable = 1'b1;
     write_enable = 1'b0;
     enable_init = 1'b1;
     enable_xup = 1'b0;
     enable_xdown = 1'b0;
     enable_y = 1'b0;
     reset_xup = 1'b0;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = init_value;
     add_b = init_value + 520;
     add_c = init_value + 1040 ;
     add_d = init_value + 1560;
     add_e = init_value + 2080;
     add_f = init_value + 2600;
     add_g = init_value + 3120;
     add_h = init_value + 3640;
     add_i = init_value + 4160;
     if (init_value == 2) begin
        nextstate = grad_load;
     end else begin
        nextstate = boot2;
     end
     end
  grad_load: begin
     read_enable = 1'b1;
     write_enable = 1'b0;
     enable_init = 1'b1;
     enable_xup = 1'b0;
     enable_xdown = 1'b0;
     enable_y = 1'b0;
     reset_xup = 1'b0;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b1;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = init_value;
     add_b = init_value + 520;
     add_c = init_value + 1040;
     add_d = init_value + 1560;
     add_e = init_value + 2080;
     add_f = init_value + 2600;
     add_g = init_value + 3120;
     add_h = init_value + 3640;
     add_i = init_value + 4160;
     if (init_value == 5) begin
        nextstate = supp_load;
     end else begin
        nextstate = grad_load;
     end
     end
 supp_load: begin
     read_enable = 1'b1;
     write_enable = 1'b0;
     enable_init = 1'b1;
     enable_xup = 1'b0;
     enable_xdown = 1'b0;
     enable_y = 1'b0;
     reset_xup = 1'b0;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b1;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = init_value;
     add_b = init_value + 520;
     add_c = init_value + 1040;
     add_d = init_value + 1560;
     add_e = init_value + 2080;
     add_f = init_value + 2600;
     add_g = init_value + 3120;
     add_h = init_value + 3640;
     add_i = init_value + 4160;
     if (init_value == 8) begin
        nextstate = hyst_load;
     end else begin
        nextstate = supp_load;
     end
     end
 hyst_load: begin
     read_enable = 1'b1;
     write_enable = 1'b0;
     enable_init = 1'b1;
     enable_xup = 1'b1;
     enable_xdown = 1'b0;
     enable_y = 1'b0;
     reset_xup = 1'b0;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b1;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = init_value;
     add_b = init_value + 520;
     add_c = init_value + 1040;
     add_d = init_value + 1560;
     add_e = init_value + 2080;
     add_f = init_value + 2600;
     add_g = init_value + 3120;
     add_h = init_value + 3640;
     add_i = init_value + 4160;
     if (init_value == 11) begin
        nextstate = right;
     end else begin
        nextstate = hyst_load;
     end
     end
 right: begin
     read_enable = 1'b1;
     write_enable = 1'b0;
     enable_init = 1'b0;
     enable_xup = 1'b1;
     enable_xdown = 1'b0;
     enable_y = 1'b0;
     reset_xup = 1'b0;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b1;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = xup_value + y_value *520;
     add_b = xup_value + (y_value+1)*520;
     add_c = xup_value + (y_value+2)*520;
     add_d = xup_value + (y_value+3)*520;
     add_e = xup_value + (y_value+4)*520;
     add_f = xup_value + (y_value+5)*520;
     add_g = xup_value + (y_value+6)*520;
     add_h = xup_value + (y_value+7)*520;
     add_i = xup_value + (y_value+8)*520;
     if (xup_value == 518) begin
        nextstate = holdLeft1;
     end else begin
        nextstate = right ;
     end
     end
holdLeft1: begin
     read_enable = 1'b1;
     write_enable = 1'b0;
     enable_init = 1'b0;
     enable_xup = 1'b0;
     enable_xdown = 1'b0;
     enable_y = 1'b1;
     reset_xup = 1'b0;
     reset_xdown = 1'b1;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b1;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = xup_value + y_value *520;
     add_b = xup_value + (y_value+1)*520;
     add_c = xup_value + (y_value+2)*520;
     add_d = xup_value + (y_value+3)*520;
     add_e = xup_value + (y_value+4)*520;
     add_f = xup_value + (y_value+5)*520;
     add_g = xup_value + (y_value+6)*520;
     add_h = xup_value + (y_value+7)*520;
     add_i = xup_value + (y_value+8)*520;
     nextstate = downLeft;
     end
holdLeft2: begin
     read_enable = 1'b0;
     write_enable = 1'b0;
     enable_init = 1'b0;
     enable_xup = 1'b0;
     enable_xdown = 1'b0;
     enable_y = 1'b1;
     reset_xup = 1'b0;
     reset_xdown = 1'b1;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = xup_value + y_value *520;
     add_b = xup_value + (y_value+1)*520;
     add_c = xup_value + (y_value+2)*520;
     add_d = xup_value + (y_value+3)*520;
     add_e = xup_value + (y_value+4)*520;
     add_f = xup_value + (y_value+5)*520;
     add_g = xup_value + (y_value+6)*520;
     add_h = xup_value + (y_value+7)*520;
     add_i = xup_value + (y_value+8)*520;
     nextstate = downLeft;
     end
downLeft: begin
     read_enable = 1'b1;
     write_enable = 1'b0;
     enable_init = 1'b0;
     enable_xup = 1'b0;
     enable_xdown = 1'b0;
     enable_y = 1'b0;
     reset_xup = 1'b0;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = xup_value-8 + (y_value+8)*520;
     add_b = xup_value-7 + (y_value+8)*520;
     add_c = xup_value-6 + (y_value+8)*520;
     add_d = xup_value-5 + (y_value+8)*520;
     add_e = xup_value-4 + (y_value+8)*520;
     add_f = xup_value-3 + (y_value+8)*520;
     add_g = xup_value-2 + (y_value+8)*520;
     add_h = xup_value-1 + (y_value+8)*520;
     add_i = xup_value + (y_value+8)*520;
     nextstate =left;
     end
 left: begin
     read_enable = 1'b1;
     write_enable = 1'b0;
     enable_init = 1'b0;
     enable_xup = 1'b0;
     enable_xdown = 1'b1;
     enable_y = 1'b0;
     reset_xup = 1'b0;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = xdown_value + y_value *520;
     add_b = xdown_value + (y_value+1)*520;
     add_c = xdown_value + (y_value+2)*520;
     add_d = xdown_value + (y_value+3)*520;
     add_e = xdown_value + (y_value+4)*520;
     add_f = xdown_value + (y_value+5)*520;
     add_g = xdown_value + (y_value+6)*520;
     add_h = xdown_value + (y_value+7)*520;
     add_i = xdown_value + (y_value+8)*520;
     if (xdown_value == 1) begin
        nextstate = holdRight1;
     end else begin
        nextstate = left ;
     end
     end
holdRight1: begin
     read_enable = 1'b1;
     write_enable = 1'b0;
     enable_init = 1'b0;
     enable_xup = 1'b0;
     enable_xdown = 1'b0;
     enable_y = 1'b1;
     reset_xup = 1'b1;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b1;
     ready_done = 1'b0;
     add_a = xdown_value + y_value *520;
     add_b = xdown_value + (y_value+1)*520;
     add_c = xdown_value + (y_value+2)*520;
     add_d = xdown_value + (y_value+3)*520;
     add_e = xdown_value + (y_value+4)*520;
     add_f = xdown_value + (y_value+5)*520;
     add_g = xdown_value + (y_value+6)*520;
     add_h = xdown_value + (y_value+7)*520;
     add_i = xdown_value + (y_value+8)*520;
     if (y_value == 511)begin
     nextstate = finale;
     end else begin
     nextstate = downRight;
     end
     end
holdRight2: begin
     read_enable = 1'b0;
     write_enable = 1'b0;
     enable_init = 1'b0;
     enable_xup = 1'b0;
     enable_xdown = 1'b0;
     enable_y = 1'b1;
     reset_xup = 1'b0;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = xup_value + ((y_value+8)*520);
     add_b = xup_value+1 + ((y_value+8)*520);
     add_c = xup_value+2 + ((y_value+8)*520);
     add_d = xup_value+3 + ((y_value+8)*520);
     add_e = xup_value+4 + ((y_value+8)*520);
     add_f = xup_value+5 + ((y_value+8)*520);
     add_g = xup_value+6 + ((y_value+8)*520);
     add_h = xup_value+7 + ((y_value+8)*520);
     add_i = xup_value+8 + ((y_value+8)*520);
     nextstate = downRight;
     end
downRight: begin
     read_enable = 1'b1;
     write_enable = 1'b0;
     enable_init = 1'b0;
     enable_xup = 1'b0;
     enable_xdown = 1'b0;
     enable_y = 1'b0;
     reset_xup = 1'b0;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = xdown_value + ((y_value+8)*520);
     add_b = xdown_value+1 + ((y_value+8)*520);
     add_c = xdown_value+2 + ((y_value+8)*520);
     add_d = xdown_value+3 + ((y_value+8)*520);
     add_e = xdown_value+4 + ((y_value+8)*520);
     add_f = xdown_value+5 + ((y_value+8)*520);
     add_g = xdown_value+6 + ((y_value+8)*520);
     add_h = xdown_value+7 + ((y_value+8)*520);
     add_i = xdown_value+8 + ((y_value+8)*520);
     nextstate =right;
     end
finale: begin
     read_enable = 1'b1;
     write_enable = 1'b0;
     enable_init = 1'b0;
     enable_xup = 1'b0;
     enable_xdown = 1'b0;
     enable_y = 1'b0;
     reset_xup = 1'b0;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b1;
     add_a = 0;
     add_b = 0;
     add_c = 0 ;
     add_d = 0;
     add_e = 0;
     add_f = 0;
     add_g = 0;
     add_h = 0;
     add_i = 0;
     nextstate = idle;
     end
default: begin
     read_enable = 1'b0;
     write_enable = 1'b0;
     enable_init = 1'b0;
     enable_xup = 1'b0;
     enable_xdown = 1'b0;
     enable_y = 1'b0;
     reset_xup = 1'b0;
     reset_xdown = 1'b0;
     gauss_fill_done = 1'b0;
     grad_fill_done = 1'b0;
     supp_fill_done = 1'b0;
     hyst_fill_done = 1'b0;
     readx_up_done = 1'b0;
     readx_down_done = 1'b0;
     ready_done = 1'b0;
     add_a = 0;
     add_b = 0;
     add_c = 0 ;
     add_d = 0;
     add_e = 0;
     add_f = 0;
     add_g = 0;
     add_h = 0;
     add_i = 0;
     nextstate = idle;
     end
  endcase
 end
endmodule
