module gradient
  (
  input wire [1:0] grad_shift,
  input wire [7:0] seven_buffer_in [0:6][0:6],
  output wire [7:0] gx [0:4],
  output wire [7:0] gy [0:4]
  );  
 
   reg [10:0] temp_outx0, temp_outx1, temp_outx2, temp_outx3, temp_outx4;
   reg [10:0] temp_outy0, temp_outy1, temp_outy2, temp_outy3, temp_outy4;
   reg signed [8:0] resultx [0:4];
   reg signed [8:0] resulty [0:4];

   reg [7:0] properx [0:4];
   reg [7:0] propery [0:4];

   reg [8:0] properx_0;
   reg [8:0] properx_1;
   reg [8:0] properx_2;
   reg [8:0] properx_3;
   reg [8:0] properx_4;

   reg [8:0] propery_0;
   reg [8:0] propery_1;
   reg [8:0] propery_2;
   reg [8:0] propery_3;
   reg [8:0] propery_4;

   assign gx = properx;
   assign gy = propery;

always @* begin
    if(grad_shift == 2'b01) begin
       resultx[0] = (seven_buffer_in[0][6]+seven_buffer_in[2][6])- (seven_buffer_in[0][4]+seven_buffer_in[2][4]) + (seven_buffer_in[1][6] << 1) - (seven_buffer_in[1][4] << 1);
       
        resultx[1] = (seven_buffer_in[1][6]+seven_buffer_in[3][6])- (seven_buffer_in[1][4]+seven_buffer_in[3][4]) + (seven_buffer_in[2][6] << 1) - (seven_buffer_in[2][4] << 1);
      
       resultx[2] = (seven_buffer_in[2][6]+seven_buffer_in[4][6])- (seven_buffer_in[2][4]+seven_buffer_in[4][4]) + (seven_buffer_in[3][6] << 1) - (seven_buffer_in[3][4] << 1);
   
       resultx[3] = (seven_buffer_in[3][6]+seven_buffer_in[5][6])- (seven_buffer_in[3][4]+seven_buffer_in[5][4]) + (seven_buffer_in[4][6] << 1) - (seven_buffer_in[4][4] << 1);

      resultx[4] = (seven_buffer_in[4][6]+seven_buffer_in[6][6])- (seven_buffer_in[4][4]+seven_buffer_in[6][4]) + (seven_buffer_in[5][6] << 1) - (seven_buffer_in[5][4] << 1);


        resulty[0] = (seven_buffer_in[0][4]+seven_buffer_in[0][6])- (seven_buffer_in[2][4]+seven_buffer_in[2][6]) + (seven_buffer_in[0][5] << 1) - (seven_buffer_in[2][5] << 1);
       
        resulty[1] = (seven_buffer_in[1][4]+seven_buffer_in[1][6])- (seven_buffer_in[3][4]+seven_buffer_in[3][6]) + (seven_buffer_in[1][5] << 1) - (seven_buffer_in[3][5] << 1);
      
        resulty[2] = (seven_buffer_in[2][4]+seven_buffer_in[2][6])- (seven_buffer_in[4][4]+seven_buffer_in[4][6]) + (seven_buffer_in[2][5] << 1) - (seven_buffer_in[4][5] << 1);

        resulty[3] = (seven_buffer_in[3][4]+seven_buffer_in[3][6])- (seven_buffer_in[5][4]+seven_buffer_in[5][6]) + (seven_buffer_in[3][5] << 1) - (seven_buffer_in[5][5] << 1);

        resulty[4] = (seven_buffer_in[4][4]+seven_buffer_in[4][6])- (seven_buffer_in[6][4]+seven_buffer_in[6][6]) + (seven_buffer_in[4][5] << 1) - (seven_buffer_in[6][5] << 1);

       
   end else if (grad_shift == 2'b10) begin
       resultx[0] = (seven_buffer_in[0][2]+seven_buffer_in[2][2])- (seven_buffer_in[0][0]+seven_buffer_in[2][0]) + (seven_buffer_in[1][2] << 1) - (seven_buffer_in[1][0] << 1);

        resultx[1] = (seven_buffer_in[1][2]+seven_buffer_in[3][2])- (seven_buffer_in[1][0]+seven_buffer_in[3][0]) + (seven_buffer_in[2][2] << 1) - (seven_buffer_in[2][0] << 1);

       resultx[2] = (seven_buffer_in[2][2]+seven_buffer_in[4][2])- (seven_buffer_in[2][0]+seven_buffer_in[4][0]) + (seven_buffer_in[3][2] << 1) - (seven_buffer_in[3][0] << 1);

       resultx[3] = (seven_buffer_in[3][2]+seven_buffer_in[5][2])- (seven_buffer_in[3][0]+seven_buffer_in[5][0]) + (seven_buffer_in[4][2] << 1) - (seven_buffer_in[4][0] << 1);

       resultx[4] = (seven_buffer_in[4][2]+seven_buffer_in[6][2])- (seven_buffer_in[4][0]+seven_buffer_in[6][0]) + (seven_buffer_in[5][2] << 1) - (seven_buffer_in[5][0] << 1);


        resulty[0] = (seven_buffer_in[0][0]+seven_buffer_in[0][2])- (seven_buffer_in[2][0]+seven_buffer_in[2][2]) + (seven_buffer_in[0][1] << 1) - (seven_buffer_in[2][1] << 1);
       
       resulty[1] = (seven_buffer_in[1][0]+seven_buffer_in[1][2])- (seven_buffer_in[3][0]+seven_buffer_in[3][2]) + (seven_buffer_in[1][1] << 1) - (seven_buffer_in[3][1] << 1);

       resulty[2] = (seven_buffer_in[2][0]+seven_buffer_in[2][2])- (seven_buffer_in[4][0]+seven_buffer_in[4][2]) + (seven_buffer_in[2][1] << 1) - (seven_buffer_in[4][1] << 1);

       resulty[3] = (seven_buffer_in[3][0]+seven_buffer_in[3][2])- (seven_buffer_in[5][0]+seven_buffer_in[5][2]) + (seven_buffer_in[3][1] << 1) - (seven_buffer_in[5][1] << 1);

       resulty[4] = (seven_buffer_in[4][0]+seven_buffer_in[4][2])- (seven_buffer_in[6][0]+seven_buffer_in[6][2]) + (seven_buffer_in[4][1] << 1) - (seven_buffer_in[6][1] << 1);

       
  end else if (grad_shift == 2'b11) begin
       resultx[0] = (seven_buffer_in[4][2]+seven_buffer_in[6][2])- (seven_buffer_in[4][0]+seven_buffer_in[6][0]) + (seven_buffer_in[5][2] << 1) - (seven_buffer_in[5][0] << 1);
      
       resultx[1] = (seven_buffer_in[4][3]+seven_buffer_in[6][3])- (seven_buffer_in[4][1]+seven_buffer_in[6][1]) + (seven_buffer_in[5][3] << 1) - (seven_buffer_in[5][1] << 1);

       resultx[2] = (seven_buffer_in[4][4]+seven_buffer_in[6][4])- (seven_buffer_in[4][2]+seven_buffer_in[6][2]) + (seven_buffer_in[5][4] << 1) - (seven_buffer_in[5][2] << 1);

       resultx[3] = (seven_buffer_in[4][5]+seven_buffer_in[6][5])- (seven_buffer_in[4][3]+seven_buffer_in[6][3]) + (seven_buffer_in[5][5] << 1) - (seven_buffer_in[5][3] << 1);
      
       resultx[4] = (seven_buffer_in[4][6]+seven_buffer_in[6][6])- (seven_buffer_in[4][4]+seven_buffer_in[6][4]) + (seven_buffer_in[5][6] << 1) - (seven_buffer_in[5][4] << 1);


      resulty[0] = (seven_buffer_in[4][0]+seven_buffer_in[4][2])- (seven_buffer_in[6][0]+seven_buffer_in[6][2]) + (seven_buffer_in[4][1] << 1) - (seven_buffer_in[6][1] << 1);

      resulty[1] = (seven_buffer_in[4][1]+seven_buffer_in[4][3])- (seven_buffer_in[6][1]+seven_buffer_in[6][3]) + (seven_buffer_in[4][2] << 1) - (seven_buffer_in[6][2] << 1);

      resulty[2] = (seven_buffer_in[4][2]+seven_buffer_in[4][4])- (seven_buffer_in[6][2]+seven_buffer_in[6][4]) + (seven_buffer_in[4][3] << 1) - (seven_buffer_in[6][3] << 1);

      resulty[3] = (seven_buffer_in[4][3]+seven_buffer_in[4][5])- (seven_buffer_in[6][3]+seven_buffer_in[6][5]) + (seven_buffer_in[4][4] << 1) - (seven_buffer_in[6][4] << 1);

      resulty[4] = (seven_buffer_in[4][4]+seven_buffer_in[4][6])- (seven_buffer_in[6][4]+seven_buffer_in[6][6]) + (seven_buffer_in[4][5] << 1) - (seven_buffer_in[6][5] << 1);
 

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

if(resultx[0] < 0)
  properx[0] = 0;
else begin
  properx_0 = resultx[0];
  properx[0] = properx_0[7:0];
end
if(resultx[1] < 0)
  properx[1] = 0;
else begin
  properx_1 = resultx[1];
  properx[1] = properx_1[7:0];
end
if(resultx[2] < 0)
  properx[2] = 0;
else begin
  properx_2 = resultx[2];
  properx[2] = properx_2[7:0];
end
if(resultx[3] < 0)
  properx[3] = 0;
else begin
  properx_3 = resultx[3];
  properx[3] = properx_3[7:0];
end
if(resultx[4] < 0)
  properx[4] = 0;
else begin
  properx_4 = resultx[4];
  properx[4] = properx_4[7:0];
end

if(resulty[0] < 0)
  propery[0] = 0;
else begin
  propery_0 = resulty[0];
  propery[0] = propery_0[7:0];
end
if(resulty[1] < 0)
  propery[1] = 0;
else begin
  propery_1 = resulty[1];
  propery[1] = propery_1[7:0];
end
if(resulty[2] < 0)
  propery[2] = 0;
else begin
  propery_2 = resulty[2];
  propery[2] = propery_2[7:0];
end
if(resulty[3] < 0)
  propery[3] = 0;
else begin
  propery_3 = resulty[3];
  propery[3] = propery_3[7:0];
end
if(resulty[4] < 0)
  propery[4] = 0;
else begin
  propery_4 = resulty[4];
  propery[4] = propery_4[7:0];
end



end
endmodule




  
  //assign gy = ((p4/1) + (p5/1) + (p6/1)) / 1;
  /*
  Convolution Kernel for y
    0   0   0
  0.5 0.5 0.5
    0   0   0
  Therefore, only p4, p5 and p6 is used in the calculation.
  */
  
