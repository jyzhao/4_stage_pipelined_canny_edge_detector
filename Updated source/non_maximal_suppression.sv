
// $Id: mg47
// File name:   timer.sv
// Created:     11/20/2013
// Author:      Sukhyun Hong
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: .

module non_maximal_suppression
(


	input wire [7:0] five_buffer_in[0:4][0:4],
	input wire [7:0] Gx_buffer[0:4][0:4],
	input wire [7:0] Gy_buffer[0:4][0:4],

        input wire [1:0] shift_dir,
	output wire [7:0] non_max [0:2]

);

   reg [7:0] Gx_a;
   reg [7:0] Gx_b;
   reg [7:0] Gx_c;
   reg [7:0] Gy_a;
   reg [7:0] Gy_b;
   reg [7:0] Gy_c;

   reg [1:0] tangent_a;
   reg [1:0] tangent_b;
   reg [1:0] tangent_c;

   reg [9:0] New_gx_a;
   reg [9:0] New_gx_b;
   reg [9:0] New_gx_c;

   reg [9:0] temp_gx_a;
   reg [9:0] temp_gx_b;
   reg [9:0] temp_gx_c;

   reg [7:0] result [0:2];

   assign non_max = result;
   
   always @ (shift_dir) begin
	if (shift_dir == 2'b01) begin
		Gx_a = Gx_buffer[1][3];
		Gy_a = Gy_buffer[1][3];

		Gx_b = Gx_buffer[2][3];
		Gy_b = Gy_buffer[2][3];
	
		Gx_c = Gx_buffer[3][3];
		Gy_c = Gy_buffer[3][3];
	end
	else if (shift_dir == 2'b10) begin
		Gx_a = Gx_buffer[1][1];
		Gy_a = Gy_buffer[1][1];

		Gx_b = Gx_buffer[2][1];
		Gy_b = Gy_buffer[2][1];
	
		Gx_c = Gx_buffer[3][1];
		Gy_c = Gy_buffer[3][1];
	end
	else begin
  		Gx_a = Gx_buffer[3][1];
		Gy_a = Gy_buffer[3][1];

		Gx_b = Gx_buffer[3][2];
		Gy_b = Gy_buffer[3][2];
	
		Gx_c = Gx_buffer[3][3];
		Gy_c = Gy_buffer[3][3];
	end
   end
		
		

   //---------------------FIRST Gx,Gy,Tangent --------------------------
   always @ (Gx_a, Gy_a) begin
	if (Gx_a == 8'b00000001) begin
		if ( Gy_a > 8'b0000010) begin 
			tangent_a = 2'b10;
		end
		else if ((Gy_a == 8'b00000001) || (Gy_a == 8'b00000010)) begin
			tangent_a = 2'b01;
		end
		else begin
			tangent_a = 2'b00;
		end
	end
   	if( Gy_a < Gx_a) begin
		New_gx_a = Gx_a >> 1;
		if(New_gx_a > Gy_a) begin
		   tangent_a = 2'b00;
		end
		else begin
		   tangent_a = 2'b01;
	 	end
	end

	else if (Gy_a > Gx_a) begin
		temp_gx_a = Gx_a << 1;
		New_gx_a = temp_gx_a >> 2;
		if ((New_gx_a+temp_gx_a) > Gy_a) begin
			tangent_a = 2'b01;
		end
		else begin
			tangent_a = 2'b10;
		end
	end
	else begin
		tangent_a = 2'b01;
	end
   end
    
   // ----------------Second Gx,Gy,Tangent ----------------------
   always @ (Gx_b, Gy_b) begin
	if (Gx_b == 8'b00000001) begin
		if ( Gy_b > 8'b0000010) begin 
			tangent_b = 2'b10;
		end
		else if ((Gy_b == 8'b00000001) || (Gy_b == 8'b00000010)) begin
			tangent_b = 2'b01;
		end
		else begin
			tangent_b = 2'b00;
		end
	end
   	if( Gy_b < Gx_b) begin
		New_gx_b = Gx_b >> 1;
		if(New_gx_b > Gy_b) begin
		   tangent_b = 2'b00;
		end
		else begin
		   tangent_b= 2'b01;
	 	end
	end

	else if (Gy_b > Gx_b) begin
		temp_gx_b = Gx_b << 1;
		New_gx_b = temp_gx_b >> 2;
		if ((New_gx_b+temp_gx_b) > Gy_b) begin
			tangent_b = 2'b01;
		end
		else begin
			tangent_b = 2'b10;
		end
	end
	else begin
		tangent_b = 2'b01;
	end
   end


   // ----------------Third Gx,Gy,Tangent ----------------------
   always @ (Gx_c, Gy_c) begin
	if (Gx_c == 8'b00000001) begin
		if ( Gy_c > 8'b0000010) begin 
			tangent_c = 2'b10;
		end
		else if ((Gy_c == 8'b00000001) || (Gy_c == 8'b00000010)) begin
			tangent_c = 2'b01;
		end
		else begin
			tangent_c = 2'b00;
		end
	end
   	if( Gy_c < Gx_c) begin
		New_gx_c = Gx_c >> 1;
		if(New_gx_c > Gy_c) begin
		   tangent_c = 2'b00;
		end
		else begin
		   tangent_c= 2'b01;
	 	end
	end

	else if (Gy_c > Gx_c) begin
		temp_gx_c = Gx_c << 1;
		New_gx_c = temp_gx_c >> 2;
		if ((New_gx_c+temp_gx_c) > Gy_c) begin
			tangent_c = 2'b01;
		end
		else begin
			tangent_c = 2'b10;
		end
	end
	else begin
		tangent_c = 2'b01;
	end
   end

   // ---------------------------NON MAXIMAL SUPPRESSION PART ---------------------------------------
   always @* begin
	   if(shift_dir == 2'b01) begin    // Shift to Right
		if (tangent_a == 2'b00) begin  // First Angle 0 and 180 Degrees 
			if( five_buffer_in[1][3] > five_buffer_in[1][2] && five_buffer_in[1][3] > five_buffer_in[1][4]) begin
				result[0] = five_buffer_in[1][3];
			end
			else if ( five_buffer_in[1][3] == five_buffer_in[1][2] && five_buffer_in[1][3] == five_buffer_in[1][4]) begin
				result[0] = 8'b00000000;
			end
			else begin
				result[0] = 8'b00000000;
			end
		end
		else if (tangent_a == 2'b01) begin // First Angle 45 and 225 Degrees
			if( five_buffer_in[1][3] > five_buffer_in[2][2] && five_buffer_in[1][3] > five_buffer_in[0][4]) begin
				result[0] = five_buffer_in[1][3];
			end
			else if ( five_buffer_in[1][3] == five_buffer_in[2][2] && five_buffer_in[1][3] == five_buffer_in[0][4]) begin
				result[0] = 8'b00000000;
			end
			else begin
				result[0] = 8'b00000000;
			end
		end
		else begin //First Angle 90 and 270 Degrees
			if( five_buffer_in[1][3] > five_buffer_in[0][3] && five_buffer_in[1][3] > five_buffer_in[2][3]) begin
				result[0] = five_buffer_in[1][3];
			end
			else if ( five_buffer_in[1][3] == five_buffer_in[0][3] && five_buffer_in[1][3] == five_buffer_in[2][3]) begin
				result[0] = 8'b00000000;
			end
			else begin
				result[0] = 8'b00000000;
			end
		end

		if (tangent_b == 2'b00) begin // Second Angle 0 and 180 Degrees
			if( five_buffer_in[2][3] > five_buffer_in[2][2] && five_buffer_in[2][3] > five_buffer_in[2][4]) begin
				result[1] = five_buffer_in[2][3];
			end
			else if ( five_buffer_in[2][3] == five_buffer_in[2][2] && five_buffer_in[2][3] == five_buffer_in[2][4]) begin
				result[1] = 8'b00000000;
			end
			else begin
				result[1] = 8'b00000000;
			end
		end
		else if (tangent_b == 2'b01) begin //Second Angle 45 and 225 Degrees
			if( five_buffer_in[2][3] > five_buffer_in[3][2] && five_buffer_in[2][3] > five_buffer_in[1][4]) begin
				result[1] = five_buffer_in[2][3];
			end
			else if ( five_buffer_in[2][3] == five_buffer_in[3][2] && five_buffer_in[2][3] == five_buffer_in[1][4]) begin
				result[1] = 8'b00000000;
			end
			else begin
				result[1] = 8'b00000000;
			end
		end
		else begin //Second Angle 90 and 270 Degrees
			if( five_buffer_in[2][3] > five_buffer_in[1][3] && five_buffer_in[2][3] > five_buffer_in[3][3]) begin
				result[1] = five_buffer_in[2][3];
			end
			else if ( five_buffer_in[2][3] == five_buffer_in[1][3] && five_buffer_in[2][3] == five_buffer_in[3][3]) begin
				result[1] = 8'b00000000;
			end
			else begin
				result[1] = 8'b00000000;
			end
		end

		if (tangent_c == 2'b00) begin // Third Angle 0 and 180 Degrees
			if( five_buffer_in[3][3] > five_buffer_in[3][2] && five_buffer_in[3][3] > five_buffer_in[3][4]) begin
				result[2] = five_buffer_in[3][3];
			end
			else if ( five_buffer_in[3][3] == five_buffer_in[3][2] && five_buffer_in[3][3] == five_buffer_in[3][4]) begin
				result[2] = 8'b00000000;
			end
			else begin
				result[2] = 8'b00000000;
			end
		end
		else if (tangent_c == 2'b01) begin //Third Angle 45 and 225 Degrees
			if( five_buffer_in[3][3] > five_buffer_in[4][2] && five_buffer_in[3][3] > five_buffer_in[2][4]) begin
				result[2] = five_buffer_in[3][3];
			end
			else if ( five_buffer_in[3][3] == five_buffer_in[4][2] && five_buffer_in[3][3] == five_buffer_in[2][4]) begin
				result[2] = 8'b00000000;
			end
			else begin
				result[2] = 8'b00000000;
			end
		end
		else begin //Third Angle 90 and 270 Degrees
			if( five_buffer_in[3][3] > five_buffer_in[2][3] && five_buffer_in[3][3] > five_buffer_in[4][3]) begin
				result[2] = five_buffer_in[3][3];
			end
			else if ( five_buffer_in[3][3] == five_buffer_in[2][3] && five_buffer_in[3][3] == five_buffer_in[4][3]) begin
				result[2] = 8'b00000000;
			end
			else begin
				result[2] = 8'b00000000;
			end
		end

	   end
	   else if (shift_dir == 2'b10) begin // Shift to Left
		if (tangent_a == 2'b00) begin  // First Angle 0 and 180 Degrees 
			if( five_buffer_in[1][1] > five_buffer_in[1][0] && five_buffer_in[1][1] > five_buffer_in[1][2]) begin
				result[0] = five_buffer_in[1][1];
			end
			else if ( five_buffer_in[1][1] == five_buffer_in[1][0] && five_buffer_in[1][1] == five_buffer_in[1][2]) begin
				result[0] = 8'b00000000;
			end
			else begin
				result[0] = 8'b00000000;
			end
		end
		else if (tangent_a == 2'b01) begin // First Angle 45 and 225 Degrees
			if( five_buffer_in[1][1] > five_buffer_in[2][0] && five_buffer_in[1][1] > five_buffer_in[0][2]) begin
				result[0] = five_buffer_in[1][1];
			end
			else if ( five_buffer_in[1][1] == five_buffer_in[2][0] && five_buffer_in[1][1] == five_buffer_in[0][2]) begin
				result[0] = 8'b00000000;
			end
			else begin
				result[0] = 8'b00000000;
			end
		end
		else begin //First Angle 90 and 270 Degrees
			if( five_buffer_in[1][1] > five_buffer_in[0][1] && five_buffer_in[1][1] > five_buffer_in[2][1]) begin
				result[0] = five_buffer_in[1][1];
			end
			else if ( five_buffer_in[1][1] == five_buffer_in[0][1] && five_buffer_in[1][1] == five_buffer_in[2][1]) begin
				result[0] = 8'b00000000;
			end
			else begin
				result[0] = 8'b00000000;
			end
		end

		if (tangent_b == 2'b00) begin // Second Angle 0 and 180 Degrees
			if( five_buffer_in[2][1] > five_buffer_in[2][0] && five_buffer_in[2][1] > five_buffer_in[2][2]) begin
				result[1] = five_buffer_in[2][1];
			end
			else if ( five_buffer_in[2][1] == five_buffer_in[2][0] && five_buffer_in[2][1] == five_buffer_in[2][2]) begin
				result[1] = 8'b00000000;
			end
			else begin
				result[1] = 8'b00000000;
			end
		end
		else if (tangent_b == 2'b01) begin //Second Angle 45 and 225 Degrees
			if( five_buffer_in[2][1] > five_buffer_in[3][0] && five_buffer_in[2][1] > five_buffer_in[1][2]) begin
				result[1] = five_buffer_in[2][1];
			end
			else if ( five_buffer_in[2][1] == five_buffer_in[3][0] && five_buffer_in[2][1] == five_buffer_in[1][2]) begin
				result[1] = 8'b00000000;
			end
			else begin
				result[1] = 8'b00000000;
			end
		end
		else begin //Second Angle 90 and 270 Degrees
			if( five_buffer_in[2][1] > five_buffer_in[1][1] && five_buffer_in[2][1] > five_buffer_in[3][1]) begin
				result[1] = five_buffer_in[2][1];
			end
			else if ( five_buffer_in[2][1] == five_buffer_in[1][1] && five_buffer_in[2][1] == five_buffer_in[3][1]) begin
				result[1] = 8'b00000000;
			end
			else begin
				result[1] = 8'b00000000;
			end
		end

		if (tangent_c == 2'b00) begin // Third Angle 0 and 180 Degrees
			if( five_buffer_in[3][1] > five_buffer_in[3][0] && five_buffer_in[3][1] > five_buffer_in[3][2]) begin
				result[2] = five_buffer_in[3][1];
			end
			else if ( five_buffer_in[3][1] == five_buffer_in[3][0] && five_buffer_in[3][1] == five_buffer_in[3][2]) begin
				result[2] = 8'b00000000;
			end
			else begin
				result[2] = 8'b00000000;
			end
		end
		else if (tangent_c == 2'b01) begin //Third Angle 45 and 225 Degrees
			if( five_buffer_in[3][1] > five_buffer_in[4][0] && five_buffer_in[3][1] > five_buffer_in[2][2]) begin
				result[2] = five_buffer_in[3][1];
			end
			else if ( five_buffer_in[3][1] == five_buffer_in[4][0] && five_buffer_in[3][1] == five_buffer_in[2][2]) begin
				result[2] = 8'b00000000;
			end
			else begin
				result[2] = 8'b00000000;
			end
		end
		else begin //Third Angle 90 and 270 Degrees
			if( five_buffer_in[3][1] > five_buffer_in[2][1] && five_buffer_in[3][1] > five_buffer_in[4][1]) begin
				result[2] = five_buffer_in[3][1];
			end
			else if ( five_buffer_in[3][1] == five_buffer_in[2][1] && five_buffer_in[3][1] == five_buffer_in[4][1]) begin
				result[2] = 8'b00000000;
			end
			else begin
				result[2] = 8'b00000000;
			end
		end
	   end
	   else /*if (shift_dir == 2'b11)*/ begin //Shift to Bottom
		if (tangent_a == 2'b00) begin  // First Angle 0 and 180 Degrees 
			if( five_buffer_in[3][1] > five_buffer_in[3][0] && five_buffer_in[3][1] > five_buffer_in[3][2]) begin
				result[0] = five_buffer_in[3][1];
			end
			else if ( five_buffer_in[3][1] == five_buffer_in[3][0] && five_buffer_in[3][1] == five_buffer_in[3][2]) begin
				result[0] = 8'b00000000;
			end
			else begin
				result[0] = 8'b00000000;
			end
		end
		else if (tangent_a == 2'b01) begin // First Angle 45 and 225 Degrees
			if( five_buffer_in[3][1] > five_buffer_in[4][0] && five_buffer_in[3][1] > five_buffer_in[2][2]) begin
				result[0] = five_buffer_in[3][1];
			end
			else if ( five_buffer_in[3][1] == five_buffer_in[4][0] && five_buffer_in[3][1] == five_buffer_in[2][2]) begin
				result[0] = 8'b00000000;
			end
			else begin
				result[0] = 8'b00000000;
			end
		end
		else begin //First Angle 90 and 270 Degrees
			if( five_buffer_in[3][1] > five_buffer_in[2][1] && five_buffer_in[3][1] > five_buffer_in[4][1]) begin
				result[0] = five_buffer_in[3][1];
			end
			else if ( five_buffer_in[3][1] == five_buffer_in[2][1] && five_buffer_in[3][1] == five_buffer_in[4][1]) begin
				result[0] = 8'b00000000;
			end
			else begin
				result[0] = 8'b00000000;
			end
		end

		if (tangent_b == 2'b00) begin // Second Angle 0 and 180 Degrees
			if( five_buffer_in[3][2] > five_buffer_in[3][1] && five_buffer_in[3][2] > five_buffer_in[3][3]) begin
				result[1] = five_buffer_in[3][2];
			end
			else if ( five_buffer_in[3][2] == five_buffer_in[3][1] && five_buffer_in[3][2] == five_buffer_in[3][3]) begin
				result[1] = 8'b00000000;
			end
			else begin
				result[1] = 8'b00000000;
			end
		end
		else if (tangent_b == 2'b01) begin //Second Angle 45 and 225 Degrees
			if( five_buffer_in[3][2] > five_buffer_in[4][1] && five_buffer_in[3][2] > five_buffer_in[2][3]) begin
				result[1] = five_buffer_in[3][2];
			end
			else if ( five_buffer_in[3][2] == five_buffer_in[4][1] && five_buffer_in[3][2] == five_buffer_in[2][3]) begin
				result[1] = 8'b00000000;
			end
			else begin
				result[1] = 8'b00000000;
			end
		end
		else begin //Second Angle 90 and 270 Degrees
			if( five_buffer_in[3][2] > five_buffer_in[2][2] && five_buffer_in[3][2] > five_buffer_in[4][2]) begin
				result[1] = five_buffer_in[3][2];
			end
			else if ( five_buffer_in[3][2] == five_buffer_in[2][2] && five_buffer_in[3][2] == five_buffer_in[4][2]) begin
				result[1] = 8'b00000000;
			end
			else begin
				result[1] = 8'b00000000;
			end
		end

		if (tangent_c == 2'b00) begin // Third Angle 0 and 180 Degrees
			if( five_buffer_in[3][3] > five_buffer_in[3][2] && five_buffer_in[3][3] > five_buffer_in[3][4]) begin
				result[2] = five_buffer_in[3][3];
			end
			else if ( five_buffer_in[3][3] == five_buffer_in[3][2] && five_buffer_in[3][3] == five_buffer_in[3][4]) begin
				result[2] = 8'b00000000;
			end
			else begin
				result[2] = 8'b00000000;
			end
		end
		else if (tangent_c == 2'b01) begin //Third Angle 45 and 225 Degrees
			if( five_buffer_in[3][3] > five_buffer_in[4][2] && five_buffer_in[3][3] > five_buffer_in[2][4]) begin
				result[2] = five_buffer_in[3][3];
			end
			else if ( five_buffer_in[3][3] == five_buffer_in[4][2] && five_buffer_in[3][3] == five_buffer_in[2][4]) begin
				result[2] = 8'b00000000;
			end
			else begin
				result[2] = 8'b00000000;
			end
		end
		else begin //Third Angle 90 and 270 Degrees
			if( five_buffer_in[3][3] > five_buffer_in[2][3] && five_buffer_in[3][3] > five_buffer_in[4][3]) begin
				result[2] = five_buffer_in[3][3];
			end
			else if ( five_buffer_in[3][3] == five_buffer_in[2][3] && five_buffer_in[3][3] == five_buffer_in[4][3]) begin
				result[2] = 8'b00000000;
			end
			else begin
				result[2] = 8'b00000000;
			end
		end
	   end
/*	   else begin
		// SET IT TO ALL ZEROS
		result[0] = 8'b00000000;
		result[1] = 8'b00000000;
		result[2] = 8'b00000000;
	   end*/

   end

endmodule

