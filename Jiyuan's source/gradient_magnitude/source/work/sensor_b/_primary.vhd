library verilog;
use verilog.vl_types.all;
entity sensor_b is
    port(
        sensors         : in     vl_logic_vector(3 downto 0);
        error           : out    vl_logic
    );
end sensor_b;
