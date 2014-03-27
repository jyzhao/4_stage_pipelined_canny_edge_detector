module magnitude
  (
  input wire [7:0] gx [0:4], // gradient x, 8 bits
  input wire [7:0] gy [0:4], // gradient y, 8 bits
  output reg [7:0] gmag [0:4] // gradient magnitude, 8 bits
  );

	// First block
	reg [15:0] gx_sq_0;
	reg [15:0] gy_sq_0;
	reg [31:0] a_0;
	reg [31:0] a_next_0;
	reg [15:0] q_0;
	reg [17:0] left_0;
	reg [17:0] right_0;
	reg [17:0] r_0;
	assign gx_sq_0 = gx[0] * gx[0];
	assign gy_sq_0 = gy[0] * gy[0];
	assign a_0 = gx_sq_0 + gy_sq_0;

	// Second block
	reg [15:0] gx_sq_1;
	reg [15:0] gy_sq_1;
	reg [31:0] a_1;
	reg [31:0] a_next_1;
	reg [15:0] q_1;
	reg [17:0] left_1;
	reg [17:0] right_1;
	reg [17:0] r_1;
	assign gx_sq_1 = gx[1] * gx[1];
	assign gy_sq_1 = gy[1] * gy[1];
	assign a_1 = gx_sq_1 + gy_sq_1;

	// Third block
	reg [15:0] gx_sq_2;
	reg [15:0] gy_sq_2;
	reg [31:0] a_2;
	reg [31:0] a_next_2;
	reg [15:0] q_2;
	reg [17:0] left_2;
	reg [17:0] right_2;
	reg [17:0] r_2;
	assign gx_sq_2 = gx[2] * gx[2];
	assign gy_sq_2 = gy[2] * gy[2];
	assign a_2 = gx_sq_2 + gy_sq_2;

	// Fourth block
	reg [15:0] gx_sq_3;
	reg [15:0] gy_sq_3;
	reg [31:0] a_3;
	reg [31:0] a_next_3;
	reg [15:0] q_3;
	reg [17:0] left_3;
	reg [17:0] right_3;
	reg [17:0] r_3;
	assign gx_sq_3 = gx[3] * gx[3];
	assign gy_sq_3 = gy[3] * gy[3];
	assign a_3 = gx_sq_3 + gy_sq_3;

	// Fifth block
	reg [15:0] gx_sq_4;
	reg [15:0] gy_sq_4;
	reg [31:0] a_4;
	reg [31:0] a_next_4;
	reg [15:0] q_4;
	reg [17:0] left_4;
	reg [17:0] right_4;
	reg [17:0] r_4;
	assign gx_sq_4 = gx[4] * gx[4];
	assign gy_sq_4 = gy[4] * gy[4];
	assign a_4 = gx_sq_4 + gy_sq_4;

	int i;

	always @ (r_0, q_0, left_0, right_0, a_next_0, a_0,
				 r_1, q_1, left_1, right_1, a_next_1, a_1,
				 r_2, q_2, left_2, right_2, a_next_2, a_2,
				 r_3, q_3, left_3, right_3, a_next_3, a_3,
				 r_4, q_4, left_4, right_4, a_next_4, a_4) begin

		// First block
  		q_0 = 0;
  		left_0 = 18'b0;
  		right_0 = 18'b0;
  		r_0 = 18'b0;
  		a_next_0 = a_0;

		// Second block
  		q_1 = 0;
  		left_1 = 18'b0;
  		right_1 = 18'b0;
  		r_1 = 18'b0;
  		a_next_1 = a_1;

		// Third block
  		q_2 = 0;
  		left_2 = 18'b0;
  		right_2 = 18'b0;
  		r_2 = 18'b0;
  		a_next_2 = a_2;

		// Fourth block
  		q_3 = 0;
  		left_3 = 18'b0;
  		right_3 = 18'b0;
  		r_3 = 18'b0;
  		a_next_3 = a_3;

		// Fifth block
  		q_4 = 0;
  		left_4 = 18'b0;
  		right_4 = 18'b0;
  		r_4 = 18'b0;
  		a_next_4 = a_4;

  		for (i = 0; i < 16; i = i+1) begin

			// First block
    		right_0[0] = 1;
    		right_0[1] = r_0[17];
    		right_0[17:2] = q_0;
    		left_0[1:0] = a_next_0[31:30];
    		left_0[17:2] = r_0[15:0];
    		a_next_0[31:2] = a_next_0[29:0];
    		if (r_0[17] == 1) begin
      		r_0 = left_0 + right_0;
    		end else begin
      		r_0 = left_0 - right_0;
    		end
    		q_0[15:1] = q_0[14:0];
    		q_0[0] = ~r_0[17];

			// Second block
    		right_1[0] = 1;
    		right_1[1] = r_1[17];
    		right_1[17:2] = q_1;
    		left_1[1:0] = a_next_1[31:30];
    		left_1[17:2] = r_1[15:0];
    		a_next_1[31:2] = a_next_1[29:0];
    		if (r_1[17] == 1) begin
      		r_1 = left_1 + right_1;
    		end else begin
      		r_1 = left_1 - right_1;
    		end
    		q_1[15:1] = q_1[14:0];
    		q_1[0] = ~r_1[17];

			// Third block
    		right_2[0] = 1;
    		right_2[1] = r_2[17];
    		right_2[17:2] = q_2;
    		left_2[1:0] = a_next_2[31:30];
    		left_2[17:2] = r_2[15:0];
    		a_next_2[31:2] = a_next_2[29:0];
    		if (r_2[17] == 1) begin
      		r_2 = left_2 + right_2;
    		end else begin
      		r_2 = left_2 - right_2;
    		end
    		q_2[15:1] = q_2[14:0];
    		q_2[0] = ~r_2[17];

			// Fourth block
    		right_3[0] = 1;
    		right_3[1] = r_3[17];
    		right_3[17:2] = q_3;
    		left_3[1:0] = a_next_3[31:30];
    		left_3[17:2] = r_3[15:0];
    		a_next_3[31:2] = a_next_3[29:0];
    		if (r_3[17] == 1) begin
      		r_3 = left_3 + right_3;
    		end else begin
      		r_3 = left_3 - right_3;
    		end
    		q_3[15:1] = q_3[14:0];
    		q_3[0] = ~r_3[17];

			// Fifth block
    		right_4[0] = 1;
    		right_4[1] = r_4[17];
    		right_4[17:2] = q_4;
    		left_4[1:0] = a_next_4[31:30];
    		left_4[17:2] = r_4[15:0];
    		a_next_4[31:2] = a_next_4[29:0];
    		if (r_4[17] == 1) begin
      		r_4 = left_4 + right_4;
    		end else begin
      		r_4 = left_4 - right_4;
    		end
    		q_4[15:1] = q_4[14:0];
    		q_4[0] = ~r_4[17];
    
  		end
	end

	assign gmag[0] = (q_0 < 255) ? q_0[7:0] : 255;
	assign gmag[1] = (q_1 < 255) ? q_1[7:0] : 255;
	assign gmag[2] = (q_2 < 255) ? q_2[7:0] : 255;
	assign gmag[3] = (q_3 < 255) ? q_3[7:0] : 255;
	assign gmag[4] = (q_4 < 255) ? q_4[7:0] : 255;

endmodule
