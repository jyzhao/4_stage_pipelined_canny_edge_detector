module gradient_magnitude_wrapper
  (
   input wire clk,
   input wire n_rst,
   input wire [7:0] seven_buffer_in [0:6][0:6] ,
	input wire [1:0] grad_shift, 
   output wire [7:0] gmag [0:4],
   output wire [7:0] gx [0:4],
   output wire [7:0] gy [0:4]
  );
  
         reg [7:0] gxs [0:4];
         reg [7:0] gys [0:4];

  gradient GRADIENT 
	(
  	.grad_shift(grad_shift),
  	.seven_buffer_in(seven_buffer_in),
  	.gx(gx),
  	.gy(gy)
   );
                    
  magnitude MAGNITUDE 
	(
   .gx(gxs),
	.gy(gys),
	.gmag(gmag)
	);
          
 grad_buff BUFF
 (
    .clk(clk),
    .n_rst(n_rst),
    .gy(gy),
    .gx(gx),
    .gy_new(gys),
    .gx_new(gxs)
);            
  endmodule
