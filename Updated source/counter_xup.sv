// $Id: $
// File name:   counter_xup.sv
// Created:     11/26/2013
// Author:      Oluwatosin Adeosun
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description:  Counter up x
module counter_xup
#(
  parameter NUM_CNT_BITS = 4
)
(
	      input wire clk,
        input wire n_rst,
        input wire count_enable,
        input wire [NUM_CNT_BITS-1:0] rollover_val,
        input wire sync_reset,
        output wire rollover_flag, 
        output wire [NUM_CNT_BITS-1:0] value       
);
        reg [NUM_CNT_BITS-1:0] inputs;
        reg [NUM_CNT_BITS-1:0] q;
        reg [NUM_CNT_BITS-1:0] d;
        reg flag;
        reg flag_next;
        
        assign value = q;      
        assign rollover_flag = flag;
        assign inputs = rollover_val;

 always @ (posedge clk,negedge n_rst) begin
    if (n_rst == 0) begin
        q <= 9;
        flag <=0;
    end else begin
          q <= d;
          flag <= flag_next;
    end
end

always @ (count_enable,q,sync_reset,inputs)begin
  if (count_enable == 1) begin
    if(q == inputs) begin
          d = 9;
          flag_next = 1'b1;
    end else begin
          d= q+ 1;
          flag_next = 1'b0;
    end
  end else begin
          d=q;
          flag_next = flag;
 end
 if(sync_reset == 1)begin
          d = 9;
          flag_next = 1'b0;
 end 
end
endmodule 
