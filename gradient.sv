module gradient
  (
  input wire [1:0] grad_shift,
  input wire [7:0] seven_buffer_in [0:6][0:6],
  output wire [7:0] gx [0:4],
  output wire [7:0] gy [0:4]
  );  
 
   reg [10:0] temp_outx0, temp_outx1, temp_outx2, temp_outx3, temp_outx4;
   reg [10:0] temp_outy0, temp_outy1, temp_outy2, temp_outy3, temp_outy4;
   reg [7:0] resultx [0:4];
   reg [7:0] resulty [0:4];

   assign gx = resultx;
   assign gy = resulty;

always @* begin
    if(grad_shift == 2'b01) begin
       temp_outx0 = (seven_buffer_in[0][5] >> 2)+ (seven_buffer_in[1][5] >> 2) + (seven_buffer_in[2][5] >> 2);
      resultx[0] = temp_outx0 >> 2;
       
       temp_outx1 = (seven_buffer_in[1][5] >> 2) + (seven_buffer_in[2][5] >> 2) + (seven_buffer_in[3][5] >> 2);
      resultx[1] = temp_outx1 >> 2;
      
       temp_outx2 = (seven_buffer_in[2][5] >> 2) + (seven_buffer_in[3][5] >> 2) + (seven_buffer_in[4][5] >> 2);
      resultx[2] = temp_outx2 >> 2;
      
       temp_outx3 = (seven_buffer_in[3][5] >> 2) + (seven_buffer_in[4][5] >> 2) + (seven_buffer_in[5][5] >> 2);
      resultx[3] = temp_outx3 >> 2;
      
       temp_outx4 = (seven_buffer_in[4][5] >> 2) + (seven_buffer_in[5][5] >> 2) + (seven_buffer_in[6][5] >> 2);
      resultx[4] = temp_outx4 >> 2;
      

      
       temp_outy0 = (seven_buffer_in[1][4] >> 2)+ (seven_buffer_in[1][5] >> 2) + (seven_buffer_in[1][6] >> 2);
      resulty[0] = temp_outx0 >> 2;
       
       temp_outy1 = (seven_buffer_in[2][4] >> 2)+ (seven_buffer_in[2][5] >> 2) + (seven_buffer_in[2][6] >> 2);
      resulty[1] = temp_outy1 >> 2;
      
       temp_outy2 = (seven_buffer_in[3][4] >> 2)+ (seven_buffer_in[3][5] >> 2) + (seven_buffer_in[3][6] >> 2);
      resulty[2] = temp_outy2 >> 2;
       
       temp_outy3 = (seven_buffer_in[4][4] >> 2)+ (seven_buffer_in[4][5] >> 2) + (seven_buffer_in[4][6] >> 2);
      resulty[3] = temp_outx3 >> 2;

       temp_outx4 = (seven_buffer_in[5][4] >> 2)+ (seven_buffer_in[5][5] >> 2) + (seven_buffer_in[5][6] >> 2);
      resultx[4] = temp_outx4 >> 2;

       
   end else if (grad_shift == 2'b10) begin
       temp_outx0 = (seven_buffer_in[0][1] >> 2)+ (seven_buffer_in[1][1] >> 2) + (seven_buffer_in[2][1] >> 2);
      resultx[0] = temp_outx0 >> 2;
       
       temp_outx1 = (seven_buffer_in[1][1] >> 2) + (seven_buffer_in[2][1] >> 2) + (seven_buffer_in[3][1] >> 2);
      resultx[1] = temp_outx1 >> 2;
      
       temp_outx2 = (seven_buffer_in[2][1] >> 2) + (seven_buffer_in[3][1] >> 2) + (seven_buffer_in[4][1] >> 2);
      resultx[2] = temp_outx2 >> 2;
      
       temp_outx3 = (seven_buffer_in[3][1] >> 2) + (seven_buffer_in[4][1] >> 2) + (seven_buffer_in[5][1] >> 2);
      resultx[3] = temp_outx3 >> 2;
      
       temp_outx4 = (seven_buffer_in[4][1] >> 2) + (seven_buffer_in[5][1] >> 2) + (seven_buffer_in[6][1] >> 2);
      resultx[4] = temp_outx4 >> 2;
      

      
       temp_outy0 = (seven_buffer_in[1][0] >> 2)+ (seven_buffer_in[1][1] >> 2) + (seven_buffer_in[1][2] >> 2);
      resulty[0] = temp_outx0 >> 2;
       
       temp_outy1 = (seven_buffer_in[2][0] >> 2)+ (seven_buffer_in[2][1] >> 2) + (seven_buffer_in[2][2] >> 2);
      resulty[1] = temp_outy1 >> 2;
      
       temp_outy2 = (seven_buffer_in[3][0] >> 2)+ (seven_buffer_in[3][1] >> 2) + (seven_buffer_in[3][2] >> 2);
      resulty[2] = temp_outy2 >> 2;
       
       temp_outy3 = (seven_buffer_in[4][0] >> 2)+ (seven_buffer_in[4][1] >> 2) + (seven_buffer_in[4][2] >> 2);
      resulty[3] = temp_outx3 >> 2;
       
       temp_outx4 = (seven_buffer_in[5][0] >> 2)+ (seven_buffer_in[5][1] >> 2) + (seven_buffer_in[5][2] >> 2);
      resultx[4] = temp_outx4 >> 2;

       
  end else if (grad_shift == 2'b11) begin
        temp_outx0 = (seven_buffer_in[4][1] >> 2)+ (seven_buffer_in[5][1] >> 2) + (seven_buffer_in[6][1] >> 2);
      resultx[0] = temp_outx0 >> 2;
       
       temp_outx1 = (seven_buffer_in[4][2] >> 2) + (seven_buffer_in[5][2] >> 2) + (seven_buffer_in[6][2] >> 2);
      resultx[1] = temp_outx1 >> 2;
      
       temp_outx2 = (seven_buffer_in[4][3] >> 2) + (seven_buffer_in[5][3] >> 2) + (seven_buffer_in[6][3] >> 2);
      resultx[2] = temp_outx2 >> 2;
      
       temp_outx3 = (seven_buffer_in[4][4] >> 2) + (seven_buffer_in[5][4] >> 2) + (seven_buffer_in[6][4] >> 2);
      resultx[3] = temp_outx3 >> 2;
      
       temp_outx4 = (seven_buffer_in[4][5] >> 2) + (seven_buffer_in[5][5] >> 2) + (seven_buffer_in[6][5] >> 2);
      resultx[4] = temp_outx4 >> 2;
      

      
       temp_outy0 = (seven_buffer_in[5][0] >> 2)+ (seven_buffer_in[5][1] >> 2) + (seven_buffer_in[5][2] >> 2);
      resulty[0] = temp_outx0 >> 2;
       
       temp_outy1 = (seven_buffer_in[5][1] >> 2)+ (seven_buffer_in[5][2] >> 2) + (seven_buffer_in[5][3] >> 2);
      resulty[1] = temp_outy1 >> 2;
      
       temp_outy2 = (seven_buffer_in[5][2] >> 2)+ (seven_buffer_in[5][3] >> 2) + (seven_buffer_in[5][4] >> 2);
      resulty[2] = temp_outy2 >> 2;
       
       temp_outy3 = (seven_buffer_in[5][3] >> 2)+ (seven_buffer_in[5][4] >> 2) + (seven_buffer_in[5][5] >> 2);
      resulty[3] = temp_outx3 >> 2;
       
       temp_outx4 = (seven_buffer_in[5][4] >> 2)+ (seven_buffer_in[5][5] >> 2) + (seven_buffer_in[5][6] >> 2);
      resultx[4] = temp_outx4 >> 2;


end else begin
      temp_outx0 = 0;
      resultx[0] = 0;

      temp_outx1 = 0;
      resultx[1] = 0;
     
      temp_outx2 = 0;
      resultx[2] = 0;

      temp_outx3 = 0;
      resultx[3] = 0;

      temp_outx4 = 0;
      resultx[4] = 0;

 
      temp_outy0 = 0;
      resulty[0] = 0;

      temp_outy1 = 0;
      resulty[1] = 0;
     
      temp_outy2 = 0;
      resulty[2] = 0;

      temp_outy3 = 0;
      resulty[3] = 0;

      temp_outy4 = 0;
      resulty[4] = 0;

end
end
endmodule




  
  //assign gy = ((p4/2) + (p5/2) + (p6/2)) / 2;
  /*
  Convolution Kernel for y
    0   0   0
  0.5 0.5 0.5
    0   0   0
  Therefore, only p4, p5 and p6 is used in the calculation.
  */
  
