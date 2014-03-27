module magnitude
  (
  input wire [7:0] gx, // gradient x, 8 bits
  input wire [7:0] gy, // gradient y, 8 bits
  output reg [7:0] gmag // gradient magnitude, 8 bits
  );

reg [15:0] gx_sq;
reg [15:0] gy_sq;

assign gx_sq = gx * gx;
assign gy_sq = gy * gy;

reg [31:0] a;
assign a = gx_sq + gy_sq;
reg [31:0] a_next;

reg [15:0] q;


reg [17:0] left;
reg [17:0] right ;
reg [17:0] r;

int i;

always @ (*) begin
  q = 0;
  left = 10'b0;
  right = 10'b0;
  r = 10'b0;
  a_next = a;
  
  for (i = 0;i < 16;i = i+1)
  begin
    right[0] = 1;
    right[1] = r[17];
    right[17:2] = q;
    left[1:0] = a_next[31:30];
    left[17:2] = r[15:0];
    a_next[31:2] = a_next[29:0];
    
    if (r[17] == 1) begin
      r = left + right;
    end
    else begin
      r = left - right;
    end
    
    q[15:1] = q[14:0];
    q[0] = ~r[17];
    
  end
end

assign gmag = (q < 255) ? q[7:0] : 255;

endmodule