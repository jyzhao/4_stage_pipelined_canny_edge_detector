module gradient_magnitude_wrapper
  (
   input wire [7:0] seven_buffer_in [0:6][0:6],
	input wire [1:0] grad_shift, 
   output wire [7:0] gmag [0:4],
   output wire [7:0] gx [0:4],
   output wire [7:0] gy [0:4]
  );
  
  gradient GRADIENT 
	(
  	.grad_shift(grad_shift),
  	.seven_buffer_in(seven_buffer_in),
  	.gx(gx),
  	.gy(gy)
   );
                    
  magnitude MAGNITUDE 
	(
   .gx(gx),
	.gy(gy),
	.gmag(gmag)
	);
                      
  endmodule
                      
