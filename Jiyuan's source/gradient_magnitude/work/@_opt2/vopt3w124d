library verilog;
use verilog.vl_types.all;
entity stp_sr is
    generic(
        NUM_BITS        : integer := 4;
        SHIFT_MSB       : integer := 1
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        shift_enable    : in     vl_logic;
        serial_in       : in     vl_logic;
        parallel_out    : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_BITS : constant is 1;
    attribute mti_svvh_generic_type of SHIFT_MSB : constant is 1;
end stp_sr;
