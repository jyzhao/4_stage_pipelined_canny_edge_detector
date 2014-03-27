library verilog;
use verilog.vl_types.all;
entity sync is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        async_in        : in     vl_logic;
        sync_out        : out    vl_logic
    );
end sync;
