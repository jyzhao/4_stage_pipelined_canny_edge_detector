library verilog;
use verilog.vl_types.all;
entity pts_sr is
    generic(
        NUM_BITS        : integer := 4
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        shift_enable    : in     vl_logic;
        load_enable     : in     vl_logic;
        parallel_in     : in     vl_logic_vector;
        serial_out      : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_BITS : constant is 1;
end pts_sr;
