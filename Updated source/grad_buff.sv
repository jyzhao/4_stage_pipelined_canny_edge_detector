module grad_buff
(
         input wire clk,
   input wire n_rst,
   input wire [7:0] gx [0:4] ,
   input wire [7:0] gy [0:4], 
   output wire [7:0] gx_new [0:4],
   output wire [7:0] gy_new [0:4]
);


        

         reg [7:0] q2 [0:4];
         reg [7:0] q3 [0:4];

           reg [7:0] d2 [0:4];
         reg [7:0] d3 [0:4]; 

     
          assign  gx_new = d2;
           assign  gy_new = d3;

 always @ (posedge clk,negedge n_rst) begin
    if (n_rst == 0) begin
        q2 <= {0,0,0,0,0};
        q3 <=  {0,0,0,0,0};

        d2 <= {0,0,0,0,0};
        d3 <=  {0,0,0,0,0};
    end else begin
        q2 <= gx;
        d2 <= q2;

        q3 <= gy;
        d3 <= q3;
    end
   end


endmodule 
