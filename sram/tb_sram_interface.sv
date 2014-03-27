// $Id: $
// File name:   tb_sram_interface.sv
// Created:     12/01/2013
// Author:      Eric Nielsen
// Lab Section: 337-02
// Version:     1.0  Initial Design Entry
// Description: Test Bench for SRAM

	`timescale 1 ns/1 ns
	module tb_sram_interface ();

   // Constant parameters
   localparam CLK_PERIOD = 10;    //100 MHZ clock

		// Generic 
		reg tb_clk;
		reg tb_n_rst;   
		reg tb_start;
		reg [3:0] tb_to_add;

		// Read SRAM
		reg tb_read_enable_r;
		reg tb_mem_init_r;
		reg [18:0] tb_add_r;
		wire [7:0] tb_read_r;
		wire [7:0] tb_read_r_wire;
		assign tb_read_r_wire = (tb_read_enable_r == 1) ? tb_read_r : 16'hz;

		// For write SRAM
		reg tb_write_enable_w;
		reg tb_mem_dump_w;
		reg [17:0] tb_write_address;
		reg [7:0] tb_write_data;
		wire [7:0] tb_write_data_wire;
		assign tb_write_data_wire = (tb_write_enable_w == 1) ? tb_write_data : 16'hz;

		integer i;

	sram_interface dut
	(

		.read_data(tb_read_r),

		.write_data(tb_write_data)
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
		.last_address(21),
		.read_enable(1'b0),
		.write_enable(tb_write_enable_w),
		.address(tb_write_address),
		.data(tb_write_data_wire)
	);

	off_chip_sram_read instance_read
	(
		.mem_clr(1'b0),
		.mem_init(tb_mem_init_r),
		.mem_dump(1'b0),
		.verbose(1'b0),
		.init_file_number(1'b0),
		.dump_file_number(1'b0),
		.start_address(1'b0),
		.last_address(21),
		.read_enable(tb_read_enable_r),
		.write_enable(1'b0),
		.address(tb_add_r),
		.data(tb_read_r)
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

	tb_write_enable_w = 1'b0;
	tb_read_enable_r = 1'b0;

	// Reset system
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

	tb_write_enable_w = 1'b1;
	tb_read_enable_r = 1'b1;

	// Read in 20 values 
	for (i = 1; i <= 21; i = i + 1) begin
		tb_add_r = i;
		tb_write_address = i-1;
		#(CLK_PERIOD);
	end

	// Dump data to output file
	tb_mem_dump_w = 1'b1;
	#CLK_PERIOD;
	tb_mem_dump_w = 1'b0;

	$display("Memory Dumped!");

	end

endmodule
