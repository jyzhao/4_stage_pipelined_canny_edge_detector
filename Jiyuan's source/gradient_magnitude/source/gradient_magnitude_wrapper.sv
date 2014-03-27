module gradient_magnitude_wrapper
  (
  input wire [7:0] wrapper_p2, // pixel 2, 8 bits
  input wire [7:0] wrapper_p5, // pixel 5, 8 bits
  input wire [7:0] wrapper_p8, // pixel 8, 8 bits
  input wire [7:0] wrapper_p4, // pixel 4, 8 bits
  input wire [7:0] wrapper_p6, // pixel 6, 8 bits
  output reg [7:0] wrapper_gx, // gradient x, 8 bits
  output reg [7:0] wrapper_gy,  // gradient y, 8 bits
  output reg [7:0] wrapper_gmag // magnitude of gradient., 8 bits
  );
  
  gradient GRADIENT (
                    .p2(wrapper_p2),
                    .p5(wrapper_p5),
                    .p8(wrapper_p8),
                    .p4(wrapper_p4),
                    .p6(wrapper_p6),
                    .gx(wrapper_gx),
                    .gy(wrapper_gy)
                    );
                    
  magnitude MAGNITUDE (
                      .gx(wrapper_gx),
                      .gy(wrapper_gy),
                      .gmag(wrapper_gmag)
                      );
                      
  endmodule
                      