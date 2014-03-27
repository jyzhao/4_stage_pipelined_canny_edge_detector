// $Id: $
// File name:   tb_canny_edge.sv
// Created:     12/01/2013
// Author:      Eric Nielsen
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Test Bench for Main Controller Block

	`timescale 1 ns/1 ns
	module tb_canny_edge ();

   // Constant parameters
   localparam CLK_PERIOD = 10;    //100 MHZ clock

	integer num_rows = 520;
	integer num_columns = 520;
	integer i;
	integer j;

	// Test variables

		// Choose what the output is
		reg tb_gauss_image = 1'b0;
		reg tb_grad_image = 1'b0;
		reg tb_supp_image = 1'b0;
		reg tb_final_image = 1'b1;

		// General   
		 reg tb_clk;
		 reg tb_n_rst;
		 reg tb_start;
		 reg tb_error;

		// Common to all read SRAMs
		 reg tb_read_enable_r;
		 reg tb_mem_init_r;

		// For specific read SRAMs
		 reg [18:0] tb_add_a;
		 reg [18:0] tb_add_b;
		 reg [18:0] tb_add_c;
		 reg [18:0] tb_add_d;
		 reg [18:0] tb_add_e;
		 reg [18:0] tb_add_f;
		 reg [18:0] tb_add_g;
		 reg [18:0] tb_add_h;
		 reg [18:0] tb_add_i;
		 wire [7:0] tb_read_a;
		 wire [7:0] tb_read_b;
		 wire [7:0] tb_read_c;
		 wire [7:0] tb_read_d;
		 wire [7:0] tb_read_e;
		 wire [7:0] tb_read_f;
		 wire [7:0] tb_read_g;
		 wire [7:0] tb_read_h;
		 wire [7:0] tb_read_i;
		 wire [7:0] tb_read_a_wire;
		 wire [7:0] tb_read_b_wire;
		 wire [7:0] tb_read_c_wire;
		 wire [7:0] tb_read_d_wire;
		 wire [7:0] tb_read_e_wire;
		 wire [7:0] tb_read_f_wire;
		 wire [7:0] tb_read_g_wire;
		 wire [7:0] tb_read_h_wire;
		 wire [7:0] tb_read_i_wire;
		 assign tb_read_a_wire = (tb_read_enable_r == 1) ? tb_read_a : 16'hz;
		 assign tb_read_b_wire = (tb_read_enable_r == 1) ? tb_read_b : 16'hz;
		 assign tb_read_c_wire = (tb_read_enable_r == 1) ? tb_read_c : 16'hz;
		 assign tb_read_d_wire = (tb_read_enable_r == 1) ? tb_read_d : 16'hz;
		 assign tb_read_e_wire = (tb_read_enable_r == 1) ? tb_read_e : 16'hz;
		 assign tb_read_f_wire = (tb_read_enable_r == 1) ? tb_read_f : 16'hz;
		 assign tb_read_g_wire = (tb_read_enable_r == 1) ? tb_read_g : 16'hz;
		 assign tb_read_h_wire = (tb_read_enable_r == 1) ? tb_read_h : 16'hz;
		 assign tb_read_i_wire = (tb_read_enable_r == 1) ? tb_read_i : 16'hz;

		// For write SRAM
		 reg tb_write_enable_w;
		 reg tb_mem_clr_w;
		 reg tb_mem_dump_w;
		 reg [17:0] tb_write_address;
		 reg [7:0] tb_write_data;
		 wire [7:0] tb_write_data_wire;
		 assign tb_write_data_wire = (tb_write_enable_w == 1) ? tb_write_data : 16'hz;

   // Port map
   canny_edge dut
	(
		// General   
		.clk(tb_clk),
		.n_rst(tb_n_rst),
		.start(tb_start),
		.error(tb_error),

		// Common to all read SRAMs
		.read_enable_r(tb_read_enable_r),
		.mem_init_r(tb_mem_init_r),

		// For specific read SRAMs
		.add_a(tb_add_a),
		.add_b(tb_add_b),
		.add_c(tb_add_c),
		.add_d(tb_add_d),
		.add_e(tb_add_e),
		.add_f(tb_add_f),
		.add_g(tb_add_g),
		.add_h(tb_add_h),
		.add_i(tb_add_i),
		.read_a(tb_read_a_wire),
		.read_b(tb_read_b_wire),
		.read_c(tb_read_c_wire),
		.read_d(tb_read_d_wire),
		.read_e(tb_read_e_wire),
		.read_f(tb_read_f_wire),
		.read_g(tb_read_g_wire),
		.read_h(tb_read_h_wire),
		.read_i(tb_read_i_wire),

		// For write SRAM
		.write_enable_w(tb_write_enable_w),
		.mem_clr_w(tb_mem_clr_w),
		.mem_dump_w(tb_mem_dump_w),
		.write_address(tb_write_address),
		.write_data(tb_write_data),

		// Choose what the output is
		.gauss_image(tb_gauss_image),
		.grad_image(tb_grad_image),
		.supp_image(tb_supp_image),
		.final_image(tb_final_image)
	);

	off_chip_sram_write instance_write
	(
		.mem_clr(!tb_n_rst),
		.mem_init(1'b0),
		.mem_dump(tb_mem_dump_w),
		.verbose(1'b0),
		.init_file_number(1'b0),
		.dump_file_number(1'b0),
		.start_address(1'b0),
		.last_address(262143),
		.read_enable(1'b0),
		.write_enable(tb_write_enable_w),
		.address(tb_write_address),
		.data(tb_write_data_wire)
	);

	off_chip_sram_read instance_a
	(
		.mem_clr(1'b0),
		.mem_init(tb_mem_init_r),
		.mem_dump(1'b0),
		.verbose(1'b0),
		.init_file_number(1'b0),
		.dump_file_number(1'b0),
		.start_address(1'b0),
		.last_address(262143),
		.read_enable(tb_read_enable_r),
		.write_enable(1'b0),
		.address(tb_add_a),
		.data(tb_read_a)
	);

	off_chip_sram_read instance_b
	(
		.mem_clr(1'b0),
		.mem_init(tb_mem_init_r),
		.mem_dump(1'b0),
		.verbose(1'b0),
		.init_file_number(1'b0),
		.dump_file_number(1'b0),
		.start_address(1'b0),
		.last_address(262143),
		.read_enable(tb_read_enable_r),
		.write_enable(1'b0),
		.address(tb_add_b),
		.data(tb_read_b)
	);

	off_chip_sram_read instance_c
	(
		.mem_clr(1'b0),
		.mem_init(tb_mem_init_r),
		.mem_dump(1'b0),
		.verbose(1'b0),
		.init_file_number(1'b0),
		.dump_file_number(1'b0),
		.start_address(1'b0),
		.last_address(262143),
		.read_enable(tb_read_enable_r),
		.write_enable(1'b0),
		.address(tb_add_c),
		.data(tb_read_c)
	);

	off_chip_sram_read instance_d
	(
		.mem_clr(1'b0),
		.mem_init(tb_mem_init_r),
		.mem_dump(1'b0),
		.verbose(1'b0),
		.init_file_number(1'b0),
		.dump_file_number(1'b0),
		.start_address(1'b0),
		.last_address(262143),
		.read_enable(tb_read_enable_r),
		.write_enable(1'b0),
		.address(tb_add_d),
		.data(tb_read_d)
	);

	off_chip_sram_read instance_e
	(
		.mem_clr(1'b0),
		.mem_init(tb_mem_init_r),
		.mem_dump(1'b0),
		.verbose(1'b0),
		.init_file_number(1'b0),
		.dump_file_number(1'b0),
		.start_address(1'b0),
		.last_address(262143),
		.read_enable(tb_read_enable_r),
		.write_enable(1'b0),
		.address(tb_add_e),
		.data(tb_read_e)
	);

	off_chip_sram_read instance_f
	(
		.mem_clr(1'b0),
		.mem_init(tb_mem_init_r),
		.mem_dump(1'b0),
		.verbose(1'b0),
		.init_file_number(1'b0),
		.dump_file_number(1'b0),
		.start_address(1'b0),
		.last_address(262143),
		.read_enable(tb_read_enable_r),
		.write_enable(1'b0),
		.address(tb_add_f),
		.data(tb_read_f)
	);

	off_chip_sram_read instance_g
	(
		.mem_clr(1'b0),
		.mem_init(tb_mem_init_r),
		.mem_dump(1'b0),
		.verbose(1'b0),
		.init_file_number(1'b0),
		.dump_file_number(1'b0),
		.start_address(1'b0),
		.last_address(262143),
		.read_enable(tb_read_enable_r),
		.write_enable(1'b0),
		.address(tb_add_g),
		.data(tb_read_g)
	);

	off_chip_sram_read instance_h
	(
		.mem_clr(1'b0),
		.mem_init(tb_mem_init_r),
		.mem_dump(1'b0),
		.verbose(1'b0),
		.init_file_number(1'b0),
		.dump_file_number(1'b0),
		.start_address(1'b0),
		.last_address(262143),
		.read_enable(tb_read_enable_r),
		.write_enable(1'b0),
		.address(tb_add_h),
		.data(tb_read_h)
	);

	off_chip_sram_read instance_i
	(
		.mem_clr(1'b0),
		.mem_init(tb_mem_init_r),
		.mem_dump(1'b0),
		.verbose(1'b0),
		.init_file_number(1'b0),
		.dump_file_number(1'b0),
		.start_address(1'b0),
		.last_address(262143),
		.read_enable(tb_read_enable_r),
		.write_enable(1'b0),
		.address(tb_add_i),
		.data(tb_read_i)
	);

   // Generate tb_clk
   always begin
      tb_clk = 1'b0;
      #(CLK_PERIOD/2);
      tb_clk = 1'b1;
      #(CLK_PERIOD/2);
   end

	// Test code
	initial begin: TEST_BENCH

	// Reset system
	tb_start = 1'b0;
	tb_n_rst = 1'b0;
	#CLK_PERIOD;
	tb_n_rst = 1'b1;
	#CLK_PERIOD;
	#CLK_PERIOD;
	
	tb_mem_init_r = 1'b0;
	#(CLK_PERIOD);
	tb_mem_init_r = 1'b1;
	#(CLK_PERIOD);
	#(CLK_PERIOD);
	tb_mem_init_r = 1'b0;
	#(CLK_PERIOD);
	#(CLK_PERIOD);

	// Start processing
	tb_start = 1'b1;
	#(CLK_PERIOD);
	#(CLK_PERIOD);
	#(CLK_PERIOD);
	tb_start = 1'b0;

	// Wait for processing to finish
	for (i = 0; i < num_rows; i = i + 1) begin
		for (j = 0; j < num_columns; j = j + 1) begin
			#(CLK_PERIOD);
		end
	end

	for (j = 0; j < 100; j = j + 1) begin
		#(CLK_PERIOD);
	end 

	// Dump data to output file
	tb_mem_dump_w = 1'b1;
	#CLK_PERIOD;
	tb_mem_dump_w = 1'b0;

	$display("Memory Dumped!");

	end

endmodule
