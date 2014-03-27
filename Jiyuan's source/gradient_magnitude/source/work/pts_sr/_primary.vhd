library verilog;
use verilog.vl_types.all;
entity pts_sr is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        shift_enable    : in     vl_logic;
        load_enable     : in     vl_logic;
        parallel_in     : in     vl_logic_vector(3 downto 0);
        serial_out      : out    vl_logic
    );
end pts_sr;
